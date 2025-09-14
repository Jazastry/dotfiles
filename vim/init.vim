call plug#begin('~/.config/nvim/plugged')
" We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'terryma/vim-multiple-cursors'
" Track the engine.
" Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
" Plug 'honza/vim-snippets'
" A solid language pack (syntax highlighting)
" Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
" Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'https://github.com/lilydjwg/colorizer'
" Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'Valloric/MatchTagAlways'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-fugitive.git'
" Color picker
Plug 'KabbAmine/vCoolor.vim'
" Dockerfile syntax
" Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
"
" Plug 'ianks/vim-tsx'

Plug 'mustache/vim-mustache-handlebars'

" Plug 'leafgarland/typescript-vim'

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

Plug 'jxnblk/vim-mdx-js'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'github/copilot.vim'
" Plug 'zbirenbaum/copilot.lua'
" Plug 'dpayne/CodeGPT.nvim'

Plug 'gpanders/editorconfig.nvim'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'

" use {
"     'Equilibris/nx.nvim',
"     requires = {
"         'nvim-telescope/telescope.nvim',
"     },
"     config = function! EquilibrisSetup()
"     require("nx").setup {}
"     end
" }

" function! EquilibrisSetup()
"   require("nx").setup {
"     nx_cmd_root = 'nx',
"     command_runner = require('nx.command-runners').terminal_command_runner(),
"     form_renderer = require('nx.form-renderers').telescope_form_renderer(),
"     read_init = true,
"   }
"   require('nx.actions')
" endfunction
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'Equilibris/nx.nvim', { 'do': function('EquilibrisSetup') }
" Plug 'prisma/vim-prisma'
" Plug 'nomnivore/ollama.nvim'

" C# test start
" Plug 'OrangeT/vim-csharp'
" C# test end
"
Plug 'andythigpen/nvim-coverage'

" Plug 'petertriho/nvim-scrollbar'
" Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
" Plug 'wfxr/minimap.vim'
" Plug 'lewis6991/satellite.nvim'
" Plug 'echasnovski/mini.nvim'
" Plug 'lewis6991/gitsigns.nvim'
" Plug 'Isrothy/neominimap.nvim'




Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'colepeters/spacemacs-theme.vim'
" Plug 'liuchengxu/space-vim-theme'
" Plug 'liuchengxu/space-vim-dark'
" Plug 'nanotech/jellybeans.vim'
" Plug 'f4z3r/gruvbox-material.nvim'
" Plug 'ribru17/bamboo.nvim'
" Plug 'audibleblink/hackthebox.vim'
" Plug 'hachy/eva01.vim'
" Plug 'jamespwilliams/bat.vim'
" Plug 'rebelot/kanagawa.nvim'
" Plug 'Shatur/neovim-ayu'
" Plug 'oxfist/night-owl.nvim'
" Plug 'barrientosvctor/abyss.nvim'
Plug 'jazastry/espresso-libre'

""""""""""""""
" Avante deps
""""""""""""""

" Deps
" Plug 'MeanderingProgrammer/render-markdown.nvim'

" Optional deps
" Plug 'hrsh7th/nvim-cmp'
" Plug 'HakonHarnes/img-clip.nvim'
" Plug 'stevearc/dressing.nvim' " for enhanced input UI
" Plug 'folke/snacks.nvim' " for modern input UI

" Yay, pass source=true if you want to build from source
" Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

""""""""""""""

Plug 'neovim/nvim-lspconfig'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the default font
set guifont=Noto\ Sans\ Mono:h12

set tabstop=8
set softtabstop=8
set shiftwidth=8
set expandtab
hi TabLine ctermbg=darkgray guibg=gray
let g:airline_section_tabline = '%!airline#extensions#tabline#get()'

" Set the width of the tab line in characters
set showtabline=8

" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" parcel hot replacement tweak
set backupcopy=yes

" show file path and name in the status bar
set laststatus=2

" sets path to be recursive in order to `find` recursuvely
set path+=**

"Ignore directory in search
set wildignore+=node_modules/*
" visual autocomplete for command menu
set wildmenu

" highlight matching [{()}]
set showmatch

" redraw only when we need to.
set lazyredraw
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set ruler
set nu
" This sets up the indent line for function scopes
" set list
" set listchars=tab:\|\
" shows vertical line on assigned value
set cc=80
set shell=/bin/bash
" Cursor settings - ver25, block, hor5
set guicursor=n-v-c:block,i-ci-ve:ver10,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" set list
" syn match Tab "\t"
" hi def Tab ctermbg=darkgreen guibg=#545f70

" Add custom filetype1
" filetype on
filetype plugin on
filetype plugin indent on
" autocmd Filetype json let g:indentLine_setConceal = 0
" let g:indentLine_enabled = 1
let g:vim_json_syntax_conceal = 0
syntax on

" shows quotes in json files
let g:vim_json_syntax_conceal=0
set conceallevel=0

" ignore case in search results
set ignorecase

au! BufNewFile,BufRead *.tag,*.sys setf html

" set the leader to ,
let mapleader=","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"fzf installed using git - fuzzy finder
set rtp+=~/.fzf

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" open fzf
""""""""""""""""""""""""
nnoremap <silent> <space>p :FZF<CR>

" fzf for buffers search
""""""""""""""""""""""""
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <space><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" fzf search in hidden folders "
""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_COMMAND='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name ''*.tags'' -printf ''%P\n'''


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEME SETUP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup for spacemacs-theme
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
" colorscheme spacemacs-theme
" olorscheme space_vim_theme
" colorscheme space-vim-dark
" colorscheme jellybeans

"---------------------------------------------------------
" gruvbox-material theme configuration
"---------------------------------------------------------
" let g:gruvbox_material_italics = 1
" let g:gruvbox_material_contrast = "medium"
" let g:gruvbox_material_comments_italics = 1
" let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_background_transparent = 0
" let g:gruvbox_material_float_force_background = 0
" let g:gruvbox_material_float_background_color = "NONE"
" let g:gruvbox_material_colors_override = {
" \   'CursorColumn': ['#f5edca',   '223'],
" \   'MatchParen': ['#a9b665',   '223'],
" \ }
" colorscheme gruvbox-material
" colorscheme kanagawa
" colorscheme abyss

colorscheme  espresso-libre
" lua << EOF
" local c = require('abyss.colors')
" require('abyss').setup {
"     italic_comments = true, -- Toggle italic comments
"     italic = true, -- Toggle italic for function names, keywords, strings and booleans
"     bold = true, -- Toggle bold for function names, keywords and booleans
"     transparent_background = false, -- Toggle transparency on neovim background
"     treesitter = true, -- Enable treesitter highlighting. No need to configuration. Default value: (Neovim = true), (Vim = false)
"     overrides = {
"          ColorColumn = { bg = c.bg_completion, bold = true },
"          Comment = { fg = c.midblue, bold = false },
"          Function = { fg = "#C96D27", bold = false },
"          Boolean = { fg = c.yellow, bold = false },
"          Structure = { fg = c.yellow, underline = false },
"          Identifier = { fg = c.shinyblue, underline = false },
"          DiagnosticUnderlineWarn = { sp = "#BE8A54", undercurl = true },
"          Search = { fg = c.black, bg = "#9F9467" },
"          IncSearch = { fg = c.black, bg = c.yellow },
"       }
" }
" EOF

" colorscheme night-owl
" colorscheme ayu
" colorscheme ayu-dark
" colorscheme ayu-mirage
" colorscheme bamboo
" colorscheme hackthebox
" colorscheme eva01
" colorscheme bat

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYMAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" navigate between splits
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" next prev buffer
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>

" resize splits
nmap <silent> <space>l :vertical resize +5<CR>
nmap <silent> <space>h :vertical resize -5<CR>
nmap <silent> <space>j :resize +5<CR>
nmap <silent> <space>k :resize -5<CR>

"Remove all trailing whitespace by pressing <space> w
nnoremap <silent> <space>c :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:w<CR>

" Copy to clipboard
set clipboard+=unnamedplus
nmap <C-c> let @+=@"

" Copy file path to buffer
nmap ,cs :let @+=expand("%")<CR>
nmap ,cl :let @+=expand("%:p")<CR>

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

" Folding - za folds single scope, zM folds all scopes, zR opens all scopes
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
set foldmethod=indent   " fold based on indent level

" open Ack
nnoremap <space>f :Ack! '

" Escape terminal mode
tnoremap <Esc> <C-\><C-n>

" console.log mappigs
"""""""""""""""""""""
" Console log from insert mode; Puts focus inside parentheses
imap <silent> cll console.log()<Esc>ha
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap <silent> cll yoconsole.log('<C-R>+:', <C-R>+)<Esc>
" Console log from normal mode, inserted on next line with the word you are on inside parentheses
nmap <silent> cll yiwoconsole.log('<C-R>+:', <C-R>+)<Esc>
" Console log with JSON.stringify
" Console log from insert mode; Puts focus inside parentheses
imap <silent> clj console.log(JSON.stringify())<Esc>1hi
vmap <silent> clj yoconsole.log('<C-R>+', JSON.stringify(<C-R>+, null, 2))<Esc>
nmap <silent> clj yiwoconsole.log('<C-R>+', JSON.stringify(<C-R>+, null, 2))<Esc>

" Paste settings
""""""""""""""""""""
" Escape when pasting
function! EscapeText(text)
  let l:escaped_text = a:text
  " Map characters to named C backslash escapes. Normally, single-quoted
  " strings don't require double-backslashing, but these are necessary
  " to make the substitute() call below work properly.
  "
  let l:charmap = {
        \   '"'     : '\\"',
        \   "'"     : '\\''',
        \   "\n"    : '\\n',
        \   "\r"    : '\\r',
        \   "\b"    : '\\b',
        \   "\t"    : '\\t',
        \   "\x07"  : '\\a',
        \   "\x0B"  : '\\v',
        \   "\f"    : '\\f',
        \   }

  " Escape any existing backslashes in the text first, before
  " generating new ones. (Vim dictionaries iterate in arbitrary order,
  " so this step can't be combined with the items() loop below.)
  "
  let l:escaped_text = substitute(l:escaped_text, "\\", '\\\', 'g')

  " Replace actual returns, newlines, tabs, etc., with their escaped
  " representations.
  "
  for [original, escaped] in items(charmap)
    let l:escaped_text = substitute(l:escaped_text, original, escaped, 'g')
  endfor

  " Replace any other character that isn't a letter, number,
  " punctuation, or space with a 3-digit octal escape sequence. (Octal
  " is used instead of hex, since octal escapes terminate after 3
  " digits. C allows hex escapes of any length, so it's possible for
  " them to run up against subsequent characters that might be valid
  " hex digits.)
  "
  let l:escaped_text = substitute(l:escaped_text,
        \   '\([^[:alnum:][:punct:] ]\)',
        \   '\="\\o" . printf("%03o",char2nr(submatch(1)))',
        \   'g')

  return l:escaped_text
endfunction


function! PasteEscapedRegister(where)
    " Remember current register name, contents, and type,
    " so they can be restored once we're done.
    "
    let l:save_reg_name     = v:register
    let l:save_reg_contents = getreg(l:save_reg_name, 1)
    let l:save_reg_type     = getregtype(l:save_reg_name)

    echo "register: [" . l:save_reg_name . "] type: [" . l:save_reg_type . "]"

    " Replace the contents of the register with the escaped text, and set the
    " type to characterwise (so pasting into an existing double-quoted string,
    " for example, will work as expected).
    "
    call setreg(l:save_reg_name, EscapeText(getreg(l:save_reg_name)), "c")

    " Build the appropriate normal-mode paste command.
    "
    let l:cmd = 'normal "' . l:save_reg_name . (a:where == "before" ? "P" : "p")

    " Insert the escaped register contents.
    "
    exec l:cmd

    " Restore the register to its original value and type.
    "
    call setreg(l:save_reg_name, l:save_reg_contents, l:save_reg_type)
endfunction

" Define key-maps to paste escaped text before or after the cursor.
nmap <Leader>P :call PasteEscapedRegister("before")<cr>
nmap <Leader>p :call PasteEscapedRegister("after")<cr>

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP

" Search for word under the cursor
""""""""""""""""""""""""""""""""""
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Close search results listing
""""""""""""""""""""""""""""""
nnoremap <silent> <space>d :cclos<CR>

" goes to the next git change in the file
"""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <space>g :GitGutterNextHunk<CR>zz

" toggle English spell check
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <space>sp :setlocal spell! spelllang=en_us<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BG mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/dotfiles/vim/mappings/bg-keyboard-mapings.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = ''
let g:airline_theme= 'deus'
" 'deus' luna
" "'distinguished'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NVIM-TREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <space>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "e " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-SNIPPETS  setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ultisnips_javascript = {
"      \ 'keyword-spacing': 'always',
"      \ 'semi': 'never',
"      \ 'space-before-function-paren': 'always',
"      \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovide setup - https://github.com/Kethku/neovide
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neovide_cursor_vfx_mode = "railgun"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install plugins:
" CocInstall coc-eslint coc-snippets coc-tsserver coc-json coc-vetur coc-prettier coc-stylelint coc-yaml coc-spell-checker coc-actions coc-lists coc-yank coc-css coc-import-cost coc-sh coc-prisma coc-html

" To get correct comment highlighting in coc-settings.json
autocmd FileType json syntax match Comment +\/\/.\+$+

" Fix lint errors with eslint
nmap <space>h :CocCommand tsserver.executeAutofix<CR>
" Use <C-l> for trigger snippet expand.
" imap <space>l <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <space>j <Plug>(coc-snippets-select)



" GoTo code navigation.
function! s:jump_definition()
    call CocAction('jumpDefinition', 'drop')
endfunction

function! s:jump_implementation()
    call CocAction('jumpImplementation', 'drop')
endfunction

function! s:jump_type_definition()
    call CocAction('jumpTypeDefinition', 'drop')
endfunction
" <Plug>(coc-definition)
nmap <silent> <space>gd :call <SID>jump_definition()<CR>
" <Plug>(coc-type-definition)
nmap <silent> <space>gy :call <SID>jump_type_definition()<CR>
" <Plug>(coc-implementation)
nmap <silent> <space>gi :call <SID>jump_implementation()<CR>
nmap <silent> <space>gr <Plug>(coc-references)
" Remap for rename current word
nmap <space>rn <Plug>(coc-rename)
" Jump next error
nmap <silent> <space>en <Plug>(coc-diagnostic-next-error)
" Jump previous error
nmap <silent> <space>em <Plug>(coc-diagnostic-prev-error)
" Jump next warning
nmap <silent> <space>wn <Plug>(coc-diagnostic-next)
" Jump prev warning
nmap <silent> <space>wm <Plug>(coc-diagnostic-prev)

" VUE coc setup
let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=1
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"----------------------------------------------------------
" White spaces reveal
"----------------------------------------------------------
" Show trailing spaces set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:.
set listchars=eol:¬,tab:\ \ ,extends:>,precedes:<

" Show trailing white paces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

"----------------------------------------------------------
" Line number color setup
"----------------------------------------------------------
highlight LineNr guifg=#7E7E7E

"----------------------------------------------------------
" Text spell check and words auto completion
"----------------------------------------------------------
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
xmap <space>fr <Plug>(coc-format-selected)
nmap <space>fr <Plug>(coc-format-selected)
nmap <space>i <Plug>(coc-fix-current)
nmap <space>ia <Plug>(coc-codeaction)
nmap <space>ig <Plug>(coc-codeaction-line)

" " ,(Leader)aw - shows word suggestions for the word under the cursor
" xmap <silent> <Leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
" nmap <silent> <Leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

"----------------------------------------------------------
" Open coc-yank yank list
"----------------------------------------------------------
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

"----------------------------------------------------------
" Open coc-css lint scss
"----------------------------------------------------------
autocmd FileType scss setl iskeyword+=@-@


"----------------------------------------------------------
" Scroll info popup
"----------------------------------------------------------
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"


"---------------------------------------------------------
" go
"---------------------------------------------------------
" Enable lsp for go by using gopls
let g:completor_filetype_map = {}
let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls -remote=auto'}"


"---------------------------------------------------------
" puthon - anable python3
"---------------------------------------------------------
let g:python3_host_prog = "/usr/bin/python3"

"---------------------------------------------------------
" Fugitive specific
"---------------------------------------------------------
" Cleans up the git autocreated buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"---------------------------------------------------------
" FVim specific
"---------------------------------------------------------
" Cursor tweaks
if exists('g:fvim_loaded')
   FVimCursorSmoothMove v:true
   FVimCursorSmoothBlink v:true

   " copy paste
   vnoremap <C-S-c> "*y
   vnoremap <C-S-v> "*p

   set mouse=a
   " Ctrl-ScrollWheel for zooming in/out
   nnoremap <silent> <C-+> :set guifont=+<CR>
   nnoremap <silent> <C--> :set guifont=-<CR>

    " good old 'set guifont' compatibility with HiDPI hints...
    if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
      set guifont=Noto\ Sans\ Mono:h13
    else
      set guifont=Noto\ Sans\ Mono:h16
    endif
endif

" open the definition, implementation, references in hte split
let g:coc_user_config = {}
let g:coc_user_config['coc.preferences.jumpCommand'] = ['vsplit']

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space>  coc#refresh()
inoremap <expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
inoremap <expr> <C-j> coc#pum#visible() ? coc#snippet#next() : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#snippet#prev() : "\<C-k>"

function! OpenZippedFile(f)
  " get number of new (empty) buffer
  let l:b = bufnr('%')
  " construct full path
  let l:f = substitute(a:f, '.zip/', '.zip::', '')
  let l:f = substitute(l:f, '/zip:', 'zipfile:', '')

  " swap back to original buffer
  b #
  " delete new one
  exe 'bd! ' . l:b
  " open buffer with correct path
  sil exe 'e ' . l:f
  " read in zip data
  call zip#Read(l:f, 1)
endfunction

au BufReadCmd /zip:*.yarn/cache/*.zip/* call OpenZippedFile(expand('<afile>'))

"---------------------------------------------------------
" Load session if any
"---------------------------------------------------------
