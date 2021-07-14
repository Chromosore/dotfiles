" vim: fdm=marker
" Spacemacs like keys

let mapleader = ' '

nmap <leader><leader> :call chromosore#fzf#cmd()<CR>

nmap <silent> <leader><leader> :call chromosore#fzf#cmd()<CR>
nmap <leader><tab> <C-^>
nmap <leader>; <plug>Commentary
nmap <leader>;<leader>; <plug>CommentaryLine
nmap <leader>;; <plug>CommentaryLine
vmap <leader>; <plug>Commentary

" SPC f -> files
nmap <silent> <leader>ff :call chromosore#fzf#find()<CR>
nmap <silent> <leader>fr :call chromosore#fzf#mru()<CR>
nmap <leader>fs :write<CR>
nmap <silent> <leader>fS :wall<CR>

" SPC p -> project
nmap <silent> <leader>pf :call chromosore#fzf#cwd()<CR>

" SPC s -> search
nmap <leader>sc :nohlsearch<CR>

" SPC a -> applications
nmap <silent> <leader>au :UndotreeShow<CR>:UndotreeFocus<CR>

" SPC e -> errors
nmap <silent> <leader>en :cnext<CR>
nmap <silent> <leader>ep :cprevious<CR>

" SPC q -> quit
nmap <silent> <leader>qq :confirm :qall<CR>
nmap <silent> <leader>qQ :qall!<CR>
