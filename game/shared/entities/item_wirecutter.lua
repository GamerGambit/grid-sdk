entities.require("item")

class "item_wirecutter" ("item")

function item_wirecutter:item_wirecutter()
	item.item(self)

	self.useTime = 4
end

entities.linkToClassname( item_wirecutter, "item_wirecutter" )
