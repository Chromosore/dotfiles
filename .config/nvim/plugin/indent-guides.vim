" For the actual indent guides, see plugin/ui.vim

let s:indent_char = '▏'
let s:indent_char_ascii = '|'

let s:indent_guides_exclude = {
			\ 'filetype': ['', 'text', 'nerdtree', 'man'],
			\ 'buftype' : ['help', 'terminal', 'quickfix'],
			\ 'bufname' : ['_.*', 'NERD_tree.*'],
			\}



if has('conceal')
	let g:indentLine_setColors = 0

	let g:indentLine_char = s:indent_char

	if has('gui_win32')
		let g:indentLine_char = s:indent_char_ascii
	end

	let g:indentLine_fileTypeExclude = s:indent_guides_exclude.filetype
	let g:indentLine_bufTypeExclude  = s:indent_guides_exclude.buftype
	let g:indentLine_bufNameExclude  = s:indent_guides_exclude.bufname

else
	" indent guides
	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * highlight link IndentGuidesOdd  FoldColumn
	autocmd VimEnter,Colorscheme * highlight link IndentGuidesEven CursorColumn

	let g:indent_guides_exclude_filetypes = s:indent_guides_exclude.filetype
endif


function s:listchars_indentLine_exclude()
	if index(s:indent_guides_exclude.filetype, &filetype) != -1
		setlocal nolist
		return
	endif

	if index(s:indent_guides_exclude.buftype, &buftype) != -1
		setlocal nolist
		return
	endif

	let bufname = expand('%')
	for bufNamePat in s:indent_guides_exclude.bufname
		if match(bufname, bufNamePat) != -1
			setlocal nolist
			return
		endif
	endfor
endfunction

augroup IndentGuides
	autocmd!
	autocmd BufEnter * call <SID>listchars_indentLine_exclude()
augroup END
