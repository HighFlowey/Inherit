--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local BasePart = require(ServerScriptService.Classes.BasePart)

task.spawn(function()
	for _ = 1, 1000 do
		local _ = BasePart.new({
			Parent = workspace,
			CFrame = CFrame.new(0, 10, 0),
			Name = "MyPart",
		})

		task.wait(0.5)
	end
end)
