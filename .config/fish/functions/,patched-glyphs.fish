function ,patched-glyphs
	source ~/Documents/fonts/i/fish/i_all.fish
	for varname in (set -n)
		if string match -rq '^i_' $varname
			set -g "$varname" "$$varname"
		end
	end
end
