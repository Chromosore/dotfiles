if has('nvim')
	let s:config_dir = stdpath('config')
elseif has('win16') || has('win32') || has('win64')
	let s:config_dir = expand('~/vimfiles')
else
	let s:config_dir = expand('~/.vim')
end

" I hate these files so I throw them away :)
let &directory = s:config_dir . expand('/swap//')

let &backupdir = s:config_dir . expand('/backup//')

if has('persistent_undo')
	set undofile
	let &undodir = s:config_dir . expand('/undo//')
endif

if has('viminfo')
	let &viminfofile = s:config_dir . expand('/viminfo')
elseif has('shada')
	let &shadafile = s:config_dir . expand('/shada')
endif

set autoread

" Faster Macros
set lazyredraw

if has('balloon_eval_term')
	set balloonevalterm
endif

set modeline
set modelines=5

set ttimeoutlen=100

" Find files
set path+=**

set formatoptions-=o

" Dictionnaries for completion with CTRL-X CTRL-K and CTRL-X CTRL-T
set dictionary+=/usr/share/dict/words
set thesaurus+=/usr/share/dict/thesaurus

if has('wildmenu')
	set  wildmenu
endif
set wildmode=longest:full,full
