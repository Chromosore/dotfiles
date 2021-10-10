" I hate these files so I throw them away :)
let &directory = chromosore#config . expand('/swap//')

let &backupdir = chromosore#config . expand('/backup//')

if has('persistent_undo')
	set undofile
	let &undodir = chromosore#config . expand('/undo//')
endif

if has('viminfo')
	let &viminfofile = chromosore#config . expand('/viminfo')
elseif has('shada')
	let &shadafile = chromosore#config . expand('/shada')
endif

set autoread

" Faster Macros
set lazyredraw

set ignorecase
set smartcase

set textwidth=76

if has('balloon_eval_term')
	set balloonevalterm
endif

set modeline
set modelines=5

set ttimeoutlen=100

" Find files
set path+=**

" PLEASE - STOP - SETTING - THIS - OPTION
set formatoptions-=o formatoptions+=r
augroup FormatOption
	autocmd!
	autocmd OptionSet * set formatoptions-=o formatoptions+=r
	autocmd VimEnter  * set formatoptions-=o formatoptions+=r
augroup END

" Dictionnaries for completion with CTRL-X CTRL-K and CTRL-X CTRL-T
set dictionary+=/usr/share/dict/words
set thesaurus+=/usr/share/dict/thesaurus

if has('wildmenu')
	set wildmenu
endif
set wildmode=longest:full,full
