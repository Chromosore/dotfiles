" I hate these files so I throw them away :)
let &directory = chromosore#local#data . expand('/swap//')

let &backupdir = chromosore#local#data . expand('/backup//')

if has('persistent_undo')
	set undofile
	let &undodir = chromosore#local#data . expand('/undo//')
endif

if has('viminfo') && &viminfofile == ''
	let &viminfofile = chromosore#local#data . expand('/viminfo')
endif

set autoread

" Faster Macros
set lazyredraw

set textwidth=76

set modeline
set modelines=5

set ttimeoutlen=100

" Thanks to spellsitter it spellchecking comments also works with tree-sitter
set spell

if has('wildmenu')
	set wildmenu
endif
set wildmode=longest:full,full
