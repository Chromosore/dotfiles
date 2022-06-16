--- Returns a table which tries to resolve unknown keys to modules relative
--- to the specified base.
---
---@param base string  The base module relative to which modules are resolved;
---@param module table|nil  The table. Defaults to {}
---@return table module that was passed to the function.
---
local function autoload(base, module)
	if module == nil then
		module = {}
	end

	vim.validate{
		module = { module, "table", true };
	}

	setmetatable(module, {
		__index = function(table, key)
			local exists, submodule = pcall(require, string.format("%s.%s", base, key))

			if exists then
				table[key] = submodule
				return submodule
			end
		end;
	})

	return module
end

return autoload
