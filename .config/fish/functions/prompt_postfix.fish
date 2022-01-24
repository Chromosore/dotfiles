function prompt_postfix
	set -q prompt_postfix_level
	or set -l prompt_postfix_level ''

	set -q prompt_postfix
	or set -l prompt_postfix '$ '

	if test "$prompt_postfix_level_zero" = "1"
		set prompt_level (math $SHLVL - 1)
	else
		set prompt_level $SHLVL
	end

	printf ' %s%s' \
		(string repeat -n $prompt_level $prompt_postfix_level) \
		$prompt_postfix
end
