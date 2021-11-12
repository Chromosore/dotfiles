complete -c confed -x

complete -c confed -s a -l create      -d 'Create a new config file'
complete -c confed -s i -l interactive -d 'Prompt when multiple choices are available'
complete -c confed -s 1 -l pick-first  -d 'Always pick the first choice when multiple choices are available'
complete -c confed -s s -l search      -d 'Only print the path of the configuration file'

function __confed_list_config_files
	set realhome ~

	for dir in $CONFED_PATH
		set shortdir (string replace -r '^'"$realhome" '~' $dir)

		find $dir/ -mindepth 1 -maxdepth 1 -print0 |
			string split0 |
			string replace -r '^.*/([^/]+)$' '$1'\t"$shortdir"
	end

	for file in $CONFED_SPECIAL
		printf '%s\t%s\n' (basename $file) \
			(dirname $file | string replace -r '^'"$realhome" '~')
	end
end

complete -c confed -n 'not __fish_seen_argument -s a -l create' \
   -a '(__confed_list_config_files)'
