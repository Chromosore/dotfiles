local pack = require("chromosore.pack")

local function lazy(package, spec)
	local lazyspec = {}
	local loadspec = {
		package = package;
		requires = spec.requires;
	}

	if spec.autocmd then
		local autocmd = spec.autocmd

		lazyspec.autocmd = vim.api.nvim_create_autocmd(autocmd.event, {
			pattern = autocmd.pattern;
			callback = function(event)
				if not autocmd.filter or autocmd.filter(event) then
					pack.add(package)
				end
			end;
		})
	end

	pack.pending[package] = {
		spec = loadspec;
		lazy = lazyspec;
	}
end

return lazy
