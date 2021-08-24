function chromosore#nerdtree#load()
	if exists('loaded_nerd_tree') && loaded_nerd_tree == 1
		return
	endif

	if has('conceal')
		packadd vim-nerdtree-syntax-highlight
		let g:webdevicons_enable_nerdtree = 1
	else
		let g:webdevicons_enable_nerdtree = 0
	endif

	packadd nerdtree
endfunction

function! chromosore#nerdtree#focus_and_toggle()
	call chromosore#nerdtree#load()

	nmap <C-n> :call NERDTreeFocusAndToggle()<CR>
	call NERDTreeFocusAndToggle()
endfunction

function! NERDTreeFocusAndToggle()
	if g:NERDTree.IsOpen() && !exists('b:NERDTree')
		call g:NERDTree.CursorToTreeWin(0)
	else
		call g:NERDTreeCreator.ToggleTabTree('')
	endif
endfunction
