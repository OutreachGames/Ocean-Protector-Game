-- Module that helps with various common operations

local EXT = {}

EXT.vec4_white_a100 = vmath.vector4(1, 1, 1, 1)
EXT.vec4_white_a90 = vmath.vector4(0.9, 0.9, 0.9, 0.9)
EXT.vec4_white_a80 = vmath.vector4(0.8, 0.8, 0.8, 0.8)
EXT.vec4_black = vmath.vector4(0, 0, 0, 0)
EXT.vec3_up = vmath.vector3(0, 1, 0)

---Get sign of a number
---@param n number Value to get the sign of
---@return number -1 if negative, 1 if positive, and 0 if 0
function EXT:math_sign(n)

    return n > 0 and 1 or (n < 0 and -1 or 0)

end

---Calculates percent progress from start number to the end number given current number
---@param val_current number Current value to get percentage of
---@param val_start number Starting/minimum value of range 
---@param val_end number Ending/maximum value of range 
---@return number percent number, decimal
function EXT:Calculate_Percentage(val_current, val_start, val_end)

    return (val_current - val_start) / (val_end - val_start)

end

---Performs a linear interpolation from the start number to the end number
---@param val_start number Starting value (value if delta = 0)
---@param val_end number Ending value (value if delta = 1)
---@param delta number Percentage to lerp from starting to end value
---@return number lerped number
function EXT:Lerp( val_start, val_end, delta)

	if ( delta > 1 ) then return val_end end
	if ( delta < 0 ) then return val_start end

	return val_start + ( val_end - val_start ) * delta

end

---Pick random sign
---@return number either -1 or 1
function EXT:math_random_sign()

    return (math.random(0, 1)*2) - 1

end

---Clamps number between min and max
---@param value number Value to clamp
---@param min number Minimum value allowed
---@param max number Maximum value allowed
---@return number clamped number
function EXT:math_clamp(value, min, max)

	if value < min then
		return min
	end
	if value > max then
		return max
	end
	return value

end

---Rounds to nearest specified decimal point, or integer for default ot 0 decimal points
---@param input_number number|string Value to round
---@param numDecimalPlaces number Number of decimal places to round to, default is none
---@return number rounded number
function EXT:math_round(input_number, numDecimalPlaces)

	input_number = tonumber(input_number, 10) or 0
	numDecimalPlaces = numDecimalPlaces or 0

	if numDecimalPlaces > 0 then
		local mult = 10^numDecimalPlaces
		return math.floor(input_number * mult + 0.5) / mult
	else
		return math.floor(input_number + 0.5)
	end

end

---Checks if value equals one of the array options
---@param val number|string value to check against options
---@param array table flat list of i options
---@return boolean true if match found, false if otherwise
function EXT:equalAny(val, array)

	local result = false

	if array ~= nil and val ~= nil then
		if #array >= 1 then
			for i=1,#array do
				if val == array[i] then
					result = true
					break
				end
			end
		end
	end

	return result

end

---Checks if string is present in at least one of the array options
---@param str string value to check against options
---@param array table flat list of i options
---@return boolean true if match found, false if otherwise
function EXT:string_findAny(str, array)

	local result = false

	if array ~= nil and str ~= nil then
		if #array >= 1 then
			for i=1,#array do
				if string.find(str, tostring(array[i]) or "") ~= nil then
					result = true
					break
				end
			end
		end
	end

	return result

end

---Checks if string equals one of the array options
---@param str string value to check against options
---@param array table flat list of i options
---@return boolean true if match found, false if otherwise
function EXT:string_equalAny(str, array)

	local result = false

	if array ~= nil and str ~= nil then
		if #array >= 1 then
			for i=1,#array do
				if str == tostring(array[i]) then
					result = true
					break
				end
			end
		end
	end

	return result

end

---Filters out characters after a given character ("star#1" -> "star")
---@param str string string to filter
---@param chr string|nil character to filter after, "#" by default
---@return string filtered string
function EXT:string_filterInvisible(str, chr)

	chr = chr or "#"

	local index = str:find(chr, 0, true)
	if (index ~= nil) then
		str = str:sub(1, index - 1)
	end

	return str

end

---Returns "min" or "max" of a table of values such as {1,2,3}
---@param nlist table|number list of numbers or single number to get "max" or "min" of
---@param method string method to use, either "max" or "min"
---@return number "max" or "min" of listed values
function EXT:math_m_list(nlist, method)

	local final = 1

	if type(nlist) == "number" then
		final = nlist
	end
	if type(nlist) == "table" and (method == "max" or method == "min") then
		if #nlist > 0 then
			table.sort(nlist)
			if method == "min" then
				final = nlist[1]
			end
			if method == "max" then
				final = nlist[#nlist]
			end
		end
	end

	return final

end

---Gets random value from a table given weights.
---List weights should be in integer percent, ranging from 0 to 100, should not use decimals.
---If no weights are present, weights are random uniform.
---@param tbl table table of options in form {{"thing1", 30}, {"thing2", 40}, {"thing3"}}
---@return any selected entry
function EXT:math_Random_Weighted(tbl)

	-- validity checks
	if tbl == nil then
		print("Error: Random_Weighted() was given a nil value...\n")
		return nil
	end
	if type(tbl) ~= "table" then
		print("Error: Random_Weighted() was given a value ("..tostring(tbl)..") that was not a table...\n")
		return tbl
	end

	local num_tbl = #tbl
	if num_tbl < 0 then
		print("Error: Random_Weighted() was given a table with no values...\n")
		return nil
	end

	local sum_of_weights = 0

	-- To select among weighted events, you compute a random value from 0 to the sum of the weights:
	-- (Depending on how you generate your percent you could possibly skip this calculation step, if, for instance, you know it will always add up to one)

	local default_weight = math.floor(1/num_tbl)*100
	for _,v in pairs(tbl) do
		if type(v) ~= "table" then
			print("Error: the table input for Random_Weighted() does not contain a sub table...\n")
			break
		end
		if #v <= 0 then
			print("Error: the table input for Random_Weighted() does not have a value...\n")
			break
		end
		local weight = v[2] or default_weight
		sum_of_weights = sum_of_weights + weight
	end

	-- We then look at our list and can think of it as a numberline. 
	-- Each item 'owns' a portion of the line from 0 to totalweight, and at is some random place in between. 
	-- To find which place, we can do something like this:

	local selection = math.random() * sum_of_weights
	local selection_ikey = 0

	for i,v in ipairs(tbl) do
		local weight = v[2] or default_weight
		if selection <= weight then
			selection_ikey = i
			break
		end
		selection = selection - weight
	end

	if selection_ikey <= 0 then
		print("Error: could not find a value for Random_Weighted(), picking the first one by default..\n")
		selection_ikey = 1
	end

	return tbl[selection_ikey][1]

end

---Gets random value from a table of options
---@param tbl table table of options in form {"thing1", "thing2", "thing3"}
---@return any selected entry
function EXT:Random_fromTable(tbl)

	if type(tbl) == "table" then
		local num = #tbl
		local randomi = math.random(1, num)
		local choice = tbl[randomi]
		return choice
	else
		return tbl
	end

end

---Gets a value of a random number in the given range with a random sign.
---For example {1, 10} could return -5
---@param low number Minimum value for magnitude
---@param high number Maximum value for magnitude 
---@return number|nil selected value with random sign or nil if invalid
function EXT:Random_Magnitude(low, high)

	if type(low) == "number" and type(high) == "number" then
		-- failsafe max and min selection
		local min = math.min(low, high)
		local max = math.max(low, high)
		-- randomly pick a sign
		local sign = 1
		if math.random(0,1) == 1 then sign = -1 end
		-- return value with that sign
		return math.random(min,max)*sign
	else
		print("RandomMagnitude given non number values, returning 0...\n")
		return nil
	end

end

---Takes an i-based table and returns a new table with the contents in random order.
---@param t table I-based table to shuffle 
---@return table new table with shuffled contents 
function EXT:Table_Shuffle(t)

	local tbl = {}
	for i = 1, #t do
		tbl[i] = t[i]
	end
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl

end


return EXT

