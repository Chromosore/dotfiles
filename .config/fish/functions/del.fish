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


	# Clear the sudo cache to make sure that the password is asked
	sudo -k

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

			# If the rm command failed...
			or begin
				if not test -w (dirname $file)
					# Try escalating privileges to delete the file
					printf (_ 'Retrying as root...\n')
					sudo rm $options $file
				else if not test -d $file || set -q recursive
					set prompt (_ 'Retry as root?')
					read answer -P (printf '%s %s ' $prompt '[y/N]')

					test (string lower "$answer") = y
					and printf (_ 'Retrying as root...\n')
					and sudo rm $options $file
				end
			end
		else
			printf (_ 'Skipping "%s"...\n') $escaped_file
		end
	end
end
