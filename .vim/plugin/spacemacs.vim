" vim: fdm=marker
" Spacemacs like keys

let mapleader = ' '

nmap <silent> <leader><leader> :call chromosore#fzf#cmd()<CR>
nmap <leader><tab> <C-^>
nmap <leader>; <plug>Commentary
vmap <leader>; <plug>Commentary

" SPC f -> files
nmap <silent> <leader>ff :call chromosore#fzf#find()<CR>
nmap <silent> <leader>fd :call chromosore#fzf#cwd()<CR>
nmap <silent> <leader>fr :call chromosore#fzf#mru()<CR>
nmap <leader>fs :write<CR>
nmap <silent> <leader>fS :wall<CR>

" SPC s -> search
nmap <leader>sc :nohlsearch<CR>

" SPC a -> applications
nmap <silent> <leader>au :UndotreeShow<CR>:UndotreeFocus<CR>

" SPC e -> errors
nmap <silent> <leader>en :cnext<CR>
nmap <silent> <leader>ep :cprevious<CR>
