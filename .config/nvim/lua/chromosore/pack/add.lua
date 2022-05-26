local pack = require("chromosore.pack")

local function packadd(package)
	if vim.v.vim_did_enter == 1 then
		vim.cmd(([[packadd  %s]]):format(package))
	else
		vim.cmd(([[packadd! %s]]):format(package))
	end
end


local function add(spec)
	if type(spec) == "string" then
		local package = spec
		if pack.pending[package] then
			spec = pack.pending[package].spec
			pack.cancel(package)
		else
			spec = { package = package }
		end
	end

	local package = spec.package or spec[1]
	if pack.loaded[package] then return end

	if spec.requires then
		for _, package in ipairs(spec.requires) do
			add(package)
		end
	end

	packadd(package)
	pack.loaded[package] = true
end

return add
