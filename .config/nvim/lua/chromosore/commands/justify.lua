local list_reduce = require('chromosore').util.list_reduce


local function justify(firstline, lastline, maxlength, maxgap)
	if firstline == nil and lastline == nil then
		-- assume that this function is being used a the 'formatexpr'
		firstline = vim.v.lnum
		lastline  = vim.v.lnum + vim.v.count - 1
	end

	local lines = vim.api.nvim_buf_get_lines(0, firstline-1, lastline, true)

	if maxlength == nil then
		maxlength = list_reduce(lines, function(acc, line)
			return math.max(acc, vim.fn.strchars(line))
		end, 0)
	end

	if maxgap == nil then
		maxgap = maxlength * 1/3
	elseif maxgap == -1 then
		maxgap = maxlength
	end

	for index, line in ipairs(lines) do
		local length = vim.fn.strchars(line)
		local _, spacenr = line:gsub(" ", "")

		-- how many characters are missing
		local  gap = maxlength - length
		if gap > maxgap then
			goto continue
		end

		-- spacenr + gap = target number of spaces
		local ratio = (spacenr + gap) / spacenr
		local acc = 0

		lines[index] = line:gsub(" ", function()
			local delta = math.floor(acc + ratio) - math.floor(acc)
			acc = acc + ratio
			return string.rep(" ", math.max(delta, 1))
		end)

		::continue::
	end

	vim.api.nvim_buf_set_lines(0, firstline-1, lastline, true, lines)
end


return justify
