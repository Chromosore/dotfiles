function fallback_var
	if functions -q $argv
		$argv
	else
		printf "$$argv"
	end
end


function fish_prompt
	set -l last_pipestatus $pipestatus
	set -l normal (set_color normal)

	set -q fish_color_status_brackets
		and set -l status_brackets_color $fish_color_status_brackets
		or set -l status_brackets_color $fish_color_status

	set -l prompt_status (__fish_print_pipestatus \
		$prompt_status_chars \
		(set_color $status_brackets_color) \
		(set_color $fish_color_status) \
		$last_pipestatus)

	set -l prefix (fallback_var prompt_prefix) $normal
	set -l postfix (fallback_var prompt_postfix) $normal

	set -l sep1 (set_color $fish_color_sep1) $prompt_sep1 $normal
	set -l sep2 (set_color $fish_color_sep2) $prompt_sep2 $normal

	set -l user (set_color $fish_color_user) $USER $normal
	set -l host (set_color $fish_color_host) (prompt_hostname) $normal
	set -l pwd (set_color $fish_color_cwd) (basename (prompt_pwd)) $normal

	set -l body $prompt_status $user $sep1 $host $sep2 $pwd

	echo -sn $prefix $body $postfix
end
