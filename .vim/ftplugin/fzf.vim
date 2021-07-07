let s:laststatus_save = &laststatus
let s:showmode_save = &showmode
let s:ruler_save = &ruler

set laststatus=0 noshowmode noruler

autocmd BufLeave <buffer>
			\		let &laststatus = s:laststatus_save
			\|	let &showmode = s:showmode_save
			\|	let &ruler = s:ruler_save
