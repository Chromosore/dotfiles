function clock
	set -l bcol (set_color $fish_color_host)
	set -l hcol (set_color $fish_color_cwd)
	set -l normal (set_color normal)

	show "\x1b[s"
	show "\x1b[1;"(math $COLUMNS - 6)"H"

	set -l time (date +%H:%M)

	echo -sn $bcol [ $normal \
		$hcol $time $normal \
		$bcol ] $normal > /dev/tty

	show "\x1b[u"
end
