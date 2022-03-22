function clock
	set -l bcol (set_color $fish_color_clock_brackets)
	set -l hcol (set_color $fish_color_clock)
	set -l normal (set_color normal)

	set -l time (date +%H:%M)

	echo -sn $bcol [ $normal \
		$hcol $time $normal \
		$bcol ] $normal
end
