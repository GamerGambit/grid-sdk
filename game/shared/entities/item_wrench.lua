entities.require("item")

class "item_wrench" ("item")

function item_wrench:item_wrench()
	item.item(self)

	self.useTime = 4
end

entities.linkToClassname( item_wrench, "item_wrench" )
