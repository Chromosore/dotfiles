local pack = require("chromosore.pack")

local function cancel(package)
	if not pack.pending[package] then return end
	local lazyspec = pack.pending[package].lazy

	if lazyspec.autocmd then
		vim.api.nvim_del_autocmd(lazyspec.autocmd)
	end

	pack.pending[package] = nil
end

return cancel
