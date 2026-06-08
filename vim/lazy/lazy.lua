-- Bootstrap lazy.nvim
-- Enable true color (24-bit) before anything else so theme and airline use full terminal colors.
-- If colors still look limited, set TERM=xterm-256color (or tmux-256color in tmux) and, in tmux:
--   set -g default-terminal "tmux-256color"
--   set -ag terminal-overrides ",xterm-256color:RGB"
vim.opt.termguicolors = true
vim.opt.background = "dark"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Discover this file's directory so we can load specs and settings from vim/lazy
local this_file = debug.getinfo(1, "S").source:sub(2)
local lazy_root = vim.fn.fnamemodify(this_file, ":h")

-- Load options and keymaps ported from init.vim (before plugins)
dofile(lazy_root .. "/options.lua")
-- Vimscript: EscapeText, PasteEscapedRegister, Coc insert maps, autocmds (must run before keymaps.lua)
vim.cmd("source " .. vim.fn.fnameescape(lazy_root .. "/legacy.vim"))
dofile(lazy_root .. "/keymaps.lua")
-- Bulgarian keyboard layout (same path as init.vim)
vim.cmd("source " .. vim.fn.fnameescape(lazy_root .. "/../mappings/bg-keyboard-mapings.vim"))

local function lazy_spec(name)
  return dofile(lazy_root .. "/plugins/" .. name .. ".lua")
end

-- Setup lazy.nvim
require("lazy").setup({
  -- lazy.nvim wires `lazy.core.cache` to Neovim's `vim.loader` (bytecode under ~/.cache/nvim/luac).
  -- RFC2396-encoded paths for deep modules (e.g. codecompanion slash_commands) can exceed NAME_MAX
  -- (ENAMETOOLONG). Disabling this cache is the recommended workaround; impact is negligible.
  -- See https://github.com/neovim/neovim/issues/29372
  performance = {
    cache = { enabled = false },
  },
  spec = {
    -- lazy_spec("auto-session"),
    -- lazy_spec("avante"),
    -- lazy_spec("codecompanion"),
    lazy_spec("copilot"),
    lazy_spec("core"),
    lazy_spec("coverage"),
    lazy_spec("espresso-libre"),
    lazy_spec("fzf"),
    lazy_spec("grug-far"),
    lazy_spec("ibl"),
    lazy_spec("mini-animate"),
    lazy_spec("nvim-treesitter"),
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "espresso-libre" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
