fun! chromosore#pathed#edit(path, filename)
	let files = globpath(join(a:path, ','), a:filename, v:false, v:true)

	if len(files)
		execute 'args' join(map(files, 'fnameescape(v:val)'), ' ')
	endif
endfun


fun! chromosore#pathed#complete(path, filename)
	let files = []
	" equivalent to fnamemodify(a:filename, ':h') but keeps the trailing '/'
	" and yields an empty result if no dirname instead of '.'
	let dirname = substitute(a:filename, '[^/]*$', '', '')

	for dir in a:path
		if !isdirectory(dir .. '/' .. dirname) | continue | endif

		let dir_files = map(map(
					\ readdir(dir .. '/' .. dirname),
					\ {idx, file -> dirname .. file}),
					\ {idx, file -> isdirectory(dir .. '/' .. file)
													\ ? file .. '/' : file})

		let files = extend(files, dir_files)
	endfor

	return join(uniq(sort(files)), "\n")
endfunction
