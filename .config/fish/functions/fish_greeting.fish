set -q FISH_DATA_FILES
or set -U FISH_DATA_FILES $HOME/.local/share/fish

function fish_greeting
	echo $fish_greeting

	if test -e /usr/share/misc/birthtoken.gz && test (date +%d) = '01'
		if not test -e $FISH_DATA_FILES/new_month
			set -l month (date +%-m)
			set flower (gzip -d -c /usr/share/misc/birthtoken.gz \
			   | awk -F: -v month=$month '/^[^#]/ { ++nline; if (nline == month) print $3 }')

			printf '%s\n%s\n\n' \
				'Happy new month!' \
				"This month's flower is the $flower."
			test -e $HOME/.local/share/misc/$flower
			and cat $HOME/.local/share/misc/$flower

			touch $FISH_DATA_FILES/new_month
		end
	else
		rm -f $FISH_DATA_FILES/new_month
	end


	if test -e ~/.local/bin/gnome-terminal
		set -l message (set_color blue)"Stay in focused mode?"\n"[Y]es, (N)o: "(set_color normal)
		read answer -p "echo '$message'"

		if contains -- (string lower $answer) n no
			rm ~/.local/bin/gnome-terminal
		end
	end
end
