" Borrowed from fzf.vim
let s:is_win = has('win32') || has('win64')

function s:shortpath()
	let short = fnamemodify(getcwd(), ':~:.')
	if !has('win32unix')
		let short = pathshorten(short)
	endif
	let slash = (s:is_win && !&shellslash) ? '\' : '/'
	return empty(short) ? '~'.slash : short . (short =~ escape(slash, '\').'$' ? '' : slash)
endfunction


function chromosore#fzf#cwd()
	let prompt = s:shortpath()
	let prompt = strwidth(prompt) < &columns - 20 ? prompt : '> '
	call fzf#run(fzf#wrap('FZF', {
		\	'options': ['--prompt', prompt],
		\}))
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
