set -q FISH_GREETING_DATE_FILE
or set -U FISH_GREETING_DATE_FILE ~/.local/share/fish/date_file

function fish_greeting
	echo "Last login: "(cat $FISH_GREETING_DATE_FILE)
	date > $FISH_GREETING_DATE_FILE
	echo $fish_greeting
end
