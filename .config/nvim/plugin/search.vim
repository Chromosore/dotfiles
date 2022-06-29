" Generic options
set hlsearch
set incsearch
set shortmess-=S


" Setup
let g:chimera_do_mappings = v:false
nnoremap <Plug>(himatch-next) <Cmd>lua require("highlight_current_n")["/,?"]()<CR>


" / and ?
for m in ["n", "o", "x"]
	exec m.."map" "/" "<Plug>(chimera-skip)<Plug>(chimera-/)"
	exec m.."map" "?" "<Plug>(chimera-skip)<Plug>(chimera-?)"
endfor

augroup kmz-highlight-match
	au!
	au CmdlineLeave /,\? lua require("highlight_current_n")["/,?"]()
augroup end


" The other mappings
for m in ["n", "o", "x"]
	for key in ["n", "N", "*", "#", "g*", "g#"]
		exec printf(
					\ "%smap %s <Plug>(chimera-skip)<Plug>(himatch-next)<Plug>(chimera-%s)",
					\ m, key, key)
	endfor
endfor


" Just in case
nnoremap <C-L> <nop>

" vim: fdm=marker fmr=[[[,]]]
