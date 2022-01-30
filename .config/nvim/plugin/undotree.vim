let g:undotree_DiffAutoOpen = 0
command! UndotreeShow
			\		delcommand UndotreeShow
			\|	packadd undotree
			\|	UndotreeShow
