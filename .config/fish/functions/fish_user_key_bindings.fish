fzf_key_bindings

function bind_bang
	switch (commandline -t)[-1]
		case "!"
			commandline -t -- $history[1]
			commandline -f repaint
		case "*"
			commandline -i '!'
	end
end

function bind_dollar
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
	bind -M insert ! bind_bang
	bind -M insert '$' bind_dollar
	bind -M insert fd 'set fish_bind_mode default'

	## Vim - Semi Hard Mode
	## no arrow key navigation
	#for key in left right up down
	#	bind --preset -k $key :
	#	bind -M insert -k $key "commandline -i $key"
	#end
end
