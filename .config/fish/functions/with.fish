if set -q WITH_HANDLERS_LOADED
	exit 0
end

set -g WITH_HANDLERS_LOADED

set -l with_hooks 'before' 'after'

for handler in (dirname (status current-filename))/with_handlers/*
	set -l filename (basename $handler .fish)
	for hook in $with_hooks
		functions -c {$filename}_$hook _old_{$filename}_$hook 2>/dev/null
	end

	source $handler

	for hook in $with_hooks
		functions -c {$filename}_$hook with_handler_{$filename}_$hook 2>/dev/null
		functions -e {$filename}_$hook 2>/dev/null
		functions -c _old_{$filename}_$hook {$filename}_$hook 2>/dev/null
	end
end

function with
	set -l cmd $argv[1]
	set -e argv[1]

	set handler_before "with_handler_{$cmd}_before"
	set handler_after "with_handler_{$cmd}_after"

	if not type -q $handler_before && not type -q $handler_after
		echo "No handlers found for this command"
		return 1
	end

	if type -q $handler_after
		atexit $handler_after $argv
	end

	if type -q $handler_before
		$handler_before $argv
	else
		$cmd $argv
	end
end
