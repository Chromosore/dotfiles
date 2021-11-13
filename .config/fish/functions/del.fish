set -q __del_interactive_recursive_option
or begin
	switch (uname)
		case 'Linux'
			set -g __del_interactive_recursive_option '-I'
		case '*'
			set -g __del_interactive_recursive_option '-i'
	end
end

function del
	set options 'i/interactive' 'v/verbose' 'f/force'
	argparse --exclusive i,f $options -- $argv
	or return $status

	set -l directory 0

	for file in $argv
		if test -d $file
			set directory 1
			break
		end
	end

	if test "$directory" = 1
		set -a flags '--recursive'

		set -q _flag_interactive
		and set -a flags $__del_interactive_recursive_option
	else
		set -q _flag_interactive
		and set -a flags '-i'
	end

	set -q _flag_verbose
	and set -a flags '-v'

	set -q _flag_force
	and set -a flags '-f'

	command rm $flags $argv
end
