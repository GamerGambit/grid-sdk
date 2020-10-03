entities.require("item")

class "item_screwdriver" ("item")

function item_screwdriver:item_screwdriver()
	item.item(self)

	self.useTime = 4
end

entities.linkToClassname( item_screwdriver, "item_screwdriver" )
