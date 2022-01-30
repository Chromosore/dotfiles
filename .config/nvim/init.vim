" vim: foldmethod=marker
scriptencoding utf-8
set encoding=utf-8

if has('packages') && &loadplugins
	" sensible.vim : a universal set of defaults
	packadd! vim-sensible

	packadd! vim-commentary
	packadd! vim-sandwich

	if chromosore#has_nerdfont
		packadd! vim-devicons
	endif

	packadd! fzf

	if has('conceal')
		packadd! indentLine
	else
		packadd! vim-indent-guides
	endif

	if !has('gui_running')
		packadd! terminus
	endif

	packadd! vim-quicktask

	augroup nerd_loader
		autocmd!
		autocmd VimEnter * silent! autocmd! FileExplorer
		autocmd BufEnter,BufNew *
					\		if isdirectory(expand('<amatch>'))
					\|		call chromosore#nerdtree#load()
					\|		autocmd! nerd_loader
					\|	endif
	augroup END


	augroup PackLazyLoad
		autocmd!
		autocmd FileType typescript ++once
					\ packadd tsuquyomi
	augroup END
elseif &loadplugins
	" Not using Vim8 {{{
	let packpath_parts = split(&packpath, ',')
	for archive in packpath_parts
		let &rtp .= ','. join(glob(archive . '/pack/*/start/*', v:false, v:true), ',')
	endfor

	let user_packs = packpath_parts[0]
	let &rtp .= ','. join(glob(user_packs . '/pack/*/opt/*', v:false, v:true), ',')
	unlet user_packs

	for archive in packpath_parts
		let &rtp .= ','. join(glob(archive . '/pack/*/after/*', v:false, v:true), ',')
	endfor
	" }}}
endif

filetype plugin indent on
syntax enable

" Miscellaneous {{{
" Close vim if a quickfix window is the only open buffer
autocmd BufEnter * if winnr("$") == 1 && &buftype == "quickfix" |
	\ quit | endif

autocmd BufWritePre /tmp/* setlocal noundofile
" }}}
