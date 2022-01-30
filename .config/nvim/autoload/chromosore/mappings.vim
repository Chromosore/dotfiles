function! chromosore#mappings#move()
	set operatorfunc=chromosore#mappings#move_range
	return 'g@'
endfunction


function! chromosore#mappings#move_visual()
	set operatorfunc=chromosore#mappings#move_dest
	return 'g@'
endfunction



function s:setmark(mark, line)
	call setpos(a:mark, [bufnr(), a:line, 0])
endfunction


function! chromosore#mappings#move_range(type)
	set operatorfunc=chromosore#mappings#move_dest

	call s:setmark("'<", line("'["))
	call s:setmark("'>", line("']"))

	call feedkeys('g@')
endfunction


function! chromosore#mappings#move_dest(type)
	let selection_start = line("'<")
	let selection_end = line("'>")

	let motion_start = line("'[")
	let motion_end = line("']")

	let motion_size = motion_end - motion_start


	if motion_start < selection_start && motion_end <= selection_end
		call s:setmark("']", selection_start - motion_size - 1)
	elseif selection_start < motion_start && motion_end <= selection_end
		call s:setmark("']", selection_start - motion_size - 1)
	else
		call s:setmark("']", selection_end + motion_size)
	endif

	execute "'<,'>move" line("']")
endfunction
