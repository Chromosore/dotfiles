let s:confed_vim_path = join(split($CONFED_PATH, ':'), ',')

function! s:CompleteConfed(ArgLead, CmdLine, CursorPos)
	let paths = []
	let dirs_comps = substitute(a:ArgLead, '[^/]*$', '', '')

	for dir in split(s:confed_vim_path, ',')
		if !isdirectory(dir . '/' . dirs_comps) | continue | endif

		let all_files = readdir(dir . '/' . dirs_comps)
					\->map({idx, filename -> dirs_comps . filename})
					\->map({idx, file -> isdirectory(dir . '/' . file) ? file . '/' : file})

		let paths = paths->add(join(all_files, "\n"))
	endfor

	return join(paths, "\n")
endfunction
command! -complete=custom,s:CompleteConfed -nargs=1 Confed execute 'edit' globpath(s:confed_vim_path, <f-args>)

finish

function s:FindConfedProtocol()
	if !match(expand('<amatch>'), '^c:') | return -1

	let fname = substitute(expand('<amatch>'), '^c:', '', '')

	if filereadable(chromosore#config . fname . '.vim')
		let suffix = '.vim'
	else
		let suffix = ''
	endif

	return chromosore#config . fname . suffix
endfunction

augroup ConfedProtocol
	autocmd BufEnter *
				\	let conf_file = <SID>FindConfedProtocol()
				\|	execute conf_file == -1 ? "echoerr 'No such configuration file'" : 'edit' conf_file
augroup END
