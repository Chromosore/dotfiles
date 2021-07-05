" vim: foldmethod=marker

if has('packages')
	" sensible.vim : a universal set of defaults
	packadd! vim-sensible

	packadd! vim-commentary

	packadd! vim-devicons

	"packadd! vim-airline
	"packadd! vim-airline-themes'

	"packadd! lightline.vim

	"packadd! vim-startify

	packadd! fzf

	if has('conceal')
		packadd! indentLine
	else
		packadd! vim-indent-guides
	endif

	if !has('gui_running')
		packadd! terminus
	endif

	"packadd! vim-gitgutter

	augroup nerd_loader
		autocmd!
		autocmd VimEnter * silent! autocmd! FileExplorer
		autocmd BufEnter,BufNew *
					\		if isdirectory(expand('<amatch>'))
					\|		packadd vim-nerdtree-syntax-highlight
					\|		packadd nerdtree
					"\		packadd nerdtree-git-plugin
					\|		autocmd! nerd_loader
					\|	endif
	augroup END


	augroup PackLazyLoad
		autocmd!
		autocmd FileType typescript ++once
					\ packadd tsuquyomi
	augroup END
else
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
endif
