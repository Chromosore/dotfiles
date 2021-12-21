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

	if g:NERDTree.IsOpen() && !exists('b:NERDTree')
		call g:NERDTree.CursorToTreeWin(0)
	else
		call g:NERDTreeCreator.ToggleTabTree('')
	endif
endfunction

function! chromosore#nerdtree#go_up()
	if exists('b:NERDTree')
		normal u
	else
		let file = expand('%:p')
		let directory = fnamemodify(file, ':h')

		if !isdirectory(directory)
			edit .
			return
		endif

		execute 'edit' directory
		try
			let node = b:NERDTree.root.reveal(g:NERDTreePath.New(file))
			call b:NERDTree.render()
			call node.putCursorHere(1, 0)
		catch /^NERDTree.InvalidArgumentsError: .*$/
		endtry
	endif
endfun
