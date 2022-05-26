function fish_greeting
	set -q fish_greeting
	and echo $fish_greeting

	if test -n "$fish_private_mode"
		printf 'You are in %sprivate%s mode.\n' \
		   (set_color -o red) \
		   (set_color normal)
	end
end
