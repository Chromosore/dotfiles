function prompt_ellapsed_time
	set normal (set_color normal)
	set b_magenta (set_color -o magenta)

	if set -q -g CMD_DURATION
		if test $CMD_DURATION -ge 3000
			set seconds (math -s0 $CMD_DURATION / 1000)

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
