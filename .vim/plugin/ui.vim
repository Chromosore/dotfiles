" Window settings
set scrolloff=5

if has('termguicolors')
	set termguicolors
endif

let &statusline = "%<%f %h%m%r%=%-14.(%l/%L :%c%V%) %y %P"
set laststatus=2 " Always display statusline
set ruler

" Whitespaces
set tabstop=4
set shiftwidth=0

" indent guides
if has('conceal')
	if !has('gui_win32')
		let g:indentLine_char = '⎸'
	else
		let g:indentLine_char = '|'
	end
	let g:indentLine_setColors = 0

	if has('nvim')
		" It looks too awful in vim
		set list
		set listchars=
		set listchars+=nbsp:█
		execute 'set listchars+=tab:' .g:indentLine_char. '\ '
	endif
else
	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * highlight link IndentGuidesOdd  FoldColumn
	autocmd VimEnter,Colorscheme * highlight link IndentGuidesEven CursorColumn
endif

set number
set relativenumber
if has('patch-8.1.1564') || has('nvim-0.5.0')
	set signcolumn=number
end

if has('linebreak')
	set linebreak
	augroup ShowBreakStyle
		autocmd!
		function s:SetShowBreak()
			let new_showbreak = repeat(' ', &numberwidth - 1) . '↳'
			if v:option_type == 'local'
				let &l:showbreak = new_showbreak
			else
				let &showbreak = new_showbreak
			endif
		endfunction

		autocmd OptionSet numberwidth call <SID>SetShowBreak()
		autocmd BufWinEnter * if !&number | setlocal showbreak=NONE | endif
		call s:SetShowBreak()
		set cpoptions+=n

		if has('nvim')
			autocmd WinNew set winhighlight+=NonText:LineNr
			set winhighlight+=NonText:LineNr
		else
			set highlight+=@:LineNr
		endif
	augroup END
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
