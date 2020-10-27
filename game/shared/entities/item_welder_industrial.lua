entities.require("item")

class "item_welder_industrial" ("item_welder")

item_welder_industrial._anims = {
	welder = item_welder._sprite:createAnimInstance("ind"),
	on = item_welder._sprite:createAnimInstance("ind_on"),
	fuel = {
		["100"] = item_welder._sprite:createAnimInstance("ind_100"),
		["75"] = item_welder._sprite:createAnimInstance("ind_75"),
		["50"] = item_welder._sprite:createAnimInstance("ind_50"),
		["25"] = item_welder._sprite:createAnimInstance("ind_25"),
		["0"] = item_welder._sprite:createAnimInstance("ind_0"),
	}
}

function item_welder_industrial:item_welder_industrial()
	item_welder.item_welder(self)

	self.maxFuel = 40
	self.fuel = 40

	self.anims = item_welder_industrial._anims
end

entities.linkToClassname( item_welder_industrial, "item_welder_industrial" )
