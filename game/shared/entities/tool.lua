entities.require("item")

class "tool" ("item")

function tool:tool()
	item.item(self)

	self.useTime = 0 -- seconds
end
