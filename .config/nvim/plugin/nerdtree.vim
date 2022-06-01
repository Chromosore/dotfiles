let NERDTreeMinimalUI = 1
let NERDTreeBookmarksFile = chromosore#config . expand('/NERDTreeBookmarks')

" Close vim if NERDTree is the only open buffer
autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() |
	\ quit | endif
