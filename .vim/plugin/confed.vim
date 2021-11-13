let s:confed_vim_path = join(split($CONFED_PATH, ':'), ',')

function! s:CompleteConfed(ArgLead, CmdLine, CursorPos)
	let paths = []
	let dirs_comps = substitute(a:ArgLead, '[^/]*$', '', '')

	for dir in split(s:confed_vim_path, ',')
		if !isdirectory(dir . '/' . dirs_comps) | continue | endif

		let all_files = map(map(
					\ readdir(dir . '/' . dirs_comps),
					\ {idx, filename -> dirs_comps . filename}),
					\ {idx, file -> isdirectory(dir . '/' . file) ? file . '/' : file})

		let paths = extend(paths, all_files)
	endfor

	return join(uniq(sort(paths)), "\n")
endfunction

command! -complete=custom,s:CompleteConfed -nargs=1 Confed execute 'args' join(
			\ map(globpath(s:confed_vim_path, <f-args>, v:false, v:true),
			\	    'fnameescape(v:val)'),
			\ ' ')
