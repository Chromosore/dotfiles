function dotadd
	argparse 'd/dot-home=' 'm/no-link' 'v/verbose' -- $argv
	or return $status

	set -q _flag_dot_home
		and set dothome $_flag_dot_home
		or  set dothome ~/dotfiles

	set realhome ~

	for file in $argv
		if not test -e $file
			printf (_ "%ls: '%ls' is not a file\n") \
			   (status current-function) \
			   (string replace -r '^'$realhome '' $file)
			continue
		end

		set path (string replace -r '^'$realhome/ '' (realpath $file))

		set -q _flag_verbose
			and set flags --verbose

		mv $flags ~/$path $dothome/$path

		not set -q _flag_no_link
			and dotlink $flags --dot-home $dothome $path
	end
end
