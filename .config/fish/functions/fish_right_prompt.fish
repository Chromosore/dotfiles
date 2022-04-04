function __right_prompt_refresh_vcs_status
	set -l tmpdir /tmp
	set -q TMPDIR
	and set -l tmpdir $TMPDIR

	set tmpfile (mktemp $tmpdir/.fish_right_prompt_async.XXXXXXXXXX)

	while true
		set funcname __right_prompt_async_(random)
		if not functions $funcname >/dev/null 2>/dev/null
			break
		end
	end

	fish -c 'fish_vcs_prompt' >$tmpfile &
	set pid (jobs --last --pid)

	function $funcname --on-job-exit $pid -V tmpfile -V funcname
		set -g __right_prompt_vcs_status (cat $tmpfile)
		command rm $tmpfile
		commandline -f repaint
		functions -e $funcname
	end

	echo $pid
end


function fish_right_prompt
	prompt_ellapsed_time

	if set -g -q __right_prompt_vcs_status
		echo -sn $__right_prompt_vcs_status
		set -g __right_prompt_vcs_status_shadow $__right_prompt_vcs_status
		set -g -e __right_prompt_vcs_status
		set -g -e __right_prompt_job_pid
	else
		if not set -q -g __right_prompt_job_pid
			set -g __right_prompt_job_pid (__right_prompt_refresh_vcs_status)
		end

		if __fish_is_git_repository
			echo -sn $__right_prompt_vcs_status_shadow
		end
	end

	printf ' '
	clock
end
