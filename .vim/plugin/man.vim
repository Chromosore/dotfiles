command! -nargs=* Man
			\	delcommand Man
			\|	runtime! ftplugin/man.vim
			\|	Man <args>
