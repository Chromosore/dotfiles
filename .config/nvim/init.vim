" vim: foldmethod=marker
scriptencoding utf-8
set encoding=utf-8

if has('packages') && &loadplugins
	packadd! vim-commentary
	packadd! vim-sandwich

	if chromosore#has_nerdfont
		packadd! vim-devicons
	endif

	packadd! fzf

	packadd! indent-blankline.nvim

	if !has('gui_running') && !has('nvim')
		packadd! terminus
	endif

	packadd! nvim-lspconfig
	packadd! editorconfig.nvim

	packadd! nvim-luapad

	packadd! nvim-treesitter
	packadd! vim-quicktask
	packadd! vim-kitty

	augroup nerd_loader
		autocmd!
		autocmd VimEnter * silent! autocmd! FileExplorer
		autocmd BufEnter,BufNew *
					\		if isdirectory(expand('<amatch>'))
					\|		call chromosore#nerdtree#load()
					\|		autocmd! nerd_loader
					\|	endif
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

" Load my lua module as a global
lua _G.chromosore = require("chromosore")
