" Legacy Vimscript from init.vim: functions + Coc insert maps + autocmds.
" Loaded after options.lua, before keymaps.lua (PasteEscapedRegister must exist).

function! EscapeText(text)
  let l:escaped_text = a:text
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
  let l:escaped_text = substitute(l:escaped_text, "\\", '\\\', 'g')
  for [original, escaped] in items(l:charmap)
    let l:escaped_text = substitute(l:escaped_text, original, escaped, 'g')
  endfor
  let l:escaped_text = substitute(l:escaped_text,
        \   '\([^[:alnum:][:punct:] ]\)',
        \   '\="\\o" . printf("%03o",char2nr(submatch(1)))',
        \   'g')
  return l:escaped_text
endfunction

function! PasteEscapedRegister(where)
  let l:save_reg_name     = v:register
  let l:save_reg_contents = getreg(l:save_reg_name, 1)
  let l:save_reg_type     = getregtype(l:save_reg_name)
  echo "register: [" . l:save_reg_name . "] type: [" . l:save_reg_type . "]"
  call setreg(l:save_reg_name, EscapeText(getreg(l:save_reg_name)), "c")
  let l:cmd = 'normal "' . l:save_reg_name . (a:where == "before" ? "P" : "p")
  exec l:cmd
  call setreg(l:save_reg_name, l:save_reg_contents, l:save_reg_type)
endfunction

function! OpenChangedFiles()
  only
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  if len(filenames) == 0 | return | endif
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "e " . filename
  endfor
endfunction

function! OpenZippedFile(f)
  let l:b = bufnr('%')
  let l:f = substitute(a:f, '.zip/', '.zip::', '')
  let l:f = substitute(l:f, '/zip:', 'zipfile:', '')
  b #
  exe 'bd! ' . l:b
  sil exe 'e ' . l:f
  call zip#Read(l:f, 1)
endfunction

command! -nargs=0 OpenChangedFiles :call OpenChangedFiles()

augroup DotfilesLegacyCoc
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType scss setl iskeyword+=@-@
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd BufReadCmd /zip:*.yarn/cache/*.zip/* call OpenZippedFile(expand('<afile>'))
augroup END

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Coc completion + float scroll (same as init.vim)
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
