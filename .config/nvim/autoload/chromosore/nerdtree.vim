function! chromosore#nerdtree#focus_and_toggle()
	lua require("lazily").load("nerdtree")

	if g:NERDTree.IsOpen() && !exists('b:NERDTree')
		call g:NERDTree.CursorToTreeWin(0)
	else
		call g:NERDTreeCreator.ToggleTabTree('')
	endif
endfunction


function! chromosore#nerdtree#go_up()
	if exists('b:NERDTree')
		normal u
		return
	endif

	let file = expand('%:p')
	let directory = fnamemodify(file, ':h')

	let colgap = float2nr(round(0.07 * winwidth(0)))
	let rowgap = float2nr(round(0.09 * winheight(0)))

	" Open a popup window
	let buf = nvim_create_buf(v:false, v:false)
	call nvim_open_win(buf, v:true, #{
				\ relative: 'win',
				\ width:  winwidth(0)  - &numberwidth - colgap*2 - 2,
				\ height: winheight(0) - &cmdheight   - rowgap*2 - 2,
				\ col: &numberwidth + colgap,
				\ row: rowgap,
				\ border: 'rounded',
				\})

	set winhighlight+=NormalFloat:Normal,FloatBorder:Normal
	set winblend=5
	set fillchars+=eob:\ 
	au WinLeave * ++once quit

	if !isdirectory(directory)
		let directory = '.'
	endif

	execute 'edit' fnameescape(directory)

	nnoremap <buffer> q    <Cmd>quit<CR>
	nnoremap <buffer> <CR> <Cmd>call <SID>nerdtree_floatwin_open()<CR>

	try
		let node = b:NERDTree.root.reveal(g:NERDTreePath.New(file))
		call b:NERDTree.render()
		call node.putCursorHere(1, 0)
	catch /^NERDTree.InvalidArgumentsError: .*$/
	endtry
endfunction


function! s:nerdtree_floatwin_open()
	let node = g:NERDTreeFileNode.GetSelected()

	if !node.path.isDirectory
		let prev_win = winnr('#')
		quit
		execute prev_win .. 'wincmd w'
		execute 'edit' fnameescape(node.path.str())
	else
		call nerdtree#ui_glue#invokeKeyMap("<CR>")
	endif
endfunction
