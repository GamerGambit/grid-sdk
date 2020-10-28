entities.require("item_wrench")

class "item_wrench_brass" ("item_wrench")

function item_wrench_brass:item_wrench_brass()
	item_wrench.item_wrench(self)

	self.anim = "brass"
end

entities.linkToClassname( item_wrench_brass, "item_wrench_brass" )
