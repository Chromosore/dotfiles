# setup.fish
# ----------
#
# A file to set universal variables,
# abbrevations, vi like bindings
# and more for the first use

fish_vi_key_bindings

### UNIVERSAL VARIABLES
# Prompt config
set -U prompt_prefix ''
set -U prompt_sep1 '@'
set -U prompt_sep2 ' '
set -U prompt_postfix ' '(set_color -o)'>_ '
set -U prompt_status_chars '(' ') ' '|'

# Prompt colours
set -U fish_color_user	-o yellow
set -U fish_color_sep1	-d green
set -U fish_color_host	-o blue
set -U fish_color_host_remote yellow
set -U fish_color_cwd	-u brmagenta
set -U fish_color_status -o red
set -U fish_color_status_brackets normal

# Vi modes cursor
set -U fish_cursor_default		block		blink
set -U fish_cursor_insert		line		blink
set -U fish_cursor_visual		block
set -U fish_cursor_replace_one	underscore
set -U fish_cursor_replace		underscore	blink

# Colours
set -U fish_color_normal normal

set -U fish_color_command '-o'  'magenta'
set -U fish_color_param blue

set -U fish_color_valid_path -u
set -U fish_color_quote yellow

set -U fish_color_escape cyan
set -U fish_color_redirection cyan
set -U fish_color_operator cyan

set -U fish_color_autosuggestion '555'  'brblack'
set -U fish_color_comment '-i'  'brblack'

set -U fish_color_cancel -r
set -U fish_color_end red
set -U fish_color_error red

#set -U fish_color_cwd_root red
set -U fish_color_history_current --bold
set -U fish_color_match --background=brblue
set -U fish_color_search_match 'bryellow'  '--background=brblack'
set -U fish_color_selection 'white'  '--bold'  '--background=brblack'


### ABBREVATIONS
abbr -a -U -- ports 'netstat -tuplan'
abbr -a -U -- pym 'python3 -m'

abbr -a -U -- sudo doas
abbr -a -U -- vi vim
abbr -a -U -- nd nextd
abbr -a -U -- pd prevd

# Remove from history
abbr -a -U -- shutdown ' shutdown'
abbr -a -U -- clear ' clear'
abbr -a -U -- reboot ' reboot'

# Verbose & confirm
abbr -a -U -- cp 'cp -iv'
abbr -a -U -- ln 'ln -v'
abbr -a -U -- mv 'mv -iv'
abbr -a -U -- rm 'rm -Iv'
abbr -a -U -- mkdir 'mkdir -v'
abbr -a -U -- rmdir 'rmdir -v'

# ls (exa) aliases
abbr -a -U -- ls 'exa -F'
abbr -a -U -- la 'exa -Fa'
abbr -a -U -- ld 'exa -FD'
abbr -a -U -- ll 'exa -GlhF'
abbr -a -U -- lll 'exa -lhF'
abbr -a -U -- tree 'exa -T'
