_G.chromosore = require("chromosore")
local lazily = require("lazily")
local set = chromosore.util.set
local autocmd = chromosore.util.autocmd

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

-- New 0.8 treesitter highlight
autocmd("FileType", "*", function(event)
	pcall(vim.treesitter.start, event.buf, vim.bo[event.buf].filetype)
end)

set{
	undofile = true;
	hidden = false;
	lazyredraw = true;

	textwidth = 76;
	spell = true;
	tabstop = 4;
	shiftwidth = 0;

	scrolloff = 5;
	number = true;
	relativenumber = true;
	signcolumn = "number";
	linebreak = true;

	splitbelow = true;
	splitright = true;
	fillchars = { vert = "│" };

	statusline = "%<%f %{&ft!=''?'('..&ft..') ':''}%m%r%=%-14(.%l/%L :%c%V%) %P";
	tabline = "%!v:lua.chromosore.tabline.render()";
	showtabline = 2;

	termguicolors = true;
	-- fish like completion behaviour
	wildmode = { "longest:full", "full" };
}
