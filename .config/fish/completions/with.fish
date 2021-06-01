function __raphi_complete_with --description 'Complete using all available with handlers'
	set cmds (commandline -poc)
	set command (commandline -p)
	set -e cmds[1]

	if test (count $cmds) -eq 0
		# Complete handler
		complete -C 'with_handler_' | string match -r '(?<=with_handler_)\S+(?=_(?:before|after))'
		return
	end

	complete -C -- (string replace -r '^with ' '' -- $command)
end

complete -c with -xa '(__raphi_complete_with)'
