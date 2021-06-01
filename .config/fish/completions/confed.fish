complete -c confed -x
complete -c confed -a '(for dir in $CONFED_PATH; find $dir/ -mindepth 1 -maxdepth 1 -printf "%f\n"; end)'
complete -c confed -a '(for file in $CONFED_SPECIAL; echo (basename $file); end)'
