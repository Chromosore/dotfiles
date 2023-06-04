abbr -a ports 'netstat -tuplan'
abbr -a pym 'python3 -m'
abbr -a pydoc 'python3 -m pydoc'

abbr -a nd nextd
abbr -a pd prevd

abbr -a n nvim
abbr -a k kak

function bind-bang; echo $history[1]; end
abbr -a !! --position anywhere --function bind-bang


# Remove from history
abbr -a shutdown ' shutdown'
abbr -a clear ' clear'
abbr -a reboot ' reboot'
abbr -a history ' history'


# Verbose & confirm
abbr -a cp 'cp -iv'
abbr -a ln 'ln -v'
abbr -a mv 'mv -iv'
abbr -a mkdir 'mkdir -v'
abbr -a diff 'diff -s'

abbr -a gzip 'gzip -v'
abbr -a gunzip 'gunzip -vf'
abbr -a cpio 'cpio -v'
abbr -a pax 'pax -v'

abbr -a rm 'del -iv'
abbr -a rmdir 'rmdir -v'

abbr -a dotadd  'dotadd -v'
abbr -a dotlink 'dotlink -v'


# ls (exa) aliases
abbr -a ls   'ls -F'
abbr -a la   'ls -Fa'
abbr -a ld   'ls -FD'
abbr -a ll   'ls -GlhF'
abbr -a lll  'ls -lhF'
abbr -a tree 'ls -T'

# use exa instead of ls
set -U __fish_ls_command   'exa'
set -U __fish_ls_color_opt '--color=auto'
