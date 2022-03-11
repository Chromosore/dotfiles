local tablabel = require("chromosore.tabline.label")

local function tabs()
	local curtab = vim.fn.tabpagenr()
	local parts = {}

	for tab=1,vim.fn.tabpagenr("$") do
		local tabstr = {}
		if tab == curtab then
			table.insert(tabstr, "%#TabLineSel#")
		else
			table.insert(tabstr, "%#TabLine#")
		end

		table.insert(tabstr, "%" .. tab .. "T")
		table.insert(tabstr, tablabel(tab))
		table.insert(tabstr, "%T")

		table.insert(parts, table.concat(tabstr))
	end

	table.insert(parts, "%#TabLineFill#")

	return table.concat(parts)
end

return tabs
