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

	return string.format(" %s ", bufname)
end

return label
