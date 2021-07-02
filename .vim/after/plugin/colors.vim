if !exists('g:colors_name')
	" A colorscheme may have been loaded before in local.vim
	colorscheme solarized8_flat
endif


let s:reversible_themes = [
	\ 'solarized8',
	\ 'solarized8_flat',
	\ 'gruvbox',
	\ 'snow',
	\ 'one',
	\ ]
let s:dark_to_light_theme = {
	\ 'OceanicNext': 'OceanicNextLight',
	\ }
" {{{ Light & Dark themes setup
let s:light_to_dark_theme = {}
for s:key in keys(s:dark_to_light_theme)
	let s:value = s:dark_to_light_theme[s:key]
	let s:light_to_dark_theme[s:value] = s:key
endfor
" }}}

function! SetBackground(color)
	let g:theme = a:color

	if index(s:reversible_themes, g:colors_name) >= 0
		let &background = a:color
	else
		if a:color == 'dark'
			let l:inverse_themes = s:light_to_dark_theme
		else
			let l:inverse_themes = s:dark_to_light_theme
		endif

		let l:themes = keys(l:inverse_themes)
		if index(l:themes, g:colors_name) >= 0
			execute 'colorscheme' l:inverse_themes[g:colors_name]
		endif
	endif
endfunction


if has('gui_macvim')
	function! s:MacVimSetBackground()
		if v:os_appearance == 0
			call SetBackground('light')
		else
			call SetBackground('dark')
		endif
	endfunction

	augroup MacVimThemeChange
		autocmd!
		autocmd OSAppearanceChanged * call s:MacVimSetBackground()
	augroup END
endif

if !exists('g:theme')
	let g:theme = 'light'
endif

if &term == "linux"
	let g:theme = 'dark'
endif


if !has('gui_macvim')
	call SetBackground(g:theme)
endif
