let s:config_dir = has('nvim') ? stdpath('config') : expand('~/.vim')

"let g:NERDTreeDirArrowExpandable = ''
"let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeMinimalUI = 1
let NERDTreeBookmarksFile = s:config_dir . expand('/NERDTreeBookmarks')
let g:NERDTreeGitStatusUseNerdFonts = 1

" Close vim if NERDTree is the only open buffer
autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() |
	\ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.

function BringBackNerdTree()
	if bufname('#') !~ 'NERD_tree_\d\+' | return | endif
	if bufname('%') =~ 'NERD_tree_\d\+' | return | endif
	if winnr('$') <= 1 | return | endif

	let l:save_hidden = &hidden
	let &hidden = 1

	let l:new_buf = bufnr()
	buffer #

	if exists('b:NERDTree') && !b:NERDTree.isWinTree()
		execute "normal! \<C-W>w"
	endif

	execute 'buffer' . l:new_buf
	let &hidden = l:save_hidden
endfunction

autocmd BufEnter * call BringBackNerdTree()
