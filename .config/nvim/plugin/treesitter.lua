require'nvim-treesitter.configs'.setup{
	highlight = {
		enable = true;
		additional_vim_regex_highlighting = false;
	};

	incremental_selection = {
		enable = true;
		keymaps = {
			node_incremental  = "v";
			scope_incremental = "<C-V>";
			node_decremental  = "V";
		};
	};

	indent = {
		enable = true;
	};
}
