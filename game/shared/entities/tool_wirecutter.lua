entities.require("tool")

class "tool_wirecutter" ("tool")

function tool_wirecutter:tool_wirecutter()
	tool.tool(self)

	self.useTime = 4
end

entities.linkToClassname( tool_wirecutter, "tool_wirecutter" )
