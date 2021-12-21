nmap <C-n>	<Cmd>call chromosore#nerdtree#focus_and_toggle()<CR>
nmap -			<Cmd>call chromosore#nerdtree#go_up()<CR>

imap fd <esc>
vmap fd <esc>
omap fd <esc>

" Stay in visual mode when you indent
vmap < <gv
vmap > >gv

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
