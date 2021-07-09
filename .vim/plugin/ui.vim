" Window settings
if has('gui_running')
	if has('gui_gtk')
		set guifont=Menlo\ Nerd\ Font\ 12,Menlo\ 12
	elseif has('gui_macvim') || has('gui_win32')
		set guifont=Menlo\ Nerd\ Font:h12,Menlo:h12
	endif

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

set scrolloff=5

if has('termguicolors')
	set termguicolors
endif

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

	set list
	set listchars=
	set listchars+=nbsp:█
	execute 'set listchars+=tab:' .escape(g:indentLine_char, '|'). '\ '
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
