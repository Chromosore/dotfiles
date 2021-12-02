function record_timestamp --on-event fish_preexec
	set -e -g _prompt_ellapsed_time
	set -g _prompt_last_timestamp (date +%s)
end

function prompt_ellapsed_time
	set now (date +%s)

	set normal (set_color normal)
	set b_magenta (set_color -o magenta)

	if set -q -g _prompt_last_timestamp
		set -g _prompt_ellapsed_time (math $now - $_prompt_last_timestamp)
		set -e -g _prompt_last_timestamp
	end


	if set -q -g _prompt_ellapsed_time
		if test $_prompt_ellapsed_time -ge 3
			set seconds $_prompt_ellapsed_time

			if test $seconds -ge 60
				set minutes (math -s0 $seconds / 60)
				set seconds (math     $seconds % 60)

				if test $minutes -ge 60
					set hours   (math -s0 $minutes / 60)
					set minutes (math     $minutes % 60)
				end
			end

			# clever use of cartesian product in fish to show the number of
			# minutes and hours only when they are defined
			echo -sn ' ' $b_magenta $hours'h ' $minutes'm ' $seconds's' $normal
		end
	end
end
