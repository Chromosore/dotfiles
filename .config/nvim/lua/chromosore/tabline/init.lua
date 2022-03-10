local function tablabel(tabnr)
	local buflist = vim.fn.tabpagebuflist(tabnr)
	local winnr = vim.fn.tabpagewinnr(tabnr)
	local curbuf = buflist[winnr]
	local bufname = vim.fn.bufname(curbuf)

	if #bufname ~= 0 then
		bufname =
			vim.fn.pathshorten(
			vim.fn.fnamemodify(bufname, ":~:."))
	else
		bufname = "[No Name]"
	end

	return string.format(" %s ", bufname)
end


local function tabline()
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


return tabline
