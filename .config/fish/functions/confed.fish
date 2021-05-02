function confed
	argparse 'a/create' 'i/interactive' 's/search' -- $argv

	if test (count $argv) -eq 0
		if set -q _flag_search
			echo $CONF/fish/config.fish
		else
			sensible-editor $CONF/fish/config.fish
		end
		return 0
	end

	set -l file $argv[1]

	set -l existing
	set -l missing

	set -l dirs
	set -l dir

	for conf_dir in $CONFED_PATH
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
		set -l found_special false

		for file_path in $CONFED_SPECIAL
			if test (basename $file_path) = $file
				set dir (dirname $file_path)
				set found_special true
				break
			end
		end

		if not $found_special
			printf $err_msg
			return 1
		end
	else
		set dir $dirs[1]
	end

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
		sensible-editor $dir/$file
	end
end
