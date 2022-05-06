complete -c pkg-remove -s h -l help
complete -c pkg-remove -s p -l prune \
	-d 'Remove directories left empty after uninstalling the package'
complete -c pkg-remove -s i -l install-root -r \
	-d 'Work with packages installed in the volume DIR instead of /'
complete -c pkg-remove -s v -l verbose
complete -c pkg-remove -s f -l force \
	-d 'Do not prompt before proceeding'

complete -c pkg-remove -x -a '(pkgutil --pkgs)'
