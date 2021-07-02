let g:netrw_banner = 0			" No annoying banner
let g:netrw_browse_split = 4	" Open in prior window
let g:netrw_altv = 1			" Open splits to the right
let g:netrw_liststyle = 3		" Tree view
let g:netrw_winsize = 25		" Width: 25% of the page
let netrw_ghregex = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide ..= ',' .. netrw_ghregex
let g:netrw_list_hide ..= ',' .. &wildignore
