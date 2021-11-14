complete -c confed -x

complete -c confed -s a -l create      -d 'Create a new config file'
complete -c confed -s i -l interactive -d 'Prompt when multiple choices are available'
complete -c confed -s 1 -l pick-first  -d 'Always pick the first choice when multiple choices are available'
complete -c confed -s s -l search      -d 'Only print the path of the configuration file'

function __confed_list_config_files
	set realhome ~
	set token (commandline -t)

	for dir in $CONFED_PATH
		set shortdir (string replace -r '^'"$realhome" '~' $dir)

		__fish_complete_path $dir/$token $shortdir |
			string replace -r "^$dir/" ''
	end

	for file in $CONFED_SPECIAL
		printf '%s\t%s\n' (basename $file) \
			(dirname $file | string replace -r '^'"$realhome" '~')
	end
end

complete -c confed \
	-n '__fish_use_subcommand && not __fish_seen_argument -s a -l create' \
	-a '(__confed_list_config_files)'
