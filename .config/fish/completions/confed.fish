complete -c confed -x
complete -c confed -a '(for dir in $CONFED_PATH; ls $dir; end)'
complete -c confed -a '(for file in $CONFED_SPECIAL; echo (basename $file); end)'
