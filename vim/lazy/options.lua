-- Vim/Neovim options ported from init.vim (Vim setup, theme, ack, etc.)

-- GUI / display
vim.opt.guifont = "Noto Sans Mono:h12"
vim.opt.showtabline = 8
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.number = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Tabs and indentation
vim.opt.tabstop = 8
vim.opt.softtabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true

-- Backup / swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.backupdir = "~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp"
vim.opt.directory = "~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp"
vim.opt.backupcopy = "yes"

-- Search
vim.opt.path:append("**")
vim.opt.wildignore:append("node_modules/*")
vim.opt.wildignore:append(".nx/*")
vim.opt.wildmenu = true
vim.opt.showmatch = true
vim.opt.lazyredraw = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Coc / LSP-friendly (from init.vim COC section)
vim.opt.hidden = true
vim.opt.shortmess:append("c")
vim.opt.cmdheight = 1
vim.opt.signcolumn = "number"
vim.g.coc_user_config = {
  ["coc.preferences.jumpCommand"] = { "vsplit" },
}
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.neovide_cursor_vfx_mode = "railgun"

-- Shell and UI
vim.opt.shell = "/bin/bash"
vim.opt.updatetime = 300
vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")
vim.opt.syntax = "on"
vim.opt.conceallevel = 0

-- Folding
vim.opt.foldenable = true
vim.opt.foldlevelstart = 10
vim.opt.foldnestmax = 10
vim.opt.foldmethod = "indent"

-- Leader (init.vim used comma; lazy.lua sets space - keeping space for <space>p etc.)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Plugin options from init.vim
vim.g.airline_section_tabline = "%!airline#extensions#tabline#get()"
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline_section_b"] = ""
vim.g.airline_theme = "deus"
vim.g.ackprg = "ack --ignore-dir=.nx --ignore-dir=node_modules --ignore-dir=coverage"
vim.g.vim_json_syntax_conceal = 0

-- Cursor (block in normal, vertical in insert)
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver10,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Filetype overrides
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tag", "*.sys" },
  callback = function()
    vim.bo.filetype = "html"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mjs", "*.sys" },
  callback = function()
    vim.bo.filetype = "javascript"
  end,
})
