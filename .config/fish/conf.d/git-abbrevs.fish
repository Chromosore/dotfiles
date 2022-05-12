abbr -a -g g git

set gitcommands \
	s  'status' \
	s. 'status .' \
	sw 'switch' \
	l  'log' \
	a  'add' \
	ap 'add --patch' \
	r  'reset' \
	rs 'restore' \
	b  'branch' \
	cm 'commit' \
	ca 'commit --amend' \
	c  'clone' \
	d  'diff' \
	dc 'diff --cached' \
	ss 'stash show' \
	sd 'stash drop' \
	s+ 'stash push' \
	s- 'stash pop' \
	o+ 'push' \
	o- 'pull' \
	a+ 'log @{upstream}..' \
	b- 'log ..@{upstream}'

for index in (seq 1 2 (count $gitcommands))
	set short $gitcommands[$index]
	set long  $gitcommands[(math $index + 1)]

	abbr -a -g g$short git $long
	set -g _cmd_abbr_git_2_(string escape --style=var $short) "$long"
end
