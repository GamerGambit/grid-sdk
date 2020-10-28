entities.require("item_crowbar")

class "item_crowbar_brass" ("item_crowbar")

function item_crowbar_brass:item_crowbar_brass()
	item_crowbar.item_crowbar(self)

	self.anim = "brass"
end

entities.linkToClassname( item_crowbar_brass, "item_crowbar_brass" )
