" Window settings
set scrolloff=5

if has('termguicolors')
	set termguicolors
endif

let &statusline = "%<%f %{&ft!=''?'('..&ft..') ':''}%m%r%=%-14(.%l/%L :%c%V%) %P"
set laststatus=2 " Always display statusline
set ruler

set tabline=%!v:lua.chromosore.tabline.render()
set showtabline=2

" Whitespaces
set tabstop=4
set shiftwidth=0

set number
set relativenumber
if has('patch-8.1.1564') || has('nvim-0.5.0')
	set signcolumn=number
end

if has('linebreak')
	set linebreak
endif

set showcmd

" Panes split
set splitbelow
set splitright
set fillchars+=vert:│
