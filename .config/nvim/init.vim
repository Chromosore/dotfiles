" vim: foldmethod=marker ts=2 sw=2
" {{{ Compat
let s:config_dir = has('nvim') ? stdpath('config') : expand('~/.vim')
let s:data_dir =   has('nvim') ? stdpath('data')   : expand('~/.vim')
" }}}

execute 'source' s:config_dir . '/plugins.vim'

" {{{ Theme
"     =====

function! s:SetBackground(color)
	if g:colors_name == 'solarized'
		let &background = a:color
	elseif g:colors_name =~ '^OceanicNext'
		let l:theme = a:color == 'light' ? 'Light' : ''
		let l:colorscheme = 'OceanicNext' . l:theme
		execute 'colorscheme' l:colorscheme
	endif
endfunction

if has('gui_macvim')
	function! s:MacVimSetBackground()
		if v:os_appearance == 0
			call s:SetBackground('light')
		else
			call s:SetBackground('dark')
		endif
	endfunction

	augroup MacVimThemeChange
		autocmd!
		autocmd OSAppearanceChanged * call s:MacVimSetBackground()
	augroup END
elseif !empty(glob(s:config_dir . '/background.vim'))
	execute 'source' s:config_dir . '/background.vim'
endif

if $TERM == "linux"
	set background=dark
endif

" Smol fix in solarized
"if has('termguicolors')
	"if ! exists("g:colo_aucmd")
		"let g:colo_aucmd = 1

		"function SetTermGuiColors()
			"if g:colors_name == "solarized"
				"set notermguicolors
			"else
				"set termguicolors
			"endif
		"endfunction

		"autocmd ColorScheme * call SetTermGuiColors()
	"end
"endif

if has('termguicolors')
	set termguicolors
endif

"let g:lightline = { 'colorscheme': 'challenger_deep' }
let g:badwolf_darkgutter=1
"let g:solarized_termcolors=256

colorscheme solarized

" }}}

" {{{ UI
"     ==
set list
set listchars=tab:\ \ 

if has("gui_running") || exists("goneovim")
	if has('gui_gtk')
		set guifont=Menlo\ Nerd\ Font\ 11
	elseif has('gui_macvim')
		set guifont=Menlo\ Nerd\ Font:h11
	endif
endif

if !exists("goneovim")
	" indent guides
	set listchars+=tab:\⎸\ 
	let g:indentLine_char = '⎸'
	"let g:indentLine_setColors = 0

	augroup ConcealHighlight
		autocmd!
		if has('nvim')
			highlight! link Whitespace Conceal
			autocmd ColorScheme * highlight! link Whitespace Conceal
		else
			highlight! link SpecialKey Conceal
			autocmd ColorScheme * highlight! link SpecialKey Conceal
		endif
	augroup END
endif


" Replaced by terminus
"if !has('nvim') && &term =~ "xterm"
	"let &t_VS = "\<Esc>[1 q"
	"let &t_SI = "\<Esc>[5 q"
	"let &t_SR = "\<Esc>[3 q"
	"let &t_EI = "\<Esc>[1 q"
"endif

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_left_sep = ""
"let g:airline_right_sep = ""

" Window size
if has('gui_running') || exists('goneovim')
	set lines=42
	set columns=132
endif

" Disable toolbar in gui
set guioptions-=T

" Remove scrollbars in gui
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

set laststatus=2 " Always display statusline
let &statusline = "%<%f %h%m%r%=%-14.(%y %l,%c%V%) %P"

" Show Non Breakable Spaces
set listchars+=nbsp:█
set tabstop=4

set number
set hlsearch

" Panes split
set splitbelow
set splitright
set fillchars+=vert:│
if has("gui_running")
	highlight VertSplit guifg=fg guibg=bg
else
	highlight VertSplit ctermfg=fg ctermbg=bg
endif

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
"nmap ++ <plug>CommentaryLine
"vmap ++ <plug>Commentary

imap fd <esc>
vmap fd <esc>
omap fd <esc>

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

" }}}

" {{{ Misc
"     ====
set modeline
set ttimeoutlen=100

" LEADER KEY !!!
let mapleader=","

" Find files
set path+=**
set wildignore+=node_modules

let g:indentLine_fileTypeExclude = ['text', 'nerdtree']
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'nofile', 'quickfix']
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']

let g:deoplete#enable_at_startup = 1

let g:python3_host_prog = s:data_dir . '/pynvim/bin/python3'

if !has('nvim')
	execute "set viminfofile=" . s:data_dir . '/viminfo'
end

" {{{ NetRW
let g:netrw_banner = 0			" No annoying banner
let g:netrw_browse_split = 4	" Open in prior window
let g:netrw_altv = 1			" Open splits to the right
let g:netrw_liststyle = 3		" Tree view
let g:netrw_winsize = 25		" Width: 25% of the page
let netrw_ghregex = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide .= ',' . netrw_ghregex
let g:netrw_list_hide .= ',' . &wildignore
" }}}

" {{{ NerdTree
"let g:NERDTreeDirArrowExpandable = ''
"let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeMinimalUI = 1
let NERDTreeBookmarksFile = s:config_dir . '/NERDTreeBookmarks'
let g:NERDTreeGitStatusUseNerdFonts = 1

" Close vim if NERDTree is the only open buffer
autocmd BufEnter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() |
	\ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" {{{ BringBackNerdTree()
function BringBackNerdTree()
	if bufname('#') !~ 'NERD_tree_\d\+' | return | endif
	if bufname('%') =~ 'NERD_tree_\d\+' | return | endif
	if winnr('$') <= 1 | return | endif

	let new_buf = bufnr()
	buffer #
	if !exists('b:NERDTree') | return | endif

	if b:NERDTree.isWinTree()
		buffer #
		return
	endif

	execute "normal! \<C-W>w"
	execute 'buffer' . new_buf
endfunction
" }}}
autocmd BufEnter * call BringBackNerdTree()

" Lazy loading requires to reload the buffer when opening a netrw listing
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END
" }}}

" Close vim if a quickfix window is the only open buffer
autocmd BufEnter * if winnr("$") == 1 && &buftype == "quickfix" |
	\ quit | endif

" Rust tags
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
"autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

if !exists(':Confed')
	command -nargs=1 Confed execute 'e' system('confed -s <args>')
endif

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" }}}

if !empty(glob(s:config_dir . '/local.vim'))
	execute "source" s:config_dir . '/local.vim'
endif
