" vim: fdm=marker
" Spacemacs like keys

let mapleader = ' '

" SPC f -> files
nmap <leader>ff :call chromosore#fzf#cwd()<CR>
nmap <leader>fr :call chromosore#fzf#mru()<CR>
