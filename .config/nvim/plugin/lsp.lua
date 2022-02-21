local lspconfig = require("lspconfig")
local util      = require("lspconfig.util")

-- setup [[[1
local runtime_path = vim.split(package.path, ";");

-- xcrun [[[1
local function xcrun(cmd)
	if vim.fn.has("mac") then
		table.insert(cmd, 0, "xcrun")
	end
	return cmd
end
-- ]]]


lspconfig.clangd.setup{
	cmd = xcrun({ "clangd" });
}

lspconfig.tsserver.setup{}

lspconfig.sumneko_lua.setup{
	root_dir = function(filename)
		return util.search_ancestors(filename, function(path)
			if util.path.is_dir(util.path.join(path, '.git')) or util.path.is_file(util.path.join(path, '.git')) then
				return path
			elseif vim.fn.fnamemodify(path, ":t") == "lua" then
				return path
			end
		end) or util.path.dirname(filename)
	end;

	settings = {
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
	};
}

-- vim: fdm=marker fmr=[[[,]]]
