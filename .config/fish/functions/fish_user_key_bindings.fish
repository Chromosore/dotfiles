function bind-bang
	switch (commandline -t)[-1]
		case "!"
			commandline -t -- $history[1]
			commandline -f repaint
		case "*"
			commandline -i '!'
	end
end

function bind-dollar
	switch (commandline -t)[-1]
		case "!"
			commandline -t ""
			commandline -f history-token-search-backward
		case "*!"
			commandline -f backward-delete-char
			commandline -f history-token-search-backward
		case "*"
			commandline -i '$'
	end
end

function fish_user_key_bindings
	bind -M $insert ! bind-bang
	bind -M $insert '$' bind-dollar

	bind \ep history-token-search-backward
	bind \en history-token-search-forward
end
