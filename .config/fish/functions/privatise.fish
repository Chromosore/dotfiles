function privatise
	if test -z "$fish_private_mode"
		exec fish -P -C 'privatise'
	end

	function nvim
		command nvim -c 'runtime! macros/private.vim' $argv
	end
end
