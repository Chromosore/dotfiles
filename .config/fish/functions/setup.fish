set -q XDG_DATA_HOME
or set -l XDG_DATA_HOME ~/.local/share

set -l SETUP_MARKER $XDG_DATA_HOME/fish/setup_done

function setup -V SETUP_MARKER
	if test -z "$argv" || contains -- --help $argv
		set help true
	end

	if test -e "$SETUP_MARKER" && not set -q help
		read -p "printf 'Setup already done. Do it again ? [y/N] '" answer

		if test "$answer" != 'y' -a "$answser" != 'Y'
			echo 'Abort.'
			return 1
		end
	end

	fish $__fish_config_dir/setup.fish $argv
	set setup_status $status

	if test $setup_status != 0
		return $setup_status
	else if set -q help
		return $setup_status
	else
		touch $SETUP_MARKER
	end
end
