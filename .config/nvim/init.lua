_G.chromosore = require("chromosore")
local pack = chromosore.pack

-- conditionnaly loaded plugins
if vim.g["chromosore#local#nerdfont"] == 1 then
	pack.add "vim-devicons"
end

-- lazily loaded plugins
pack.lazy("nerdtree", {
	autocmd = {
		event = {"BufEnter", "BufNew"};
		pattern = "*";
		filter = function(event)
			return vim.fn.isdirectory(event.match) == 1
		end;
	},
	requires = {
		"vim-nerdtree-syntax-highlight",
	},
})


vim.cmd [[
	filetype plugin indent on
	syntax enable
]]
