" For the actual indent guides, see plugin/ui.vim

let g:indentLine_fileTypeExclude = ['', 'text', 'nerdtree', 'man']
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'nofile', 'quickfix']
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']

let g:indent_guides_exclude_filetypes = g:indentLine_fileTypeExclude

function s:listchars_indentLine_exclude()
	if index(g:indentLine_fileTypeExclude, &filetype) != -1
		setlocal nolist
		return
	endif

	if index(g:indentLine_bufTypeExclude, &buftype) != -1
		setlocal nolist
		return
	endif

	let bufname = expand('%')
	for bufNamePat in g:indentLine_bufNameExclude
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
