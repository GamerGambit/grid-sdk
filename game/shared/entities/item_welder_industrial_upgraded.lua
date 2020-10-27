entities.require("item")

class "item_welder_industrial_upgraded" ("item_welder")

item_welder_industrial_upgraded._anims = {
	welder = item_welder._sprite:createAnimInstance("upind"),
	on = item_welder._sprite:createAnimInstance("upind_on"),
	fuel = {
		["100"] = item_welder._sprite:createAnimInstance("upind_100"),
		["75"] = item_welder._sprite:createAnimInstance("upind_75"),
		["50"] = item_welder._sprite:createAnimInstance("upind_50"),
		["25"] = item_welder._sprite:createAnimInstance("upind_25"),
		["0"] = item_welder._sprite:createAnimInstance("upind_0"),
	}
}

function item_welder_industrial_upgraded:item_welder_industrial_upgraded()
	item_welder.item_welder(self)

	self.maxFuel = 80
	self.fuel = 80

	self.anims = item_welder_industrial_upgraded._anims
end

entities.linkToClassname( item_welder_industrial_upgraded, "item_welder_industrial_upgraded" )
