command! -nargs=* -complete=shellcmd Man
			\	delcommand Man
			\|	runtime! ftplugin/man.vim
			\|	Man <args>
