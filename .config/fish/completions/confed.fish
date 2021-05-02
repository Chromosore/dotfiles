ccbegin confed

ccdispatch -x
ccdispatch -a '(for dir in $CONFED_PATH; ls $dir; end)'
ccdispatch -a '(for file in $CONFED_SPECIAL; echo (basename $file); end)'

ccend
