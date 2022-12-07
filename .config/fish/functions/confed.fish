function confed
	set options 'a/create' 'i/interactive' 's/search' '1/pick-first'
	argparse --max-args=1 --exclusive i,1 $options -- $argv
	or return $status

	set -q EDITOR && command -q $EDITOR
	or command -q vi && set -l EDITOR vi
	or set -l EDITOR nano

	if test "$CONFED_PICK_FIRST" != 1 && not set -q _flag_pick_first
		set _flag_interactive ''
	end

	if test (count $argv) -eq 0
		if set -q _flag_search
			echo $__fish_config_dir/config.fish
		else
			$EDITOR $__fish_config_dir/config.fish
		end
		return 0
	end

	set -l file $argv[1]


	for file_path in $CONFED_SPECIAL
		if test (basename $file_path) = $file
			set -p special_path (dirname $file_path)
		end
	end

	for conf_dir in $special_path $CONFED_PATH
		if test -e $conf_dir/$file
			set -a existing $conf_dir
		else
			set -a missing $conf_dir
		end
	end

	if not set -q _flag_create
		set dirs $existing
		set err_msg "No such config file found\nTry `confed -a %s`\n" "$argv"
	else
		set dirs $missing
		set err_msg "All possible config files exist.\nTry `confed %s`\n" "$file"
	end

	if test (count $dirs) -eq 0
		printf $err_msg >&2
		return 1
	end

	set dir $dirs[1]

	if set -q _flag_interactive && test (count $dirs) -gt 1
		set realhome ~
		set i 1

		echo "Choose a folder:" >&2
		for choice in $dirs
			echo [$i]: (string replace -r '^'"$realhome" '~' $choice) >&2
			set i (math $i + 1)
		end

		if not set choice (read -p 'echo "> "')
			echo (_ "Abort")
			return 1
		end
		if test $choice -lt 1 || test $choice -gt (count $dirs)
			echo "You must choose a number between 1 and "(count $dirs) >&2
			return 1
		end

		set dir $dirs[$choice]
	end

	if set -q _flag_search
		echo $dir/$file
	else
		$EDITOR $dir/$file
	end
end
