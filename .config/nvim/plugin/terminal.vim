if !has('nvim') | finish | endif

" Bring the vim terminal mappings to nvim (I love them)

tnoremap <C-W><C-W> <C-\><C-N><C-W><C-W>
tnoremap <C-W>gt    <C-\><C-N>gt
tnoremap <C-W>gT    <C-\><C-N>gT

tnoremap          <C-W>:     <C-\><C-N>:
tnoremap <expr>   <C-W>"    '<C-\><C-N>"' . nr2char(getchar()) . 'pi'
tnoremap <silent> <C-W><C-C> <C-\><C-N>:call jobstop(&channel)

tnoremap <C-W>.     <C-W>
tnoremap <C-W><C-\> <C-\>

tnoremap <C-W>N     <C-\><C-N>
tnoremap <C-W><C-N> <C-\><C-N>


" Add a nvim command in the terminal which open files in the current nvim
let $PATH = stdpath('config') .. '/bin' .. ':' .. $PATH
let $EDITOR = 'nvim'
let $GIT_EDITOR = 'nvim-split'
