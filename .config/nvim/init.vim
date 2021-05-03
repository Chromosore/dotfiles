" vim: foldmethod=marker
" {{{ Compat
" }}}

execute 'source' stdpath('config') . '/plugins.vim'

" {{{ Theme
"     =====

if !empty(glob(stdpath('config') . '/background.vim'))
	execute 'source' stdpath('config') . '/background.vim'
endif

if $TERM == "linux"
	set background=dark
endif

if has('termguicolors')
	if ! exists("g:colo_aucmd")
		let g:colo_aucmd = 1

		function SetTermGuiColors()
			if g:colors_name == "solarized"
				set notermguicolors
			else
				set termguicolors
			endif
		endfunction

		autocmd ColorScheme * call SetTermGuiColors()
	end
endif

if exists("goneovim")
	set guifont=Menlo
	colorscheme challenger_deep
else
	colorscheme solarized
endif

" }}}

" {{{ UI
"     ==
set list
set listchars=

if ! exists("goneovim")
	" indent guides
	set listchars+=tab:\│\ 
	let g:indentLine_char = '│'
endif

"let g:lightline = { 'colorscheme': 'challenger_deep' }
let g:badwolf_darkgutter=1

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_left_sep = ""
"let g:airline_right_sep = ""

let &statusline = "%<%f %h%m%r%=%-14.(%y %l,%c%V%) %P"

" NetRW File Browser
let g:netrw_banner = 0		" No annoying banner
let g:netrw_browse_split = 4	" Open in prior window
let g:netrw_altv = 1		" Open splits to the right
let g:netrw_liststyle = 3	" Tree view
let g:netrw_list_hide = netrw_gitignore#Hide()

set number

" Panes split
set splitbelow
set splitright
set fillchars+=vert:│
highlight VertSplit ctermfg=fg ctermbg=bg

" Faster Macros
set lazyredraw

" }}}

" {{{ Bindings
"     ========

if exists("goneovim")
	map <C-p> :GonvimFuzzyFiles<CR>
	map <C-n> :GonvimFilerOpen<CR>
else
	map <C-n> :NERDTreeToggle<CR>
	map <C-b> :NERDTreeFocus<CR>
endif

map ++ <plug>NERDCommenterToggle

imap fd <esc>
vmap fd <esc>
omap fd <esc>

"" j/k will move virtual lines (lines that wrap)
"noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
"noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Stay in visual mode when you indent
vmap < <gv
vmap > >gv

" Vim - Semi Hard Mode
" no arrow key navigation
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Familiar copy/cut/paste to clipboard shortcuts
nmap <C-c> "+yy
vmap <C-c> "+y
nmap <C-v> "+p

"" Move between splits
"nmap <C-J> <C-W><C-j>
"nmap <C-K> <C-W><C-k>
"nmap <C-L> <C-W><C-l>
"nmap <C-H> <C-W><C-h>

" }}}

" {{{ Misc
"     ====

" LEADER KEY !!!
let mapleader=","

let g:deoplete#enable_at_startup = 1

let g:python3_host_prog = stdpath('data') . '/pynvim/bin/python3'

" NerdTree Stuff
"let g:NERDTreeDirArrowExpandable = ''
"let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeMinimalUI = 1
let NERDTreeBookmarksFile = stdpath('config') . '/NERDTreeBookmarks'

" Close vim if NERDTree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Close vim if a quickfix window is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && &buftype == "quickfix") | q | endif

if ! exists("goneovim")
	let g:indentLine_fileTypeExclude = ['text', 'sh']
	let g:indentLine_bufTypeExclude = ['help', 'terminal']
	let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
end

" Find files
set path+=**
set wildignore+=node_modules

command -nargs=1 Confed execute 'e' system('confed -s <args>')

" }}}

if !empty(glob(stdpath('config') . '/local.vim'))
	execute "source" stdpath('config') . '/local.vim'
endif
