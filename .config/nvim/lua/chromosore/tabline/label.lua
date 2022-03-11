local status_modified = {
	[false] = "×";
	[true]  = "•";
}

local function label(tabnr)
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

	bufname = bufname:gsub("%%", "%%%%")

	local close_button = string.format("%%%dX%s%%X",
		tabnr, status_modified[vim.bo[curbuf].modified])

	return " " .. table.concat({ bufname, close_button }, " ") .. " "
end

return label
