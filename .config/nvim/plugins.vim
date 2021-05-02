" {{{ Plug Autocmds
"     =============
" vim: foldmethod=marker

" install vim-plug
let data_dir = has('nvim') ? stdpath('data') : '~/.vim'
let autoload_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(autoload_dir . '/autoload/plug.vim'))
	echo 'Installing Vim-Plug'
	execute "!curl" "-fLo" autoload_dir . '/autoload/plug.vim' "--create-dirs"
	\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * ++once if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\| endif
" }}}
" {{{ Python Host
"     ===========
" Make sure the python host is installed
if empty(glob(data_dir . '/pynvim'))
	silent execute "!python3 -m venv" data_dir . '/pynvim'
	execute "!" . data_dir . '/pynvim/bin/' . "pip install pynvim"
endif
" }}}
" {{{ Cond
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
" }}}

call plug#begin(data_dir . '/plugged')

" Registers vim-plug as a plugin (for help)
Plug 'junegunn/vim-plug'

" sensible.vim : a universal set of defaults
Plug 'tpope/vim-sensible'


" vim-polyglot: No more language plugin to install
Plug 'sheerun/vim-polyglot'

Plug 'preservim/nerdcommenter'

Plug 'ryanoasis/vim-devicons'

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"Plug 'itchyny/lightline.vim'

"Plug 'mhinz/vim-startify'

Plug 'akiyosi/gonvim-fuzzy', Cond(exists('goneovim'))
"Plug 'nathanaelkane/vim-indent-guides', Cond(!exists('goneovim'))
Plug 'Yggdroot/indentLine', Cond(!exists('goneovim') && has('conceal'))

Plug 'preservim/nerdtree', Cond(!exists('goneovim'))

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
