" vim: foldmethod=marker
" Colorscheme-specific settings {{{
let g:badwolf_darkgutter = 1
" }}}

if !exists('g:colors_name')
	" A colorscheme may have been loaded before in local.vim
	let g:colors_name = 'solarized8_flat'
endif


let s:dark_to_light_theme = {
	\ 'OceanicNext': 'OceanicNextLight',
	\ 'wwdc16': 'wwdc17',
	\ }

" {{{ Light & Dark themes setup
let s:light_to_dark_theme = {}
for s:key in keys(s:dark_to_light_theme)
	let s:value = s:dark_to_light_theme[s:key]
	let s:light_to_dark_theme[s:value] = s:key
endfor
" }}}

let s:colors_name_save = ''

function! UpdateTheme()
	if !exists('g:colors_name') && s:colors_name_save != ''
		let g:colors_name = s:colors_name_save
	endif

	if &background == 'dark'
		let l:inverse_themes = s:light_to_dark_theme
	else
		let l:inverse_themes = s:dark_to_light_theme
	endif

	let l:themes = keys(l:inverse_themes)
	if index(l:themes, g:colors_name) >= 0
		execute 'colorscheme' l:inverse_themes[g:colors_name]
	endif
endfunction


if has('gui_macvim')
	function! s:MacVimSetBackground()
		if v:os_appearance == 0
			set background=light
		else
			set background=dark
		endif
	endfunction

	augroup MacVimThemeChange
		autocmd!
		autocmd OSAppearanceChanged * call s:MacVimSetBackground()
	augroup END
endif


if &term == "linux"
	set background=dark
endif

augroup chromosore_theme_switch
	au!
	au ColorScheme * let s:colors_name_save = g:colors_name
	au OptionSet background call UpdateTheme()
augroup END


execute 'colorscheme' g:colors_name
call UpdateTheme()
