abbr -a -g g git

set -l gitcommands \
	s  'status' \
	s. 'status .' \
	sw 'switch' \
	l  'log-1' \
	ll 'log' \
	a  'add' \
	ap 'add --patch' \
	r  'reset' \
	rs 'restore' \
	b  'branch' \
	cm 'commit' \
	ca 'commit --amend' \
	c  'clone' \
	d  'diff' \
	dc 'diff --staged' \
	st 'stash' \
	ss 'stash show' \
	sd 'stash drop' \
	s+ 'stash push' \
	s- 'stash pop' \
	p  'push' \
	m  'merge' \
	mu 'merge @{upstream}' \
	o\? 'fetch' \
	o+ 'log-1 ^@{upstream} @ --no-decorate' \
	o- 'log-1 ^@ @{upstream} --no-decorate' \
	sm 'submodule' \
	rb 'rebase' \
	co 'checkout'

for index in (seq 1 2 (count $gitcommands))
	set -l short $gitcommands[$index]
	set -l long  $gitcommands[(math $index + 1)]

	abbr -a g$short git $long

	set -l name git_(string escape --style=var -- $short)
	function _expand_$name -V long -V short
		_lga_define_subcommand_expansion $long git $short
	end
	abbr -a _$name --regex (string escape --style=regex $short) --position anywhere --function _expand_$name
end
