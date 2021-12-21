function! LoadNerdTreeFocusAndToggle()
	if !exists('loaded_nerd_tree') || loaded_nerd_tree != 1
		packadd vim-nerdtree-syntax-highlight
		packadd nerdtree
	endif

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

function s:go_up()
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

nmap <C-n> :call LoadNerdTreeFocusAndToggle()<CR>
nmap - <Cmd>call <SID>go_up()<CR>

imap fd <esc>
vmap fd <esc>
omap fd <esc>

" Stay in visual mode when you indent
vmap < <gv
vmap > >gv

" Vim - Semi Hard Mode
" no arrow key navigation
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

cmap <C-P> <Up>
cmap <C-N> <Down>

" Logical Y
nmap Y y$

nmap <expr> gm chromosore#mappings#move()
nmap <expr> gmm chromosore#mappings#move() . '_'
vmap <expr> gm chromosore#mappings#move_visual()

" Familiar copy/cut/paste to clipboard shortcuts
if has('clipboard')
	nmap <C-C> "+yy
	vmap <C-C> "+y
	nmap <C-V> "+p
endif

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
