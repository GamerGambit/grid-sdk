entities.require("item")

class "item_welder_experimental_brass" ("item_welder_experimental")

item_welder_experimental_brass._anims = {
	welder = item_welder._sprite:createAnimInstance("brass"),
	on = item_welder._sprite:createAnimInstance("brass_on"),
}

function item_welder_experimental_brass:item_welder_experimental_brass()
	item_welder_experimental.item_welder_experimental(self)

	self.anims = item_welder_experimental_brass._anims
end

entities.linkToClassname( item_welder_experimental_brass, "item_welder_experimental_brass" )
