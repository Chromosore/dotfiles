function show
	printf -- $argv > /dev/tty
end

function fish_mode_prompt --description 'Afficher le mode actuel'
	show "\x1b[?25l"
	clock

	# Do nothing if not in vi mode
	if test "$fish_key_bindings" = "fish_default_key_bindings"
		return 0
	end

	type -q 'getCurPos'
	and set -l cursorPos 'getCurPos'
	or set -l cursorPos 'printf' '0;0'

	set -l curpos ($cursorPos | string split ";")
	test "$curpos" = ""
	and set curpos[1] 0

	test $curpos[1] -eq $LINES
	and show "\x1b[S"

	show "\x1b[s"
	show "\x1b[$LINES;0H"

	show (set_color -o yellow)
	show "-- "

	switch $fish_bind_mode
		case default
			show NORMAL
		case insert
			show INSERT
		case replace_one
			show REPLACE
		case replace
			show REPLACE
		case visual
			show VISUAL
		end

	show " -- "

	show "\x1b[u"

	test $curpos[1] -eq $LINES
	and show "\x1b[A"

	show "\x1b[?25h"
end

function fish_clear_mode_prompt --on-event fish_preexec
	#type -q 'getCurPos'
	#and set -l cursorPos 'getCurPos'
	#or set -l cursorPos 'printf' '0;0'

	#set -l curpos ($cursorPos | string split ";")

	#test $curpos[1] -ne $LINES
	#and return

	show "\x1b[s"

	show "\x1b[$LINES;0H"
	show "\x1b[K"

	show "\x1b[u"
end

if set -q VIM
	functions -e fish_mode_prompt
end
