" vim: foldmethod=marker ts=2
if !has('nvim')
	scriptversion 4
endif

" sensible.vim : a universal set of defaults
packadd! vim-sensible

packadd! vim-commentary

packadd! vim-devicons

"packadd! vim-airline
"packadd! vim-airline-themes'

"packadd! lightline.vim

"packadd! vim-startify

"packadd! fzf

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
				\|		packadd nerdtree
				\|		packadd vim-nerdtree-syntax-highlight
				"\		packadd nerdtree-git-plugin
				\|		autocmd! nerd_loader
				\|	endif
augroup END


augroup PackLazyLoad
	autocmd!
	autocmd FileType typescript ++once
				\ packadd tsuquyomi
augroup END
