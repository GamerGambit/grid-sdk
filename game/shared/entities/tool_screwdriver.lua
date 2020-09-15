entities.require("tool")

class "tool_screwdriver" ("tool")

function tool_screwdriver:tool_screwdriver()
	tool.tool(self)

	self.useTime = 4
end

entities.linkToClassname( tool_screwdriver, "tool_screwdriver" )
