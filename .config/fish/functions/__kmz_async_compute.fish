function __kmz_async_compute
	if test (count $argv) -lt 2
		printf (_ "%ls: Expected at least %d args, got only %d\n") \
		   (status current-function) 2 0
		return 1
	end

	set -l $varname
	or return 1

	set varname $argv[1]
	set -e argv[1]

	set -l tmpdir /tmp
	set -q TMPDIR
	and set -l tmpdir $TMPDIR
	set tmpfile (mktemp $tmpdir/.async_compute.XXXXXXXXXX)

	while true
		set funcname __async_compute_(random)
		if not functions $funcname >/dev/null 2>/dev/null
			break
		end
	end


	fish -c "$argv" >$tmpfile &
	set pid (jobs --last --pid)

	function $funcname --on-job-exit $pid -V varname -V tmpfile -V funcname
		set -g $varname (cat $tmpfile)
		command rm $tmpfile
		functions -e $funcname
	end


	echo $pid
end
