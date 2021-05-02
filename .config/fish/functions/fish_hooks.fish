set -gx __LAST_CATCH

function fish_hooks
	fish_unhook

	set -l catched __CATCHED(string escape --style=var $PWD)
	if set -q $catched
		return
	end

	set -gx $catched

	if test -e $PWD/.fish_hooks
		source $PWD/.fish_hooks
	end

	if test -d $PWD/.fish_hooks.d
		for hook in (find $PWD/.fish_hooks.d/ -type f -mindepth 1 -maxdepth 1)
			source $hook
		end
	end

	set __LAST_CATCH $PWD
end

function fish_unhook
	test -z $__LAST_CATCH
	and return 1

	test $__LAST_CATCH = $PWD
	and return 1

	if test -e $__LAST_CATCH/.fish_unhook
		source $__LAST_CATCH/.fish_unhook
		set found_hook
	end

	if test -d $__LAST_CATCH/.fish_unhook.d
		for hook in (find $__LAST_CATCH/.fish_unhook.d/ -type f -mindepth 1 -maxdepth 1)
			source $hook
		end
		set found_hook
	end

	if set -q found_hook
		set -l catched __CATCHED(string escape --style=var $__LAST_CATCH)
		if set -q $catched
			set -e $catched
		end

		set __LAST_CATCH ''
	end
end
