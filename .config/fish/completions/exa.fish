complete -c exa -s \? -l help -d "show list of command-line options"
complete -c exa -s v -l version -d "show version of exa"

# DISPLAY OPTIONS
complete -c exa -s 1 -l oneline -d "display one entry per line"
complete -c exa -s l -l long -d "display extended file metadata as a table"
complete -c exa -s G -l grid -d "display entries as a grid (default)"
complete -c exa -s x -l across -d "sort the grid across, rather than downwards"
complete -c exa -s R -l recurse -d "recurse into directories"
complete -c exa -s T -l tree -d "recurse into directories as a tree"
complete -c exa -s F -l classify -d "display type indicator by file names"
complete -c exa -l color -a "always auto never" -x -d "when to use terminal colours"
complete -c exa -l color-scale -d "highlight levels of file sizes distinctly"

# FILTERING AND SORTING OPTIONS
complete -c exa -s a -l all -d "show hidden and 'dot' files"
complete -c exa -s d -l list-dirs -d "list directories like regular files"
complete -c exa -s L -l level -d "limit the depth of recursion"
complete -c exa -s r -l reverse -d "reverse the sort order"
complete -c exa -s s -l sort \
		-a "name Name extension Extension size type modified accessed created inode none" -x \
		-d "which field to sort by"
complete -c exa -l group-directories-first -d "list directories before other files"
complete -c exa -s D -l only-dirs -d "list only directories"
complete -c exa -s I -l ignore-glob -d "glob patterns (pipe-separated) of files to ignore"
complete -c exa -l git-ignore -d "Ignore files mentioned in '.gitignore'"

# LONG VIEW OPTIONS
complete -c exa -s b -l binary -d "list file sizes with binary prefixes"
complete -c exa -s B -l bytes -d "list file sizes in bytes, without any prefixes"
complete -c exa -s g -l group -d "list each file's group"
complete -c exa -s h -l header -d "add a header row to each column"
complete -c exa -s H -l links -d "list each file's number of hard links"
complete -c exa -s i -l inode -d "list each file's inode number"
complete -c exa -s m -l modified -d "use the modified timestamp field"
complete -c exa -s S -l blocks -d "show number of file system blocks"
complete -c exa -s t -l time -a "modified accessed created" -x -d "which timestamp field to list"
complete -c exa -s u -l accessed -d "use the accessed timestamp field"
complete -c exa -s U -l created -d "use the created timestamp field"
complete -c exa -l time-style -a "default iso long-iso full-iso" -x -d "how to format timestamps"
