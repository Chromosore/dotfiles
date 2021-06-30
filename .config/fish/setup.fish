# setup.fish
# ----------
#
# A file to set universal variables,
# abbreviations, vi like bindings
# and more for the first use

fish_vi_key_bindings

function v
	echo $argv
	set_color normal
	$argv
end

### UNIVERSAL VARIABLES
# Prompt config
function prompt_chars
	v set -U prompt_prefix ''
	v set -U prompt_sep1 '@'
	v set -U prompt_sep2 ' '
	v set -U prompt_postfix ' '(set_color -o)'>_ '
	v set -U prompt_status_chars '(' ') ' '|'
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
function mode_cursor
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

	v abbr -a -U -- sudo doas
	v abbr -a -U -- vi vim
	v abbr -a -U -- nd nextd
	v abbr -a -U -- pd prevd

	# Remove from history
	v abbr -a -U -- shutdown ' shutdown'
	v abbr -a -U -- clear ' clear'
	v abbr -a -U -- reboot ' reboot'

	# Verbose & confirm
	v abbr -a -U -- cp 'cp -iv'
	v abbr -a -U -- ln 'ln -v'
	v abbr -a -U -- mv 'mv -iv'
	v abbr -a -U -- rm 'rm -Iv'
	v abbr -a -U -- mkdir 'mkdir -v'
	v abbr -a -U -- rmdir 'rmdir -v'

	# ls (exa) aliases
	v abbr -a -U -- ls 'exa -F'
	v abbr -a -U -- la 'exa -Fa'
	v abbr -a -U -- ld 'exa -FD'
	v abbr -a -U -- ll 'exa -GlhF'
	v abbr -a -U -- lll 'exa -lhF'
	v abbr -a -U -- tree 'exa -T'
end

set -- options --prompt-chars --prompt-colours \
	--mode-cursor --fish-colours --abbreviations


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
		if contains -- $option $options
			$func_name
		else
			error $option
		end
	else
		error $option
	end
end
