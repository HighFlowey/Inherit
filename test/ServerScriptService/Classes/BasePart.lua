local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobloxInstance = Instance
local Instance = require(script.Parent.Instance)
local Inherit = require(ReplicatedStorage.Packages.Inherit)

local properties = {
	ClassName = "Part",
	Name = "Part",
	Size = Vector3.one,
	CFrame = CFrame.new(),
}

return Inherit.createSuperClass(Instance, properties, function(self)
	local fakeParts = RobloxInstance.new("Part")
	fakeParts.CFrame = self.CFrame
	fakeParts.Size = self.Size
	fakeParts.Name = self.Name
	fakeParts.Parent = self.Parent
	fakeParts:SetAttribute("ClassName", self.ClassName)
end)
