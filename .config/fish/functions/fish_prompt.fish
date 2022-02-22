# Shell Integration ##########

if begin
		test -n "$KITTY_SHELL_INTEGRATION"
		and not contains -- "no-cursor" (string split " " -- "$KITTY_SHELL_INTEGRATION")
	end; or begin
		set -q ITERM_PROFILE
		and not functions -q -- iterm2_status
		and test "$ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX""$TERM" != screen
	end

	set -l __osc '\e]133;%s\e\\\\'
	set __prompt_mark_start    (printf $__osc A)
	set __prompt_mark_end      (printf $__osc B)
	set __prompt_mark_preexec  (printf $__osc C)
	set __prompt_mark_postexec (printf $__osc 'D;%d')
	set __prompt_mark_cancel   (printf $__osc D)

	function __prompt_shell_integration_preexec --on-event fish_preexec
		echo -sn $__prompt_mark_preexec
	end

	function __prompt_shell_integration_postexec --on-event fish_postexec
		printf $__prompt_mark_postexec $status
	end

	function __prompt_shell_integration_cancel --on-event fish_cancel
		echo -sn $__prompt_mark_cancel
	end
end

##############################


function __prompt_fallback_var
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

	set -l prefix (__prompt_fallback_var prompt_prefix) $normal
	set -l postfix (__prompt_fallback_var prompt_postfix) $normal

	set -l sep1 (set_color $fish_color_sep1) $prompt_sep1 $normal
	set -l sep2 (set_color $fish_color_sep2) $prompt_sep2 $normal

	set -l user (set_color $fish_color_user) $USER $normal
	set -l host (set_color $fish_color_host) (prompt_hostname) $normal
	set -l pwd (set_color $fish_color_cwd) (basename (prompt_pwd)) $normal

	set -l body $prompt_status $user $sep1 $host $sep2 $pwd

	echo -sn $__prompt_mark_start
	echo -sn $prefix $body $postfix
	echo -sn $__prompt_mark_end
end
