local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function()
	local Inherit = require(ReplicatedStorage.Packages.Inherit)

	describe("createSubclass", function()
		local subclass = Inherit.createSubclass({
			Name = "Subclass",
		}, {
			function() end,
		})

		afterAll(function()
			subclass = nil
		end)

		it("should create a subclass", function()
			expect(Inherit.isClass(subclass)).to.be.equal(true)
		end)

		it("should have properties", function()
			expect(subclass.metaTable.__index.Name).to.be.ok()
		end)

		it("should have init function", function()
			expect(#subclass.metaTable.init_functions).to.be.equal(1)
		end)
	end)

	describe("createSuperClass", function()
		local subclass = Inherit.createSubclass({
			Name = "Subclass",
		})
		local superclass = Inherit.createSuperClass(subclass, {
			SuperClassed = true,
		})

		afterAll(function()
			subclass = nil
			superclass = nil
		end)

		it("should extend a subclass", function()
			expect(superclass.metaTable.__index.SuperClassed).to.be.ok()
		end)
	end)

	describe("Class", function()
		local referenceInInitFunctionIsRight = false
		local initFunctionCalled = false
		local subclass = Inherit.createSubclass({
			Name = "Class",
		}, {
			function(self)
				initFunctionCalled = true

				if self.Name == "CoolClass" then
					referenceInInitFunctionIsRight = true
				end
			end,
		})

		afterAll(function()
			subclass = nil
		end)

		describe("new", function()
			local class = subclass.new({
				Name = "CoolClass",
			})

			afterAll(function()
				class = nil
			end)

			it("should have properties", function()
				for i, v in subclass.metaTable.__index do
					expect(class[i]).to.be.a(typeof(v))
				end
			end)

			it("should call init function", function()
				expect(initFunctionCalled).to.be.equal(true)
			end)

			it("should give self to init function", function()
				expect(referenceInInitFunctionIsRight).to.be.equal(true)
			end)
		end)
	end)
end
