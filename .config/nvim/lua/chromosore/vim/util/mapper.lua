local callbacks = {}

local function mapper(mode, options)
	local function map(lhs, rhs, opts)
		opts = vim.tbl_extend("error", options, opts or {})

		local buffer = opts.buffer
		opts.buffer = nil

		if type(rhs) == "function" then
			error("Functions are currently not supported in mappings. Soon.")
			local key = nil -- TODO: Find a way to generate a unique key
			rhs = string.format("v:lua.chromosore.vim.util.mapper.%s()", key)
		end

		if buffer == true then
			vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs)
		elseif type(buffer) == "number" then
			vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs)
		else
			vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
		end
	end

	return map
end

return {
	new = mapper;
	callbacks = callbacks;
}
