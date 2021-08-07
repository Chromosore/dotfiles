" vim: foldmethod=marker ts=2

" Make sure the python host is installed
if has('nvim') && empty(glob(chromosore#data .. '/pynvim'))
	silent execute "!python3 -m venv" chromosore#data .. '/pynvim'
	execute "!" .. chromosore#data .. '/pynvim/bin/' .. "pip install pynvim"
endif

" if on vim, create some dirs
if !has('nvim') && empty(glob(chromosore#data .. '/swap'))
	call mkdir(chromosore#data .. '/swap')
endif
