local Encoder = {}
local serialize;

serialize = function(val)
	local t = typeof(val);

	if t == "string" then
		return string.format("%q", val);
	elseif t == "number" or t == "boolean" then
		return tostring(val);
	elseif t == "table" then
		local items = {};
		for k, v in pairs(val) do
			local key
			if type(k) == "string" and k:match("^[_%a][_%w]*$") then
				key = k .. " = ";
			else
				key = "[" .. serialize(k) .. "] = ";
			end;
			table.insert(items, key .. serialize(v));
		end
		return "{" .. table.concat(items, ", ") .. "}";
	elseif t == "Color3" then
		return string.format("Color3.new(%s)",tostring(val));
	elseif t == "Vector3" then
		return string.format("Vector3.new(%s)",tostring(val));
	else
		return '"Unsupported Type"';
	end;
end;

function Encoder:Encode(Table: {any})
	return "return (" .. serialize(Table)..');';
end;

function Encoder:Decode(source: string)
	return loadstring(source)();
end;

return Encoder;
