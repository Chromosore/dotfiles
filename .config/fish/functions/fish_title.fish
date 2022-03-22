function fish_title
	if not set -q INSIDE_EMACS || string match -vq '*,term:*' -- $INSIDE_EMACS
		echo (set -q argv[1] && echo $argv[1] || status current-command) (prompt_pwd)
	end
end
