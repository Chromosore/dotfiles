" vim: fdm=marker fmr=\:\:,---
" confed ::1
fun! s:confed(filename)
	call chromosore#pathed#edit(split($CONFED_PATH, ':'), a:filename)
endfun

fun! s:c_confed(ArgLead, CmdLine, CursorPos)
	return chromosore#pathed#complete(split($CONFED_PATH, ':'), a:ArgLead)
endfun

" runed ::1
fun! s:runed(filename)
	call chromosore#pathed#edit(split(&rtp, ','), a:filename)
endfun

fun! s:c_runed(ArgLead, CmdLine, CursorPos)
	return chromosore#pathed#complete(split(&rtp, ','), a:ArgLead)
endfun

" ---

com! -complete=custom,s:c_confed -nargs=1 Confed call s:confed(<f-args>)
com! -complete=custom,s:c_runed  -nargs=1 Runed  call s:runed(<f-args>)
