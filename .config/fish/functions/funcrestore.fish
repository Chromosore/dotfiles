function funcrestore
	set -l func $argv[1]

	for file in $FUNCDEL_TRASH_PATH/*.I
		set -l record (cat $file | string split0)
		if test $record[1] = $func
			mv $FUNCDEL_TRASH_PATH/(basename $file .I).O $record[2]
			rm $file
			return 0
		end
	end

	echo "No such function found"
	return 1
end
