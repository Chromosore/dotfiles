-- Just because I'm lazy
return function(event, pattern, callback, opts)
	opts = opts or {}
	opts.pattern = pattern
	opts.callback = callback
	-- Just in case
	opts.command = nil
	return vim.api.nvim_create_autocmd(event, opts)
end
