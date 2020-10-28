entities.require("item_crowbar")

class "item_crowbar_red" ("item_crowbar")

function item_crowbar_red:item_crowbar_red()
	item_crowbar.item_crowbar(self)

	self.anim = "red"
end

entities.linkToClassname( item_crowbar_red, "item_crowbar_red" )
