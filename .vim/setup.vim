" vim: foldmethod=marker ts=2

let s:data_dir =   has('nvim') ? stdpath('data')   : expand('~/.vim')

" Make sure the python host is installed
if has('nvim') && empty(glob(s:data_dir .. '/pynvim'))
	silent execute "!python3 -m venv" s:data_dir .. '/pynvim'
	execute "!" .. s:data_dir .. '/pynvim/bin/' .. "pip install pynvim"
endif

" if on vim, create some dirs
if !has('nvim') && empty(glob(s:data_dir .. '/swap'))
	call mkdir(s:data_dir .. '/swap')
endif
