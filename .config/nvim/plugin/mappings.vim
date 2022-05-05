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

nmap s   <Plug>(sandwich-add)
xmap s   <Plug>(sandwich-add)

nmap cs  <Plug>(sandwich-replace)
xmap cs  <Plug>(sandwich-replace)
nmap css <Plug>(sandwich-replace-auto)

nmap ds  <Plug>(sandwich-delete)
xmap ds  <Plug>(sandwich-delete)
nmap dss <Plug>(sandwich-delete-auto)

nnoremap gd gt
nnoremap GD gT
" And the tombstones
nnoremap gt <nop>
nnoremap gT <nop>

" And the new way of doing this
nnoremap GG G
nnoremap G <nop>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
