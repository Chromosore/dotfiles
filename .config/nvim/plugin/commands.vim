" vim: fdm=marker fmr=\:\:,---

" confed ::1
fun! s:confed(...)
	if a:0 == 0
		edit $MYVIMRC
	else
		call chromosore#pathed#edit(split($CONFED_PATH, ':'), a:1)
	endif
endfun

fun! s:c_confed(ArgLead, CmdLine, CursorPos)
	return chromosore#pathed#complete(split($CONFED_PATH, ':'), a:ArgLead)
endfun

" runed ::1
fun! s:runed(filename)
	call chromosore#pathed#edit(nvim_list_runtime_paths(), a:filename)
endfun

fun! s:c_runed(ArgLead, CmdLine, CursorPos)
	return chromosore#pathed#complete(nvim_list_runtime_paths(), a:ArgLead)
endfun

" ---

com! -complete=custom,s:c_confed -nargs=? Confed call s:confed(<f-args>)
com! -complete=custom,s:c_runed  -nargs=1 Runed  call s:runed(<f-args>)

com! -range -nargs=? -bang Justify <line1>,<line2>call chromosore#justify#justify("<bang>" == "!", <args>)
