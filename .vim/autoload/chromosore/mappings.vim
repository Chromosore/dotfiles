function! chromosore#mappings#move()
	set operatorfunc=chromosore#mappings#move_range
	return 'g@'
endfunction

function! chromosore#mappings#move_visual()
	set operatorfunc=chromosore#mappings#move_dest
	return 'g@'
endfunction

function! chromosore#mappings#move_range(type)
	set operatorfunc=chromosore#mappings#move_dest

	call setpos("'<", [bufnr(), line("'["), 0])
	call setpos("'>", [bufnr(), line("']"), 0])

	call feedkeys('g@')
endfunction

function! chromosore#mappings#move_dest(type)
	if line("'<") == line("']")
		call setpos("']", [bufnr(), line("'[") - 1, 0])
	elseif line("']") < line("'>")
		call setpos("']", [bufnr(), line("'>") - line("'<") + line("']"), 0])
	endif

	execute "'<,'>move" line("']")
endfunction
