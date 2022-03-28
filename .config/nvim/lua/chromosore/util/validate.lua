local function isinstance(value, types, nilable)
	if value == nil and nilable then
		return true
	end

	for _, typestr in ipairs(types) do
		if type(value) == typestr then
			return true
		end
	end

	return false
end


local function union(types, optional)
	vim.validate {
		types = { types, "table" };
		optional = { optional, "boolean", true };
	}

	local function check(value)
		return isinstance(value, types, optional)
	end

	return check, table.concat(types, " or ")
end


local function validate_table(table, spec)
	if #table ~= #spec then
		return false
	end

	for key, typespec in pairs(spec) do
		local value = table[key]
		local message = nil

		if type(typespec) == "table" then
			message, typespec = unpack(typespec)
		end

		if type(typespec) == "string" then
			if type(value) ~= typespec then
				return false, message
			end
		elseif type(typespec) == "function" then
			local valid, maybe_message = typespec(value)
			if not valid then
				return false, maybe_message or message
			end
		else
			return false
		end
	end

	return true
end


local function table(spec)
	vim.validate {
		spec = { spec, function(table)
			for _, typespec in pairs(table) do
				if not (isinstance(typespec, {"string", "function"})
						or (type(typespec) == "table"
							and validate_table(typespec, {
									[1] = union{"string", "function"};
									[2] = union{"string", "nil"};
						}))) then
					return false
				end
			end

			return true
		end };
	}

	local function check(value)
		return validate_table(value, spec)
	end

	return check, vim.inspect(spec, { newline = " ", indent = " " })
end


return {
	union = union;
	table = table;
}
