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
	set -l vi (test "$fish_key_bindings" = "fish_vi_key_bindings" && echo true || echo false)

	$vi
	and set -l insert insert
	or  set -l insert default

	type -q fzf_key_bindings
	and fzf_key_bindings

	bind -M $insert ! bind-bang
	bind -M $insert '$' bind-dollar

	if $vi
		bind -M insert \ek history-token-search-backward
		bind -M insert \ej history-token-search-forward
	else
		bind \ep history-token-search-backward
		bind \en history-token-search-forward
	end

	if $vi
		bind -M insert fd 'set fish_bind_mode default;
			commandline -f backward-char repaint-mode'
		bind -M visual fd 'set fish_bind_mode default;
			commandline -f end-selection repaint-mode'
		bind -M replace fd 'set fish_bind_mode default;
			commandline -f cancel backward-char repaint-mode'
		bind -M replace_one fd 'set fish_bind_mode default;
			commandline -f cancel repaint-mode'
	end

	bind ' ' "expand-token ' '"
	bind \r  'expand-token --no-abbr -f execute'
end
