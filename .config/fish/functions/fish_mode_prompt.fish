function fish_mode_prompt --description 'Afficher le mode actuel'
	# Do nothing if not in vi mode
	if test "$fish_key_bindings" = "fish_default_key_bindings"
		return 0
	end

	set_color -o

	switch $fish_bind_mode
		case default
			set_color red
			printf N
		case insert
			set_color green
			printf I
		case replace_one
			set_color brred
			printf r
		case replace
			set_color brred
			printf R
		case visual
			set_color magenta
			printf V
	end

	set_color normal
	printf ' '
end
