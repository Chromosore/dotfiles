function dotadd
	argparse 'd/dot-home=' 'm/no-link' -- $argv
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
		end

		set path (string replace -r '^'$realhome/ '' (realpath $file))

		mv ~/$path $dothome/$path

		not set -q _flag_no_link
			and dotlink --dot-home $dothome $path
	end
end
