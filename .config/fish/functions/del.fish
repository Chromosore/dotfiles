function del
	## $argv sanitising
	for arg in $argv
		switch $arg
			case '-'
				set -a files $arg
			case '-*'
				if test (string sub -s2 -l1 -- $arg) = "-"
					set -a _options $arg
				else
					set -a _options -(string sub -s2 -- $arg | string split -- '')
				end
			case '*'
				set -a files $arg
		end
	end

	## Option parsing
	# Catch -i and -I as we are replacing them
	# But pass -r through
	for option in $_options
		switch $option
			case '-r'
				set recursive  $option
				set -a options $option
			case '-i'
				continue
			case '-I'
				continue
			case '*'
				set -a options $option
		end
	end

	if not contains -- '-f' $options
		set -p options '-f'
	end


	for file in $files
		set escaped_file (string replace -a '"' '\"' $file)

		if test -d $file && set -q recursive
			set prompt (printf '%s "%s"?' (_ 'Remove recursively') $escaped_file)
		else if stat &>/dev/null $file
			set prompt (printf '%s "%s"?' (_ 'Remove') $escaped_file)
		else
			printf (_ '"%s" does not exists\n') $escaped_file
			return 1
		end

		read answer -P (printf '%s %s ' $prompt '[y/N]')

		if test (string lower "$answer") = y
			command rm $options $file
		else
			printf (_ 'Skipping "%s"...\n') $escaped_file
		end
	end
end
