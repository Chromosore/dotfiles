function atexit
	printf "\
	function fish_logout_%s --on-process %%self
		$argv
	end" (uuidgen) | source
end
