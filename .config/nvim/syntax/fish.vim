" Vim syntax file
" Language:			fish
" Maintainer:		Chromosore <raphi@babinux.com>
" Last Change:	2021 Dec 3

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'fish'


syn iskeyword !-~,^;,^|,^&,^(,^),192-255

syn match fishStringEscapeSingle /\\['\\]/ contains=fishStringEscape contained
syn match fishStringEscapeDouble /\\["$\\]/ contains=fishStringEscape contained

syn region fishString start=/'/ end=/'/ contains=fishStringEscapeSingle              contained
syn region fishString start=/"/ end=/"/ contains=fishStringEscapeDouble,fishVariable contained


syn match fishVariable /\v\$[a-zA-Z0-9_]+%(\[%(\d+%(\.\.\d+)?)?%( \d+%(\.\.\d+)?)*\])?/ contained

syn match fishEscape /\v\\%([aefnrtv $\\*?~#(){}[\]<>^&|;"']|x\x{,2}|X\x{,2}|o\o{,3}|u\x{,4}|U\x{,8}|c\a)/ contained

syn match fishToken /\%(\k\|(\)\+/ contains=fishEscape,fishVariable,fishString,fishSubcommand contained

syn region fishSubcommand matchgroup=fishDelimiter start=/(/ matchgroup=fishDelimiter end=/)/ contains=@fishCommandline contained

syn match fishRedirection /\d*\%(<\|>\|>>\)\s*&\?\k\+/ contained

syn match fishArgument	/\%(\k\|(\)\+/	contains=fishComment,fishRedirection,fishToken	nextgroup=@fishLine skipwhite
syn match fishLineCont	/\\$/																														nextgroup=@fishLine skipwhite skipnl
syn cluster fishLine contains=fishLineCont,fishArgument

syn match fishCommandError /(/ contained
syn match fishCommand		/\%(\k\|(\)\+/	contains=fishEscape,fishVariable,fishString,fishCommandError	nextgroup=@fishLine skipwhite

syn keyword fishLogic function begin end		nextgroup=@fishLine skipwhite
syn keyword fishConditional if else switch	nextgroup=@fishLine skipwhite
syn keyword fishRepeat for in while					nextgroup=@fishLine skipwhite
syn keyword fishLabel case									nextgroup=@fishLine skipwhite

syn match fishDelimiter /[;|&]/
syn match fishComment /\<#.*/

syn cluster fishKeyword			contains=fishLogic,fishConditional,fishRepeat,fishLabel
syn cluster fishCommandline contains=@fishKeyword,fishComment,fishDelimiter,fishCommand,fishLineCont,fishArgument


hi def link fishString		String
hi def link fishVariable	Identifier
hi def link fishStringEscapeSingle	fishEscape
hi def link fishStringEscapeDouble	fishEscape
hi def link fishEscape		Special
hi def link fishRedirection	Operator
hi def link fishDelimiter	Delimiter
hi def link fishLineCont	Delimiter
hi def link fishComment		Comment

hi def link fishCommand		Statement
hi def link fishLogic     Keyword
hi def link fishConditional	Keyword
hi def link fishRepeat		Keyword
hi def link fishLabel			Keyword

hi def link fishCommandError	Error

" vim: ts=2
