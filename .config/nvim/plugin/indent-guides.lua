require("indent_blankline").setup{
	char = "▏";

	show_first_indent_level = true;
	show_trailing_blankline_indent = false;

	filetype_exclude = {"", "text", "nerdtree", "man"};
	buftype_exclude = {"help", "terminal", "quickfix"};

	max_indent_increase = 2;
}
