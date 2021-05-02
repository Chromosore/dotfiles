function loop
	ssh -p 4289 -t raphael@localhost "fish -C 'export SSH_AUTH_SOCK=$SSH_AUTH_SOCK'"
end
