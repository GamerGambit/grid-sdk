entities.require("item_welder")

class "item_welder_experimental" ("item_welder")

item_welder_experimental._anims = {
	on = item_welder._sprite:createAnimInstance("ex_on"),
}

function item_welder_experimental:item_welder_experimental()
	item_welder.item_welder(self)

	self.maxFuel = 40
	self.fuel = 40

	self.anims = item_welder_experimental._anims
	self.anims.welder = item_welder._sprite:createAnimInstance("ex") -- do this here, so each entity gets its own timed instance of the welder animation
end

entities.linkToClassname( item_welder_experimental, "item_welder_experimental" )
