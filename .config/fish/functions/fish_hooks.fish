function fish_hooks
	fish_unhook

	set -l catched __CATCHED(string escape --style=var $PWD)
	if set -q $catched
		return
	end

	set -gx $catched
	set -gx __LAST_CATCH $PWD

	if test -e $PWD/.hook.fish
		source $PWD/.hook.fish
	end

	if test -d $PWD/.hook.fish.d
		for hook in $PWD/.hook.fish.d/*.fish
			source $hook
		end
	end
end

function fish_unhook
	set -l catched __CATCHED(string escape --style=var $__LAST_CATCH)

	set -q __LAST_CATCH
	and set -q $catched
	or return 1

	test $__LAST_CATCH = $PWD
	and return 1

	if test -e $__LAST_CATCH/.unhook.fish || test -d $__LAST_CATCH/.unhook.fish.d
		set -q $catched
		and set -g -e $catched
	end

	if test -e $__LAST_CATCH/.unhook.fish
		source $__LAST_CATCH/.unhook.fish
	end

	if test -d $__LAST_CATCH/.unhook.fish.d
		for hook in $__LAST_CATCH/.unhook.fish.d/*.fish
			source $hook
		end
	end
end
