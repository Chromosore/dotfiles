local callbacks = {}
local inc = 0

local function encode(str)
	return ("_%d_"):format(string.byte(str))
end

local function genkey(func)
	local base
	local info = debug.getinfo(func)

	if info.what ~= nil then
		base = info.what
	elseif info.source ~= nil then
		base = info.source
	else
		base = "function"
	end

	return base:gsub("-", "_")
		:gsub("[^%w_]", encode)
		:gsub("^(%d)", "_%1", 1)
end

local function tweak(basekey)
	inc = inc + 1
	return ("%s_%d"):format(basekey, inc)
end


local function mapper(mode, options)
	local function map(lhs, rhs, opts)
		opts = vim.tbl_extend("error", options, opts or {})

		local buffer = opts.buffer
		opts.buffer = nil

		if type(rhs) == "function" then
			local basekey = genkey(rhs)
			local key = basekey

			while callbacks[key] ~= nil do
				key = tweak(basekey)
			end

			callbacks[key] = rhs
			if opts.expr then
				rhs = string.format("v:lua.chromosore.vim.util.mapper.callbacks.%s()", key)
			else
				rhs = string.format("<Cmd>call v:lua.chromosore.vim.util.mapper.callbacks.%s()<CR>", key)
			end
		end

		if buffer == true then
			vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
		elseif type(buffer) == "number" then
			vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
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
