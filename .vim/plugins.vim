" vim: foldmethod=marker ts=2
" {{{ Plug Autocmds
"     =============
let s:config_dir = has('nvim') ? stdpath('config') : expand('~/.vim')

" Run PlugInstall if there are missing plugins
augroup VimPlugAuto
	autocmd!
	autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
		\| PlugInstall --sync | source $MYVIMRC
	\| endif | autocmd! VimPlugAuto
augroup END

" }}}
" {{{ Cond

function! Cond(cond, ...)
	let opts = get(a:000, 0, {})
	return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

function! And(...)
	let new_cond = {}
	for cond in a:000
		call extend(new_cond, cond)
	endfor
	return new_cond
endfunction
" }}}

call plug#begin(s:data_dir . '/plugged')

" Registers vim-plug as a plugin (for help)
Plug 'junegunn/vim-plug'

" sensible.vim : a universal set of defaults
Plug 'tpope/vim-sensible'


" vim-polyglot: No more language plugin to install
Plug 'sheerun/vim-polyglot'

Plug 'preservim/nerdcommenter', { 'on': '<Plug>NERDCommenterToggle' }
"Plug 'tpope/vim-commentary'

Plug 'ryanoasis/vim-devicons'

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"Plug 'itchyny/lightline.vim'

"Plug 'mhinz/vim-startify'

"Plug 'junegunn/fzf'

Plug 'Yggdroot/indentLine', Cond(has('conceal'))
"Plug 'nathanaelkane/vim-indent-guides'

Plug 'wincent/terminus', Cond(!has('gui'))

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }

"Plug 'airblade/vim-gitgutter'

" {{{ deoplete
"" deoplete.nvim - completion engine
"if has('nvim')
	"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
	"Plug 'Shougo/deoplete.nvim'
	"Plug 'roxma/nvim-yarp'
	"Plug 'roxma/vim-hug-neovim-rpc'
"endif

"" Completions sources for deoplete
"" Many languages - Generated from syntax files
"Plug 'Shougo/neco-syntax'
"" jedi
"Plug 'deoplete-plugins/deoplete-jedi'
"" JavaScript
""Plug 'wokalski/autocomplete-flow'
"" Tabnine
"if has('win32') || has('win64')
	"Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
"else
	"Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
"endif
" }}}

" Themes
"Plug 'nightsense/snow'
"Plug 'rakr/vim-one'
Plug 'altercation/vim-colors-solarized'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'
Plug 'nanotech/jellybeans.vim'
Plug 'mhartington/oceanic-next'
"Plug 'sickill/vim-monokai'
"Plug 'tomasr/molokai'
Plug 'trusktr/seti.vim'

call plug#end()
