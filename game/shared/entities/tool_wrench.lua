entities.require("tool")

class "tool_wrench" ("tool")

function tool_wrench:tool_wrench()
	tool.tool(self)

	self.useTime = 4
end

entities.linkToClassname( tool_wrench, "tool_wrench" )
