entities.require("item_crowbar")

class "item_crowbar_large" ("item_crowbar")

function item_crowbar_large:item_crowbar_large()
	item_crowbar.item_crowbar(self)

	self.anim = "large"
end

entities.linkToClassname( item_crowbar_large, "item_crowbar_large" )
