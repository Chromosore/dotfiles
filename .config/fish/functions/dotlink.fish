function dotlink
	argparse 'd/dot-home=' 'v/verbose' -- $argv
	or return $status

	set -q _flag_dot_home
		and set dothome $_flag_dot_home
		or  set dothome ~/dotfiles

	set realhome ~

	for file in $argv
		set path (string replace -r '^'$dothome/ '' $file)

		if not test -e $dothome/$path
			printf (_ "%ls: '%ls' is not a file\n") \
			   (status current-function) \
			   (string replace -r '^'$realhome '' $dothome/$path)
		end


		set -q _flag_verbose
			and set flags -v

		ln $flags -s $dothome/$path ~/$path
	end
end
