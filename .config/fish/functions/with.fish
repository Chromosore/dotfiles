if set -q WITH_HANDLERS_LOADED
	exit 0
end

set -g WITH_HANDLERS_LOADED

for handler in (dirname (status current-filename))/with_handlers/*
	set -l filename (basename $handler .fish)

	functions -c $filename _old_$filename 2>/dev/null
	source $handler

	functions -c $filename with_handler_$filename
	functions -e $filename
	functions -c _old_$filename $filename 2>/dev/null
end

function with
	set -l cmd $argv[1]
	set -e argv[1]

	set handler "with_handler_$cmd"

	if not type -q $handler
		echo "No handlers found for this command"
		return 1
	end

	atexit $handler $argv
	$cmd $argv
end
