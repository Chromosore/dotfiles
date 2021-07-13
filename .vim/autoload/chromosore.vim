let chromosore#has_powerline = 0

if has('gui_running')
	if &guifont =~ 'Nerd Font\(:h\d\+\| \d\+\)\?$'
		let chromosore#has_powerline = 1
	endif
endif
