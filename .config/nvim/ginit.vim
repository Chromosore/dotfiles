let s:gui = 'default'
if has('gui_gtk') | let s:gui = 'gtk' | endif

let g:font = deepcopy(chromosore#local#font)
let g:font.format = s:gui
let &guifont = chromosore#guifont#{s:gui}(g:font)

" refresh {{{
fun! s:refresh(op)
	let g:font.size = a:op(g:font.size)
	let &guifont = chromosore#guifont#{g:font.format}(g:font)
endfun
" }}}

nmap <C-+>   <Cmd>call <SID>refresh({ s -> s + 1 })<CR>
nmap <C-S-_> <Cmd>call <SID>refresh({ s -> s - 1 })<CR>

set mousefocus

set lines=37
set columns=110

" Disable toolbar
set guioptions-=T

" Remove scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

unlet s:gui
" vim: fdm=marker
