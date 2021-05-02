if not set -q FUNCDEL_TRASH_PATH
	set -U FUNCDEL_TRASH_PATH $HOME/.local/share/fish/deleted_funcs
	mkdir $FUNCDEL_TRASH_PATH
end

function funcdel
	set -l func $argv[1]
	set -l funcpath (functions -D $func)

	if contains $funcpath '-' 'n/a'
		echo "Cannot del $func"
		return 1
	else
		set -l rand_num (random)

		while test -e $FUNCDEL_TRASH_PATH/$rand_num
			set -l rand_num (random)
		end

		mv $funcpath $FUNCDEL_TRASH_PATH/$rand_num.O
		string join0 "$func" "$funcpath" > $FUNCDEL_TRASH_PATH/$rand_num.I
	end

	funcclean
end
