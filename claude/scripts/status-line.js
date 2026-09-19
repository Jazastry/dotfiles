/* eslint-disable sonarjs/no-os-command-from-path, sonarjs/os-command */
import fs from "fs";
import path from "path";
import os from "os";
import { execSync, spawn } from "child_process";
import { fileURLToPath } from "url";

const SCRIPT_PATH = fileURLToPath(import.meta.url);

const HOME_DIR =
	process.env.HOME ||
	process.env.USERPROFILE ||
	process.env.HOMEPATH ||
	os.homedir?.();

const DEFAULT_CACHE_DIR = path.join(
	HOME_DIR,
	process.platform === "win32" ? "AppData/Local/Temp" : ".cache",
);
// Absolute override for tests; otherwise the platform default under $HOME.
const CACHE_DIR = process.env.STATUS_LINE_CACHE_DIR
	? path.resolve(process.env.STATUS_LINE_CACHE_DIR)
	: DEFAULT_CACHE_DIR;

const OAUTH_CACHE_FILE = path.join(CACHE_DIR, "claude-oauth-usage.json");
const OAUTH_LOCK_FILE = path.join(CACHE_DIR, "claude-oauth-usage.lock");
const OAUTH_ATTEMPT_FILE = path.join(
	CACHE_DIR,
	"claude-oauth-usage.attempt.json",
);
const OAUTH_CACHE_MAX_AGE_MS = 60_000; // 1 minute
const OAUTH_LOCK_STALE_MS = 30_000; // steal lock if holder died mid-fetch
const OAUTH_FETCH_TIMEOUT_MS = 5_000;

function readJsonFile(filePath) {
	try {
		if (!fs.existsSync(filePath)) return null;
		return JSON.parse(fs.readFileSync(filePath, "utf-8"));
	} catch {
		return null;
	}
}

function writeJsonAtomic(filePath, value) {
	const tmp = `${filePath}.tmp`;
	fs.writeFileSync(tmp, JSON.stringify(value));
	fs.renameSync(tmp, filePath);
}

/** Prefer last successful fetch only; ignore ok:false / partial payloads. */
function readFetchedUsage(cacheFile) {
	const data = readJsonFile(cacheFile);
	if (
		data?.ok === true &&
		typeof data.used === "number" &&
		typeof data.limit === "number" &&
		typeof data.percent === "number"
	) {
		return data;
	}
	return null;
}

function tryAcquireLock(lockPath, staleMs) {
	try {
		const fd = fs.openSync(lockPath, "wx");
		fs.writeFileSync(fd, `${process.pid}\n`);
		fs.closeSync(fd);
		return true;
	} catch (err) {
		if (err?.code !== "EEXIST") return false;
		try {
			const age = Date.now() - (fs.statSync(lockPath).mtimeMs || 0);
			if (age > staleMs) {
				fs.unlinkSync(lockPath);
				return tryAcquireLock(lockPath, staleMs);
			}
		} catch {
			// ignore
		}
		return false;
	}
}

function releaseLock(lockPath) {
	try {
		fs.unlinkSync(lockPath);
	} catch {
		// ignore
	}
}

function recordAttempt(extra = {}) {
	try {
		writeJsonAtomic(OAUTH_ATTEMPT_FILE, {
			lastAttemptAt: Date.now(),
			...extra,
		});
	} catch {
		// ignore
	}
}

function shouldRefreshOauth(fetched) {
	const now = Date.now();
	if (fetched?.fetchedAt && now - fetched.fetchedAt < OAUTH_CACHE_MAX_AGE_MS) {
		return false;
	}
	const attempt = readJsonFile(OAUTH_ATTEMPT_FILE);
	if (
		attempt?.lastAttemptAt &&
		now - attempt.lastAttemptAt < OAUTH_CACHE_MAX_AGE_MS
	) {
		return false;
	}
	if (fs.existsSync(OAUTH_LOCK_FILE)) {
		try {
			const age = now - (fs.statSync(OAUTH_LOCK_FILE).mtimeMs || 0);
			if (age <= OAUTH_LOCK_STALE_MS) return false;
		} catch {
			// ignore
		}
	}
	return true;
}

function scheduleOauthRefresh() {
	try {
		const child = spawn(process.execPath, [SCRIPT_PATH, "--refresh-oauth"], {
			detached: true,
			stdio: "ignore",
			env: process.env,
		});
		child.unref();
	} catch {
		// ignore — display falls back to last-good or approximate
	}
}

async function refreshOauthUsage() {
	fs.mkdirSync(CACHE_DIR, { recursive: true });
	if (!tryAcquireLock(OAUTH_LOCK_FILE, OAUTH_LOCK_STALE_MS)) {
		return;
	}

	recordAttempt({ phase: "started" });

	try {
		const credsPath = path.join(HOME_DIR, ".claude", ".credentials.json");
		const creds = JSON.parse(fs.readFileSync(credsPath, "utf-8"));
		const token = creds.claudeAiOauth?.accessToken;
		if (!token) throw new Error("no token");

		const controller = new AbortController();
		const timeout = setTimeout(
			() => controller.abort(),
			OAUTH_FETCH_TIMEOUT_MS,
		);
		let res;
		try {
			res = await fetch("https://api.anthropic.com/api/oauth/usage", {
				headers: {
					Authorization: `Bearer ${token}`,
					"Content-Type": "application/json",
				},
				signal: controller.signal,
			});
		} finally {
			clearTimeout(timeout);
		}

		if (!res.ok) {
			recordAttempt({ phase: "failed", status: res.status });
			return;
		}

		const json = await res.json();
		const used = json.spend?.used;
		const limit = json.spend?.limit;
		const percent = json.spend?.percent;
		if (
			used?.amount_minor == null ||
			limit?.amount_minor == null ||
			percent == null
		) {
			recordAttempt({ phase: "failed", reason: "incomplete_payload" });
			return;
		}

		// Success only — never overwrite last-good with ok:false.
		writeJsonAtomic(OAUTH_CACHE_FILE, {
			fetchedAt: Date.now(),
			limit: limit.amount_minor / 10 ** (limit.exponent ?? 2),
			ok: true,
			percent,
			used: used.amount_minor / 10 ** (used.exponent ?? 2),
		});
		recordAttempt({ phase: "ok" });
	} catch (err) {
		recordAttempt({
			phase: "failed",
			reason: err?.name === "AbortError" ? "timeout" : "error",
		});
	} finally {
		releaseLock(OAUTH_LOCK_FILE);
	}
}

if (process.argv.includes("--refresh-oauth")) {
	refreshOauthUsage().finally(() => process.exit(0));
} else {
	let input = "";
	let output = [];
	process.stdin.on("data", (chunk) => (input += chunk));
	process.stdin.on("end", () => {
		try {
			const data = JSON.parse(input);
			const dir = path.basename(data.workspace.current_dir);
			output.push(`📁 ${dir}`);

			const GREEN = "\x1b[32m",
				YELLOW = "\x1b[33m",
				RESET = "\x1b[0m";

			try {
				execSync("git rev-parse --git-dir", { stdio: "ignore" });
				const branch = execSync("git branch --show-current", {
					encoding: "utf8",
				}).trim();
				const staged = execSync("git diff --cached --numstat", {
					encoding: "utf8",
				})
					.trim()
					.split("\n")
					.filter(Boolean).length;
				const modified = execSync("git diff --numstat", { encoding: "utf8" })
					.trim()
					.split("\n")
					.filter(Boolean).length;

				let gitStatus = staged ? `${GREEN}+${staged}${RESET}` : "";
				gitStatus += modified ? `${YELLOW}~${modified}${RESET}` : "";

				output.push(`🌿 ${branch} ${gitStatus}`);
			} catch {}

			const MODEL = data.model?.display_name || "Unknown";

			const PCT = Math.floor(
				parseFloat(data.context_window?.used_percentage || 0),
			);
			const DURATION_MS = data.cost?.total_duration_ms || 0;
			const COST = data.cost?.total_cost_usd || 0;

			const now = new Date();
			const CURRENT_MONTH = now.toISOString().slice(0, 7);

			const CACHE_FILE = path.join(CACHE_DIR, "claude-monthly-cost.json");
			const CACHE_MAX_AGE = 300; // 5 minutes

			fs.mkdirSync(CACHE_DIR, { recursive: true });

			const cacheStale =
				!fs.existsSync(CACHE_FILE) ||
				(Date.now() -
					fs.statSync(CACHE_FILE, { throwIfNoEntry: false })?.mtimeMs || 0) >
					CACHE_MAX_AGE * 1000;

			if (cacheStale) {
				// Background refresh (non-blocking)
				setImmediate(() => {
					try {
						const ccusageOutput = execSync(
							"npx ccusage@latest monthly --json",
							{
								encoding: "utf-8",
								stdio: ["pipe", "pipe", "ignore"],
							},
						);
						fs.writeFileSync(CACHE_FILE + ".tmp", ccusageOutput);
						fs.renameSync(CACHE_FILE + ".tmp", CACHE_FILE);
					} catch {
						// Silently fail - cache update is optional
					}
				});
			}

			let MONTHLY_COST = "n/a";
			try {
				if (fs.existsSync(CACHE_FILE)) {
					const cacheData = JSON.parse(fs.readFileSync(CACHE_FILE, "utf-8"));
					const monthData = cacheData.monthly?.find(
						(m) => m.period === CURRENT_MONTH,
					);
					if (monthData?.totalCost) {
						MONTHLY_COST = monthData.totalCost.toFixed(2);
					}
				}
			} catch {
				// Silently fail - use default "n/a"
			}

			const fetched = readFetchedUsage(OAUTH_CACHE_FILE);
			if (shouldRefreshOauth(fetched)) {
				scheduleOauthRefresh();
			}

			// Prefer last successful oauth fetch; approximate only when never fetched.
			const MONTHLY_DISPLAY = fetched
				? `$${fetched.used.toFixed(2)}/$${fetched.limit.toFixed(2)} (${fetched.percent}%)`
				: `~$${MONTHLY_COST}`;

			const DURATION_SEC = Math.floor(DURATION_MS / 1000);
			const MINS = Math.floor(DURATION_SEC / 60);
			const SECS = DURATION_SEC % 60;

			const FILLED = Math.floor(PCT / 10);
			const EMPTY = 10 - FILLED;
			const BAR = "▓".repeat(FILLED) + "░".repeat(EMPTY);

			output.push(`\n${MODEL}`);
			output.push(`Context: ${BAR} ${String(PCT).padStart(3, " ")}%`);
			output.push(`Session: $${COST.toFixed(2)}`);
			output.push(`Usage: ${MONTHLY_DISPLAY}`);
			output.push(`${MINS}m ${SECS}s`);

			console.info(output.join(" | "));
		} catch (e) {
			console.info("status line could not load: ", e);
		}
	});
}
