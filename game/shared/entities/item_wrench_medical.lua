entities.require("item_wrench")

class "item_wrench_medical" ("item_wrench")

function item_wrench_medical:item_wrench_medical()
	item_wrench.item_wrench(self)

	self.anim = "medical"
end

entities.linkToClassname( item_wrench_medical, "item_wrench_medical" )
