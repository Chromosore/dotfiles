_G.chromosore = require("chromosore")
local pack = chromosore.pack


-- editing
pack.add "vim-commentary"
pack.add "vim-sandwich"

-- languages
pack.add "nvim-lspconfig"
pack.add "editorconfig.nvim"
pack.add "nvim-treesitter"
pack.add "spellsitter.nvim"
pack.add "vim-quicktask"
pack.add "vim-kitty"

-- neovim tooling
pack.add "nvim-luapad"

-- ui
if vim.g["chromosore#local#nerdfont"] == 1 then
	pack.add "vim-devicons"
end

pack.add "fzf"
pack.add "indent-blankline.nvim"

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
