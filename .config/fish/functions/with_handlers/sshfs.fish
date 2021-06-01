function sshfs_after
	set mnt_point $argv[-1]

	umount -l $mnt_point
end
