local function list_reduce(list, func, start)
	local acc = start

	for index, item in ipairs(list) do
		if index == 1 and start == nil then
			acc = item
		else
			acc = func(acc, item)
		end
	end

	return acc
end


return list_reduce
