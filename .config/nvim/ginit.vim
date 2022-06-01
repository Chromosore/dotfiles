let s:gui = 'default'
if has('gui_gtk') | let s:gui = 'gtk' | endif

let g:font = { 'family': chromosore#local#guifont, 'size': 12 }
let &guifont = chromosore#guifont#{s:gui}(g:font)

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
