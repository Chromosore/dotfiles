fun! chromosore#justify#justify(force = v:false, length = v:null) range
	call luaeval(
				\ 'chromosore.commands.justify(_A[1], _A[2],'
				\ ..'                          _A[3] == vim.NIL and nil or _A[3],'
				\ ..'                          _A[4] == vim.NIL and nil or _A[4])',
				\ [a:firstline, a:lastline, a:length, a:force ? -1 : v:null])
endfun
