function confed
	set options 'a/create' 'i/interactive' 's/search' '1/pick-first'
	argparse -x i,1 $options -- $argv
	or return $status

	set -q EDITOR && command -q $EDITOR
	or command -q vi && set -l EDITOR vi
	or set -l EDITOR nano

	set -q XDG_CONFIG_HOME
	and set -l CONF $XDG_CONFIG_HOME
	or set -l CONF $HOME/.config

	if test "$CONFED_PICK_FIRST" != 1 && not set -q _flag_pick_first
		set _flag_interactive ''
	end

	if test (count $argv) -eq 0
		if set -q _flag_search
			echo $CONF/fish/config.fish
		else
			$EDITOR $CONF/fish/config.fish
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
		set err_msg "No such config file found\nTry `confed -a $argv`\n"
	else
		set dirs $missing
		set err_msg "All possible config files exist.\nTry `confed $file`\n"
	end

	if test (count $dirs) -eq 0
		printf $err_msg
		return 1
	end

	set dir $dirs[1]

	if set -q _flag_interactive && test (count $dirs) -gt 1
		set i 1

		echo "Choose a folder:"
		for choice in $dirs
			echo [$i]: $choice
			set i (math $i + 1)
		end

		set choice (read -p 'echo "> "')
		if test $choice -lt 1 || test $choice -gt (count $dirs)
			echo "You must choose a number between 1 and "(count $dirs)
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
