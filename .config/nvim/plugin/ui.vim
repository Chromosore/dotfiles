" Window settings
set scrolloff=5

if has('termguicolors')
	set termguicolors
endif

let &statusline = "%<%f %h%m%r%=%-14.(.%l/%L :%c%V%) %y %P"
set laststatus=2 " Always display statusline
set ruler

set tabline=%!v:lua.chromosore.tabline()
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

" Search
set hlsearch
set incsearch
set shortmess-=S

set showcmd

" Panes split
set splitbelow
set splitright
set fillchars+=vert:│
