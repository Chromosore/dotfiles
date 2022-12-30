return function(options)
	for option, value in pairs(options) do
		vim.opt[option] = value
	end
end
