entities.require("item")

class "item_welder_mini" ("item_welder")

item_welder_mini._anims = {
	welder = item_welder._sprite:createAnimInstance("mini"),
	on = item_welder._sprite:createAnimInstance("mini_on"),
}

function item_welder_mini:item_welder_mini()
	item_welder.item_welder(self)

	self.maxFuel = 10
	self.fuel = 10

	self.anims = item_welder_mini._anims
end

entities.linkToClassname( item_welder_mini, "item_welder_mini" )
