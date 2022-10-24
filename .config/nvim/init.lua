_G.chromosore = require("chromosore")
local lazily = require("lazily")

-- lazily loaded plugins
lazily.use("nerdtree", {
	autocmd = {
		event = {"BufEnter", "BufNew"};
		pattern = "*";
		filter = function(event)
			return vim.fn.isdirectory(event.match) == 1
		end;
	},
})
