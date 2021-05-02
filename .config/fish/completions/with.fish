function __raphi_complete_with --description 'Complete using all available commands'
	set cmds (commandline -poc)
	set command (commandline -p)
	set -e cmds[1]

	if test (count $cmds) -eq 0
		# Complete handler
		functions -n | grep '^with_handler_' | string replace 'with_handler_' ''
		return
	end

	complete -C -- (string replace -r '^with ' '' -- $command)
end

complete -c with -xa '(__raphi_complete_with)'
