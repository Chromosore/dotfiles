if test -n "$fish_private_mode"
	set -g fish_color_user -o
	set -g fish_color_sep1 brblack
	set -g fish_color_host -o
	set -g fish_color_host_remote -o -u
	set -g fish_color_cwd -u
	set -g fish_color_cwd_root -o -u

	set -g fish_color_command -o
	set -g fish_color_param brblack

	set -g fish_color_quote normal
	set -g fish_color_escape -o
	set -g fish_color_variable -o
	set -g fish_color_operator -o
	set -g fish_color_redirection -o
	set -g fish_color_error -i
	set -g fish_color_end -o

	set -g fish_color_match --background=white
	set -g fish_color_search_match --background=brblack

	set -g fish_color_status -o
	set -g fish_color_status_brackets normal

	set -g fish_pager_color_completion normal
	set -g fish_pager_color_description -o
	set -g fish_pager_color_prefix -o -u
	set -g fish_pager_color_progress brwhite --background=brblack

	set colorfile $__fish_config_dir/black-and-white.dircolors
	if test -e $colorfile
		set -l cmd (command -s {g,}dircolors)[1]
		set -gx LS_COLORS ($cmd -c $colorfile | string split ' ')[3]
	end
end
