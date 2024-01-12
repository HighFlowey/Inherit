local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Inherit = require(ReplicatedStorage.Packages.Inherit)

local properties = {
	ClassName = "Instance",
	Name = "Instance",
	Parent = game,
}

function properties.Destroy(self: typeof(properties)) -- typeof(properties) is for adding autocomplete
	table.clear(self)
end

return Inherit.createSubclass(properties, {
	function(self)
		print(`{self.Name} got created`)
	end,
})
