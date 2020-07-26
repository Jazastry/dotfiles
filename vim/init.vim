call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'liuchengxu/space-vim-theme'
Plug 'nanotech/jellybeans.vim'

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
" A solid language pack (syntax highlighting)
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'https://github.com/lilydjwg/colorizer'
Plug 'Yggdroot/indentLine'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-fugitive.git'
" Color picker
Plug 'KabbAmine/vCoolor.vim'
" Dockerfile syntax
" Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}

Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

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
set listchars=tab:\|\
set list
" shows vertical line on assigned value
set cc=110

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

set list
syn match Tab "\t"
hi def Tab ctermbg=darkgreen guibg=#545f70

filetype plugin on

" Add custom filetype1

filetype off
filetype plugin indent on
autocmd Filetype json let g:indentLine_setConceal = 0
let g:indentLine_enabled = 1
let g:vim_json_syntax_conceal = 0
syntax on

" shows quotes in json files
let g:vim_json_syntax_conceal=0
set conceallevel=0

" ignore case in search results
set ignorecase

au! BufNewFile,BufRead *.tag,*.sys setf html

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
nnoremap <space>p :FZF<CR>

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEME SETUP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup for spacemacs-theme
if (has("termguicolors"))
  set termguicolors
endif
set background=dark
" colorscheme spacemacs-theme
color space_vim_theme
" colorscheme jellybeans

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

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Copy to clipboard
set clipboard=unnamedplus
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

" console.log mappigs
"""""""""""""""""""""
" Console log from insert mode; Puts focus inside parentheses
imap <silent> cll console.log()<Esc>ha
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap <silent> cll yoconsole.log('<C-R>+:', <C-R>+)<Esc>
" console.log('', )<Esc>hhhPllllPg
" Console log from normal mode, inserted on next line with the word you are on inside parentheses
nmap <silent> cll yiwoconsole.log('<C-R>+:', <C-R>+)<Esc>
" console.log('', )<Esc>hhhPllllP
" Console log with JSON.stringify
" Console log from insert mode; Puts focus inside parentheses
imap <silent> clj console.log(JSON.stringify())<Esc>1hi
" vmap <silent> clj yoconsole.log('', JSON.stringify(*, null, 2)<Esc>28hP18lpA<Esc>)
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

" up down with CTRL+k,TRL+j
"""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <expr> <C-J> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr> <C-K> pumvisible() ? "\<Up>" : "\<C-k>"

" toggle English spell check
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <space>sp :setlocal spell! spelllang=en_us<CR> 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = ''
let g:airline_theme='distinguished'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let g:ultisnips_javascript = {
     \ 'keyword-spacing': 'always',
     \ 'semi': 'never',
     \ 'space-before-function-paren': 'always',
     \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install plugins:
" CocInstall coc-eslint
" CocInstall coc-snippets
" CocInstall coc-tsserver
" CocInstall coc-json
" CocInstall coc-vetur
" CocInstall coc-prettier
" CocInstall coc-stylelint

" To get correct comment highlighting in coc-settings.json
autocmd FileType json syntax match Comment +\/\/.\+$+

" Fix lint errors with eslint
nmap <space>h :CocCommand tsserver.executeAutofix<CR>
" Use <C-l> for trigger snippet expand.
" imap <space>l <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <space>j <Plug>(coc-snippets-select)
" Use <C-space> for open popup
map <C-space> <Plug>
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-k>'
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space>  coc#refresh()

"----------------------------------------------------------
" vim-coc
"----------------------------------------------------------
" Remap keys for gotos
nmap <silent> <space>ld <Plug>(coc-definition)
" Remap for rename current word
nmap <space>lr <Plug>(coc-rename)
" VUE coc setup
let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

"----------------------------------------------------------
" white spaces reveal
"----------------------------------------------------------
" Show trailing spaces set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:.
set listchars=tab:>·,extends:>,precedes:<

" Show trailing white paces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
