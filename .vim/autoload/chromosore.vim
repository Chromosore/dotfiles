let chromosore#has_powerline = 0

if has('gui_running')
	if &guifont =~ 'Nerd Font\(:h\d\+\| \d\+\)\?$'
		let chromosore#has_powerline = 1
	endif
endif

if has('nvim')
	let chromosore#config = stdpath('config')
	let chromosore#data = stdpath('data')
elseif has('win16') || has('win32') || has('win64')
	let chromosore#config = expand('~/vimfiles')
	let chromosore#data = expand('~/vimfiles')
else
	let chromosore#config = expand('~/.vim')
	let chromosore#data = expand('~/.vim')
endif
