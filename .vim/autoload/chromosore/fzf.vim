" Borrowed from fzf.vim
let s:is_win = has('win32') || has('win64')

function s:shortpath(...)
	let path = get(a:000, 0, getcwd())
	let short = fnamemodify(path, ':~:.')
	if !has('win32unix')
		let short = pathshorten(short)
	endif
	let slash = (s:is_win && !&shellslash) ? '\' : '/'
	return empty(short) ? '~'.slash : short . (short =~ escape(slash, '\').'$' ? '' : slash)
endfunction

function chromosore#fzf#cwd(...)
	let prompt = s:shortpath()
	let prompt = strwidth(prompt) < &columns - 20 ? prompt : '…/'
	let opts = { 'options': ['--prompt', prompt] }

	if a:0 == 1
		let opts = extend(opts, a:1)
	endif

	call fzf#run(fzf#wrap('FZF', opts))
endfunction



function s:uniq(list)
	let visited = {}
	let ret = []
	for l in a:list
		if !empty(l) && !has_key(visited, l)
			call add(ret, l)
			let visited[l] = 1
		endif
	endfor
	return ret
endfunction

function s:listbufs()
	return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function s:old_ignore(idx, filename)
	if len(a:filename) == 0 | return | endif
	if a:filename =~ '/doc/[^/]*$' | return 0 | endif
	if a:filename =~ 'NERD_tree_\d\+' | return 0 | endif
	if a:filename =~ '\~$' | return 0 | endif

	return 1
endfunction

function chromosore#fzf#mru()
	let oldfiles = s:uniq(map(
		\	filter([expand('%')], 'len(v:val)')
		\		+ filter(map(s:listbufs()->reverse(), 'bufname(v:val)'), function('s:old_ignore'))
		\		+ filter(v:oldfiles, function('s:old_ignore'))
		\	, "fnamemodify(v:val, ':~:.')",
		\))
	call fzf#run(fzf#wrap('mru', {
		\	'source': oldfiles,
		\	'options': ['--prompt', 'History> '],
		\}))
endfunction



function s:excommands()
	if exists('s:excache')
		return s:excache
	endif

	let help = globpath($VIMRUNTIME, 'doc/index.txt')
	if empty(help)
		return []
	endif

	let commands = []
	for line in readfile(help)
		if line =~ '^|:[^|]'
			call add(commands, matchstr(line, '^|:\zs[^|]\+\ze'))
		endif
	endfor

	let s:excache = commands
	return s:excache
endfunction

function chromosore#fzf#cmd()
	redir => commands
	silent command
	redir END

	let commands = split(commands, "\n")[1:]
				\->map({ idx, val -> matchstr(val, '^\S*\s\+\zs\S\+\ze') })
	let commands = extend(commands, s:excommands())->sort()
	call fzf#run(fzf#wrap('cmd', {
		\	'source': commands,
		\	'sink': { cmd -> feedkeys(':' . cmd . ' ') },
		\	'options': ['--prompt', ':'],
		\}))
endfunction



function s:cmpfile(file_a, file_b)
	let a_is_dot = a:file_a =~ '^\.'
	let b_is_dot = a:file_b =~ '^\.'

	if a_is_dot && !b_is_dot
		return 1
	elseif !a_is_dot && b_is_dot
		return -1
	elseif a:file_a == a:file_b
		return 0
	else
		return a:file_a > a:file_b ? 1 : -1
	end
endfunction

function s:filefound(path, filenames)
	let slash = (s:is_win && !&shellslash) ? '\' : '/'

	if a:filenames[0] == '..' . slash
		let new_path = fnamemodify(a:path, ':h')
	else
		let new_path = a:path . slash . a:filenames[0]
		let new_path = new_path[:-2]
	endif

	if isdirectory(new_path)
		call chdir(new_path)
		return chromosore#fzf#find(new_path)
	else
		execute 'edit' new_path
	endif
endfunction

function s:prettydirs(path, idx, filename)
	let slash = (s:is_win && !&shellslash) ? '\' : '/'
	let new_path = a:path . slash . a:filename
	if isdirectory(new_path)
		return a:filename . slash
	else
		return a:filename
	endif
endfunction

function chromosore#fzf#find(...)
	let path = get(a:000, 0, getcwd())
	let prompt = s:shortpath(path)
	let prompt = strwidth(prompt) < &columns - 20 ? prompt : '…/'

	let files = readdir(path, '1', { 'sort': 'none' })
				\->add('..')
				\->sort(function('s:cmpfile'))
				\->map(function('s:prettydirs', [path]))

	let spec = deepcopy(fzf#wrap('find', {
		\	'source': files,
		\	'window': ':',
		\	'options': ['--prompt', prompt, '--expect=tab', '--reverse'],
		\}))
	let spec['_action'] = get(spec, '_action', {})
	let spec['_action']['tab'] = function('s:filefound', [path])

	return fzf#run(spec)
endfunction
