function notify
	$argv
	notify-send \
		-i ([ $status = 0 ] && echo terminal || echo error) \
		(tty | string replace "/dev/" "") \
		"`$argv` ended"
end
