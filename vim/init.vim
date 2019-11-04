call plug#begin()
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'leafgarland/typescript-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'https://github.com/lilydjwg/colorizer'
Plug 'Yggdroot/indentLine'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'https://github.com/tpope/vim-fugitive.git'
" Plug 'kien/ctrlp.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'Nequo/vim-allomancer'
Plug 'https://github.com/nightsense/office'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'liuchengxu/space-vim-theme'
" syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
Plug 'tpope/vim-commentary'
" Color picker
Plug 'KabbAmine/vCoolor.vim'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()

set ruler
set nu
" This sets up the indent line for function scopes
set listchars=tab:\|\
set list
" shows vertical line on assigned value
set cc=110

" font and size
set guifont=Consolas\ 12

if !has('nvim')
  set guioptions -=m
  set guioptions -=T
  set guifont=Consolas\ 11
endif

" colorscheme jellybeans
" colorscheme allomancer
" colorscheme office-dark

" setup for spacemacs-theme
if (has("termguicolors"))
  set termguicolors
endif
set background=dark
" colorscheme spacemacs-theme
color space_vim_theme


"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

filetype plugin on

" Add custom filetype1
au BufNewFile,BufRead *.tag set filetype=html
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.vsp set filetype=javascript
au BufNewFile,BufRead *.vsc set filetype=javascript
au BufNewFile,BufRead *.ts set filetype=javascript
au BufNewFile,BufRead www set filetype=javascript
au BufNewFile,BufRead *.ael set filetype=perl
au BufNewFile,BufRead *.agi set filetype=perl

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

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

filetype off
filetype plugin indent on
autocmd Filetype json let g:indentLine_setConceal = 0
let g:indentLine_enabled = 1
let g:vim_json_syntax_conceal = 0
syntax on

" Show trailing spaces set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:.
set listchars=tab:>·,extends:>,precedes:<

set list
syn match Tab "\t"
hi def Tab ctermbg=darkgreen guibg=#545f70

" Show trailing white paces
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Copy to clipboard
set clipboard=unnamedplus
nmap <C-c> let @+=@"

" Copy file path to buffer
nmap ,cs :let @+=expand("%")<CR>
nmap ,cl :let @+=expand("%:p")<CR>

"fzf installed using git - fuzzy finder
set rtp+=~/.fzf

" open fzf
nnoremap <space>p :FZF<CR>

"ALE configuration - linting plugin
" let g:ale_fixers = {
" \   'javascript': ['eslint'],
" \   'css': ['eslint'],
" \   'html': ['eslint'],
" \}
autocmd BufWritePost *.json,*.js,*.tag,*.html ALEFix
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.css = ['eslint']
let g:ale_fixers.html = ['eslint']
let g:ale_fixers.json = ['prettier']

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0
let g:ale_linter_aliases = {'html': ['css', 'javascript']}
let g:ale_linters = {'html': ['stylelint', 'eslint']}

" prettier configuration
" nmap <space>q <Plug>(Prettier)
nmap <space>q <Plug>(ale_fix)

" YouCompleteMe settings
let g:ycm_complete_in_comments = 1 " completed in comments
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']

" vim-airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = ''
let g:airline_theme='distinguished'

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

" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

" open Ack
nnoremap <space>f :Ack!

" Folding - za folds single scope, zM folds all scopes, zR opens all scopes
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

" space open/closes folds
set foldmethod=indent   " fold based on indent level

" Sets mackup to
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" parcel hot replacement tweak
set backupcopy=yes

" show file path and name in the status bar
set laststatus=2

" sets path to be recursive in orser to `find` recursuvely
set path+=**

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log()<Esc>==f(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yoconsole.log('', <Esc>==f'<Leader>pf p
" Console log from normal mode, inserted on next line with the word you are on inside parentheses
nmap cll yiwoconsole.log('', <Esc>==f'<Leader>pf p
" Console log with JSON.stringify
imap clj console.log(JSON.stringify(*<Esc>==f*xi
vmap clj yoconsole.log('', JSON.stringify(*, null, 2<Esc>==f'<Leader>pf*Pf*x
nmap clj yiwoconsole.log('', JSON.stringify(*, null, 2<Esc>==f'<Leader>pf*Pf*x

" autocloses brackets and quotes
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

" ignore case in search results
set ignorecase

" reindents whole file and psotions back the cursor
map <F7> mzgg=G`z

" shows quotes in json files
let g:vim_json_syntax_conceal=0
set conceallevel=0

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

" Define keymaps to paste escaped text before or after the cursor.
nmap <Leader>P :call PasteEscapedRegister("before")<cr>
nmap <Leader>p :call PasteEscapedRegister("after")<cr>

" adds Alt (meto) to work in GVim
set winaltkeys=no
let s:printable_ascii = map(range(32, 126), 'nr2char(v:val)')
call remove(s:printable_ascii, 92)
for s:char in s:printable_ascii
  execute "imap <A-" . s:char . "> <Esc>" . s:char
  execute "nmap <A-" . s:char . "> <Esc>" . s:char
endfor
unlet s:printable_ascii s:char

" Indent line display
" GVim
let g:indentLine_color_gui = '#545f70'

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP

" close all buffers but the opened one
command! -nargs=? -complete=buffer -bang BufOnly :%bd|e#

" fzf for buffers search
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

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" closes search results listing
nnoremap <silent> <space>d :cclos<CR>

" saves current file
nnoremap <silent> <space>s :w<CR>
