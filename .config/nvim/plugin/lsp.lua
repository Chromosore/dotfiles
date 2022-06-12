local lspconfig = require("lspconfig")
local util      = require("lspconfig.util")

-- setup [[[1
local runtime_path = vim.split(package.path, ";");

-- xcrun [[[1
local function xcrun(cmd)
	if vim.fn.has("mac") == 1 then
		table.insert(cmd, 1, "xcrun")
	end
	return cmd
end
-- ]]]

local function lsp_attach()
	local nnoremap = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = true }) end
	-- vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
	-- keys
	nnoremap("K",     vim.lsp.buf.hover)
	-- TODO: [d and ]d souldn't be here, because they're not LSP
	nnoremap("[d",    vim.diagnostic.goto_prev)
	nnoremap("]d",    vim.diagnostic.goto_next)
	nnoremap("<C-]>", vim.lsp.buf.definition)
	nnoremap("<F2>",  vim.lsp.buf.rename)
	vim.cmd [[
		autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	]]
end


lspconfig.clangd.setup{
	cmd = xcrun({ "clangd" });
	on_attach = lsp_attach;
}

lspconfig.tsserver.setup{
	on_attach = lsp_attach;
}

lspconfig.sumneko_lua.setup{
	on_attach = lsp_attach;

	root_dir = function(filename) -- [[[1
		local root = util.search_ancestors(filename, function(path)
			local gitpath = util.path.join(path, '.git')
			if util.path.is_dir(gitpath) or util.path.is_file(gitpath) then
				return path
			elseif vim.fn.fnamemodify(path, ":t") == "lua" then
				return path
			end
		end)

		return root or util.path.dirname(filename)
	end;

	settings = { -- [[[1
		Lua = {
			runtime = {
				version = "LuaJIT";
				path = {
					"?.lua",
					"?/init.lua",
					unpack(runtime_path),
				};
			};

			diagnostics = {
				globals = { "vim" };
			};

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			};

			telemetry = {
				enable = false;
			};
		};
	} -- ]]];
}

-- vim: fdm=marker fmr=[[[,]]]
