set wrappers sudo and or time if

function expand-token
	argparse 'f/function=+' -- $argv

	set -l tokens (commandline -pc -o) (commandline -tc)

	while contains -- $tokens[1] $wrappers
		set -e tokens[1]
	end

	set -l position (count $tokens)
	set -l token $tokens[-1]


	set -l abbr (printf '_fish_abbr_%s' \
		(string escape --style=var -- $token))

	if test $position -eq 1 && set -q $abbr
		commandline -t $$abbr
	end


	set -l cmd_abbr (printf '_cmd_abbr_%s_%d_%s' \
		(string escape --style=var -- $tokens[1]) \
		(string escape --style=var -- $position) \
		(string escape --style=var -- $token))


	if set -q $cmd_abbr
		commandline -t $$cmd_abbr
	end


	test -n "$argv"
	and commandline -i "$argv"

	set -q _flag_function
	and commandline -f $_flag_function

	commandline -f repaint
end
