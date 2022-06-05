_G.chromosore = require("chromosore")
local lazily = require("lazily")

-- conditionnaly loaded plugins
if vim.g["chromosore#local#nerdfont"] == 1 then
	lazily.packadd "vim-devicons"
end

-- lazily loaded plugins
lazily.use("nerdtree", {
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
