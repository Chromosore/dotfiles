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
	fzf_key_bindings

	bind -M insert ! bind_bang
	bind -M insert '$' bind_dollar

	bind -M insert fd 'set fish_bind_mode default;
		commandline -f backward-char repaint-mode'
	bind -M visual fd 'set fish_bind_mode default;
		commandline -f end-selection repaint-mode'
	bind -M replace fd 'set fish_bind_mode default;
		commandline -f cancel backward-char repaint-mode'
	bind -M replace_one fd 'set fish_bind_mode default;
		commandline -f cancel repaint-mode'
end
