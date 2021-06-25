" vim: foldmethod=marker ts=2

let s:config_dir = has('nvim') ? stdpath('config') : expand('~/.vim')
let s:data_dir =   has('nvim') ? stdpath('data')   : expand('~/.vim')

let s:autoload_dir = has('nvim') ? s:data_dir .. '/site/autoload' : s:data_dir .. '/autoload'

" install vim-plug
if empty(glob(s:autoload_dir .. '/plug.vim'))
	echo 'Installing Vim-Plug'
	execute "!curl" "-fLo" s:autoload_dir .. '/plug.vim' "--create-dirs"
	\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

" Make sure the python host is installed
if has('nvim') && empty(glob(s:data_dir .. '/pynvim'))
	silent execute "!python3 -m venv" s:data_dir .. '/pynvim'
	execute "!" .. s:data_dir .. '/pynvim/bin/' .. "pip install pynvim"
endif

" if on vim, create some dirs
if !has('nvim') && empty(glob(s:data_dir .. '/swap'))
	call mkdir(s:data_dir .. '/swap')
endif
