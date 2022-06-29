" Generic options
set hlsearch
set incsearch
set shortmess-=S


" Setup
let g:chimera_do_mappings = v:false
nnoremap <Plug>(himatch-next) <Cmd>lua require("highlight_current_n")["/,?"]()<CR>


" / and ?
nmap / <Plug>(chimera-skip)<Plug>(chimera-/)
nmap ? <Plug>(chimera-skip)<Plug>(chimera-?)

augroup kmz-highlight-match
	au!
	au CmdlineLeave /,\? lua require("highlight_current_n")["/,?"]()
augroup end


" The other mappings
nmap n  <Plug>(chimera-skip)<Plug>(himatch-next)<Plug>(chimera-n)
nmap N  <Plug>(chimera-skip)<Plug>(himatch-next)<Plug>(chimera-N)
nmap *  <Plug>(chimera-skip)<Plug>(himatch-next)<Plug>(chimera-*)
nmap #  <Plug>(chimera-skip)<Plug>(himatch-next)<Plug>(chimera-#)
nmap g* <Plug>(chimera-skip)<Plug>(himatch-next)<Plug>(chimera-g*)
nmap g# <Plug>(chimera-skip)<Plug>(himatch-next)<Plug>(chimera-g#)


" Just in case
nnoremap <C-L> <nop>

" vim: fdm=marker fmr=[[[,]]]
