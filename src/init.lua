--!nocheck
local module = {}

export type Class<T> = {
	new: (T) -> T,
	metaTable: {
		__index: T,
		init_functions: { (self: T) -> () }?,
	},
}

local function deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

function module.isClass(ref: Class?): boolean
	if typeof(ref) ~= "table" then
		return
	end

	if not ref.new then
		return
	end

	if not ref.metaTable then
		return
	end

	if not ref.metaTable.init_functions then
		return
	end

	if not ref.metaTable.__index then
		return
	end

	return true
end

function module.createSuperClass<T, extend>(def: Class<T>, class: extend, init_function: (self: T & extend) -> ()?)
	type defProps = typeof(def.metaTable.__index)
	type newProps = defProps & extend
	local mergedProps = deepCopy(def.metaTable.__index)
	local mergedInits = deepCopy(def.metaTable.init_functions)

	for i, v in class do
		mergedProps[i] = v
	end

	if init_function then
		table.insert(mergedInits, init_function)
	end

	return module.createSubclass(mergedProps, mergedInits) :: Class<newProps>
end

function module.createSubclass<R>(def: R, init_functions: { (self: R) -> () }?): Class<R>
	local self = {}
	self.metaTable = {
		__index = def,
		init_functions = init_functions or {},
	}

	function self.new(properties: R)
		local class = setmetatable(properties, self.metaTable)
		for _, callback in self.metaTable.init_functions do
			callback(class)
		end
		return class
	end

	return self
end

return module
