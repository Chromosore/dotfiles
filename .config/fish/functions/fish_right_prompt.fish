function __right_prompt_repaint --on-variable __right_prompt_vcs_status
	# Don't trigger when the result is reset
	set -q __right_prompt_vcs_status
	or return 1

	# Cache the result
	set -g __right_prompt_vcs_status_shadow $__right_prompt_vcs_status
	# Repaint
	commandline -f repaint
	# Mark the prompt as *cached*
	# set -g -e __right_prompt_vcs_status
	set -g -e __right_prompt_job_pid
end


function fish_right_prompt
	prompt_ellapsed_time

	if set -g -q __right_prompt_vcs_status
		echo -sn $__right_prompt_vcs_status
		set -e __right_prompt_vcs_status
	else
		if __fish_is_git_repository
			echo -sn $__right_prompt_vcs_status_shadow
		end

		if not set -q -g __right_prompt_job_pid
			set -g __right_prompt_job_pid \
			   (__kmz_async_compute __right_prompt_vcs_status 'fish_vcs_prompt')
		end
	end

	printf ' '
	clock
end
