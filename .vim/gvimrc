let s:font_list = ['SF Mono', 'Menlo', 'Hack']
let s:font_size = 12
let s:use_nerdfont = 1

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

" guifont {{{

" gvim gtk has a bug that makes it crash the font selecting process if
" the first font in the list does not exists, so let the user handle
" this
if has('gui_gtk') && &guifont != ''
	finish
endif

if has('gui_gtk')
	fun! s:format_font(font_name, font_size)
		return a:font_name .. ' ' .. a:font_size
	endfun
elseif has('gui_macvim') || has('gui_win32')
	fun! s:format_font(font_name, font_size)
		return a:font_name .. ':h' .. a:font_size
	endfun
endif

fun! s:guifont_add(font_string)
	if &guifont == ''
		let &guifont = a:font_string
	else
		let &guifont .= ',' .. a:font_string
	endif
endfun

for font in s:font_list
	if s:use_nerdfont
		call s:guifont_add(s:format_font(font .. ' NerdFont', s:font_size))
	endif

	call s:guifont_add(s:format_font(font, s:font_size))
endfor

" vim: fdm=marker
