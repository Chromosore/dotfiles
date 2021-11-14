function __dotlink_complete
	argparse --ignore-unknown 'd/dot-home=' -- (commandline -po) 2>/dev/null

	set -q _flag_dot_home && test -n "$_flag_dot_home"
		and set dothome (realpath $_flag_dot_home[-1])
		or  set dothome ~/dotfiles

	set token (commandline -t)
	__fish_complete_path $dothome/$token |
		string replace -r "^$dothome/" ''
end

complete -c dotlink -s d -l dot-home -r -d 'Choose an alternative dotfiles root'

complete -c dotlink -x -a '(__dotlink_complete)'
