-- General keymaps ported from init.vim (KEYMAPPINGS + COC sections).
-- legacy.vim must load first (PasteEscapedRegister, Coc insert maps).

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { silent = true }, opts or {}))
end

local function plug(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { remap = true, silent = true, desc = desc })
end

-- Navigate between splits
map("n", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Window left" })
map("n", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Window down" })
map("n", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Window up" })
map("n", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Window right" })

-- Next/prev buffer
map("n", "<C-PageUp>", "<Cmd>bp<CR>", { desc = "Prev buffer" })
map("n", "<C-PageDown>", "<Cmd>bn<CR>", { desc = "Next buffer" })

-- Resize splits
map("n", "<space>l", "<Cmd>vertical resize +5<CR>", { desc = "Resize width +5" })
map("n", "<space>h", "<Cmd>vertical resize -5<CR>", { desc = "Resize width -5" })
map("n", "<space>j", "<Cmd>resize +5<CR>", { desc = "Resize height +5" })
map("n", "<space>k", "<Cmd>resize -5<CR>", { desc = "Resize height -5" })

-- Remove trailing whitespace and save
map(
  "n",
  "<space>c",
  ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>:w<CR>",
  { desc = "Trim trailing whitespace" }
)

-- Copy to clipboard (unnamed plus is set in options via clipboard)
map("n", "<C-c>", '"+y', { desc = "Copy to clipboard" })

-- Copy file path to clipboard
map("n", ",cs", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative path" })
map("n", ",cl", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy full path" })

-- Turn off search highlight (init.vim used comma leader; keep ,<space>)
map("n", ",<space>", "<Cmd>nohlsearch<CR>", { desc = "No highlight search" })

-- Open Ack (prompt for pattern; finish the quoted pattern then Enter).
-- Do not use silent=true here: it breaks "pending" : command-line mappings (see :help map-silent).
vim.keymap.set("n", "<space>f", ":Ack! '", { silent = false, desc = "Ack search" })

-- Close quickfix
map("n", "<space>d", "<Cmd>cclose<CR>", { desc = "Close quickfix" })

-- Git gutter next hunk
map("n", "<space>g", "<Cmd>GitGutterNextHunk<CR>zz", { desc = "Next git hunk" })

-- Toggle spell
map("n", "<space>sp", "<Cmd>setlocal spell! spelllang=en_us<CR>", { desc = "Toggle spell" })

-- Escape terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })

-- Replace selection with default register without yanking (visual)
map("v", "p", '"_dP', { desc = "Paste over selection" })

-- FZF: <space>p and <space><Enter> are defined in lazy/plugins/fzf.lua

-- Paste escaped register (old leader was comma → ,P / ,p)
map("n", ",P", "<Cmd>call PasteEscapedRegister('before')<CR>", { desc = "Paste escaped before" })
map("n", ",p", "<Cmd>call PasteEscapedRegister('after')<CR>", { desc = "Paste escaped after" })

-- Search for word under the cursor (visual)
map(
  "v",
  "*",
  [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>gvy/<C-R><C-R>=substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>gV:call setreg('"', old_reg, old_regtype)<CR>]],
  { desc = "Search visual selection forward" }
)

-- Rename current file (init.vim: <space>n)
map("n", "<space>n", function()
  local old_name = vim.fn.expand("%")
  local new_name = vim.fn.input("New file name: ", old_name, "file")
  if new_name ~= "" and new_name ~= old_name then
    vim.cmd("saveas " .. vim.fn.fnameescape(new_name))
    vim.fn.system("rm " .. vim.fn.shellescape(old_name))
    vim.cmd("redraw!")
  end
end, { desc = "Rename current file" })

-- Console.log helpers (init.vim)
map("i", "cll", "console.log()<Esc>ha", { desc = "console.log insert" })
map(
  "v",
  "cll",
  "yoconsole.log('<C-R>+:', <C-R>+)<Esc>",
  { desc = "console.log visual" }
)
map(
  "n",
  "cll",
  "yiwoconsole.log('<C-R>+:', <C-R>+)<Esc>",
  { desc = "console.log normal" }
)
map("i", "clj", "console.log(JSON.stringify())<Esc>1hi", { desc = "console.log JSON insert" })
map(
  "v",
  "clj",
  "yoconsole.log('<C-R>+', JSON.stringify(<C-R>+, null, 2))<Esc>",
  { desc = "console.log JSON visual" }
)
map(
  "n",
  "clj",
  "yiwoconsole.log('<C-R>+', JSON.stringify(<C-R>+, null, 2))<Esc>",
  { desc = "console.log JSON normal" }
)

-- Coc: tsserver autofix
map("n", "<space>h", "<Cmd>CocCommand tsserver.executeAutofix<CR>", { desc = "Coc tsserver autofix" })

-- Coc: snippet select (visual)
plug("v", "<space>j", "<Plug>(coc-snippets-select)", "Coc snippet select")

-- Coc: goto / references / rename / diagnostics
map("n", "<space>gd", function()
  vim.fn.CocAction("jumpDefinition", "drop")
end, { desc = "Coc definition" })
map("n", "<space>gy", function()
  vim.fn.CocAction("jumpTypeDefinition", "drop")
end, { desc = "Coc type definition" })
map("n", "<space>gi", function()
  vim.fn.CocAction("jumpImplementation", "drop")
end, { desc = "Coc implementation" })
plug("n", "<space>gr", "<Plug>(coc-references)", "Coc references")
plug("n", "<space>rn", "<Plug>(coc-rename)", "Coc rename symbol")
plug("n", "<space>en", "<Plug>(coc-diagnostic-next-error)", "Coc next error")
plug("n", "<space>em", "<Plug>(coc-diagnostic-prev-error)", "Coc prev error")
plug("n", "<space>wn", "<Plug>(coc-diagnostic-next)", "Coc next diagnostic")
plug("n", "<space>wm", "<Plug>(coc-diagnostic-prev)", "Coc prev diagnostic")

-- K: help or hover (init.vim used script-local show_documentation)
map("n", "K", function()
  local ft = vim.bo.filetype
  if ft == "vim" or ft == "help" then
    vim.cmd("help " .. vim.fn.expand("<cword>"))
  else
    vim.fn.CocAction("doHover")
  end
end, { desc = "Documentation / hover" })

-- Old mapleader was comma: ,a for code actions
plug("v", ",a", "<Plug>(coc-codeaction-selected)", "Coc code action (visual)")
plug("n", ",a", "<Plug>(coc-codeaction-selected)", "Coc code action")

plug("x", "<space>fr", "<Plug>(coc-format-selected)", "Coc format selection")
plug("n", "<space>fr", "<Plug>(coc-format-selected)", "Coc format")

plug("n", "<space>i", "<Plug>(coc-fix-current)", "Coc fix current")
plug("n", "<space>ia", "<Plug>(coc-codeaction)", "Coc code action")
plug("n", "<space>ig", "<Plug>(coc-codeaction-line)", "Coc code action line")

map("n", "<space>y", "<Cmd>CocList -A --normal yank<CR>", { desc = "Coc yank list" })
