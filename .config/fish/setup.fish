#!/usr/bin/fish
# setup.fish
# ----------
#
# A file to set universal variables,
# abbreviations, vi like bindings
# and more for the first use

function v
	echo $argv
	set_color normal
	$argv
end

set platform (uname)

### UNIVERSAL VARIABLES
# Prompt config
function prompt_chars
	v set -U prompt_prefix ''
	v set -U prompt_sep1 '@'
	v set -U prompt_sep2 ' '

	v set -U prompt_postfix '-+ '
	v set -U prompt_postfix_level '-'
	v set -U prompt_postfix_level_zero 1

	v set -U prompt_status_chars '(' ') ' '|'
end

# Git prompt config
function git_prompt
	v set -U __fish_git_prompt_showcolorhints
	v set -U __fish_git_prompt_showdirtystate

	# Hack so it shows the number of commits ahead and behind but spaced
	v set -U __fish_git_prompt_showupstream informative
	v set -U __fish_git_prompt_char_upstream_ahead ' +'
	v set -U __fish_git_prompt_char_upstream_behind ' -'
	v set -U __fish_git_prompt_char_upstream_diverged ' +-'
end

# Prompt colours
function prompt_colours
	v set -U fish_color_user	-o yellow
	v set -U fish_color_sep1	-d green
	v set -U fish_color_host	-o blue
	v set -U fish_color_host_remote yellow
	v set -U fish_color_cwd	-u brmagenta
	v set -U fish_color_status -o red
	v set -U fish_color_status_brackets normal
end

# Vi modes cursor
function vi_mode
	v fish_vi_key_bindings

	v set -U fish_cursor_default		block		blink
	v set -U fish_cursor_insert		line		blink
	v set -U fish_cursor_visual		block
	v set -U fish_cursor_replace_one	underscore
	v set -U fish_cursor_replace		underscore	blink
end

# Colours
function fish_colours
	v set -U fish_color_normal normal

	v set -U fish_color_command '-o'  'magenta'
	v set -U fish_color_param blue

	v set -U fish_color_valid_path -u
	v set -U fish_color_quote yellow

	v set -U fish_color_escape cyan
	v set -U fish_color_redirection cyan
	v set -U fish_color_operator cyan

	v set -U fish_color_autosuggestion '555'  'brblack'
	v set -U fish_color_comment '-i'  'brblack'

	v set -U fish_color_cancel -r
	v set -U fish_color_end red
	v set -U fish_color_error red

	#set -U fish_color_cwd_root red
	v set -U fish_color_history_current --bold
	v set -U fish_color_match --background=brblue
	v set -U fish_color_search_match 'bryellow'  '--background=brblack'
	v set -U fish_color_selection 'white'  '--bold'  '--background=brblack'
end


### ABBREVIATIONS
function abbreviations
	v abbr -a -U -- ports 'netstat -tuplan'
	v abbr -a -U -- pym 'python3 -m'
	v abbr -a -U -- pydoc 'python3 -m pydoc'

	if command -q doas
		v abbr -a -U -- sudo doas
	end

	if test (basename "$EDITOR") = nvim
		v abbr -a -U -- vi nvim
		v abbr -a -U -- vim nvim
	else
		v abbr -a -U -- vi vim
	end

	v abbr -a -U -- nd nextd
	v abbr -a -U -- pd prevd

	# Remove from history
	v abbr -a -U -- shutdown ' shutdown'
	v abbr -a -U -- clear ' clear'
	v abbr -a -U -- reboot ' reboot'
	v abbr -a -U -- history ' history'

	# Verbose & confirm
	v abbr -a -U -- cp 'cp -iv'
	v abbr -a -U -- ln 'ln -v'
	v abbr -a -U -- mv 'mv -iv'
	v abbr -a -U -- mkdir 'mkdir -v'
	v abbr -a -U -- diff 'diff -s'

	v abbr -a -U -- gzip 'gzip -v'
	v abbr -a -U -- gunzip 'gunzip -vf'
	v abbr -a -U -- cpio 'cpio -v'
	v abbr -a -U -- pax 'pax -v'

	v abbr -a -U -- rm 'del -v'
	v abbr -a -U -- rmdir 'rmdir -v'

	v abbr -a -U -- dotadd  'dotadd -v'
	v abbr -a -U -- dotlink 'dotlink -v'

	# ls (exa) aliases
	v abbr -a -U -- ls   'ls -F'
	v abbr -a -U -- la   'ls -Fa'
	v abbr -a -U -- ld   'ls -FD'
	v abbr -a -U -- ll   'ls -GlhF'
	v abbr -a -U -- lll  'ls -lhF'
	v abbr -a -U -- tree 'ls -T'
end

set -- options \
	--prompt-chars --prompt-colours --vi-mode --fish-colours \
	--abbreviations --git-prompt


function error
	set option $argv[1]
	printf 'invalid option: %s\n' $option
	exit 1
end

function usage
	printf 'usage: %s [ options... ]

%sOptions:%s\n' \
	   (status current-filename) \
	   (set_color -o) (set_color normal) \

	string join -- \n --all $options
end


if test (count $argv) -eq 0
	usage
else if test (count $argv) -eq 1
	switch $argv[1]
		case --all
			set -- argv $options
		case --help
			usage
			exit 0
	end
end

for option in $argv
	if set opt_name (string replace -r -- '^--' '' $option)
		set func_name (string replace '-' '_' $opt_name)
		if not contains -- $option $options
			error $option
		end
	else
		error $option
	end
end

for option in $argv
	set func_name (string replace -r -- '^--' '' $option | string replace '-' '_')
	$func_name
end
