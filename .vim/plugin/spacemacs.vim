" vim: fdm=marker
" Spacemacs like keys

let mapleader = ' '

nmap <leader><leader> :call chromosore#fzf#cmd()<CR>
nmap <leader><tab> <C-^>
nmap <leader>; <plug>Commentary
vmap <leader>; <plug>Commentary

" SPC f -> files
nmap <leader>ff :call chromosore#fzf#find()<CR>
nmap <leader>fd :call chromosore#fzf#cwd()<CR>
nmap <leader>fr :call chromosore#fzf#mru()<CR>
nmap <leader>fs :write<CR>
nmap <leader>fS :wall<CR>

" SPC s -> search
nmap <leader>sc :nohlsearch<CR>

" SPC a -> applications
nmap <leader>au :UndotreeShow<CR>:UndotreeFocus<CR>

" SPC e -> errors
nmap <leader>en :cnext<CR>
nmap <leader>ep :cprevious<CR>
