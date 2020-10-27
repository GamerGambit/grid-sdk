entities.require("item")

class "item_welder" ("item")

item_welder._sprite = sprite("images.entities.welder")
item_welder._sprite:setFilter("nearest", "nearest")
item_welder._anims = {
	welder = item_welder._sprite:createAnimInstance("welder"),
	on = item_welder._sprite:createAnimInstance("welder_on"),
	fuel = {
		["100"] = item_welder._sprite:createAnimInstance("welder_100"),
		["75"] = item_welder._sprite:createAnimInstance("welder_75"),
		["50"] = item_welder._sprite:createAnimInstance("welder_50"),
		["25"] = item_welder._sprite:createAnimInstance("welder_25"),
		["0"] = item_welder._sprite:createAnimInstance("welder_0"),
	}
}

function item_welder:item_welder()
	item.item(self)

	self.drawFuelIndicator = true
	self.maxFuel = 20
	self.fuel = 20
	self.on = false

	self.anims = item_welder._anims
end

function item_welder:use(activator, value)
	self.on = not self.on

	if (self.on) then
		self.anims.on:play()
	end
end

function item_welder:draw()
	entity.draw(self)

	item_welder._sprite:setAnimation(self.anims.welder)
	item_welder._sprite:draw()

	if (self.anims.fuel) then
		local ratio = self.fuel / self.maxFuel
		local step = math.ceil(ratio * 4) * 25
		item_welder._sprite:setAnimation(self.anims.fuel[tostring(step)])
		item_welder._sprite:draw()
	end

	if (self.on) then
		item_welder._sprite:setAnimation(self.anims.on)
		item_welder._sprite:draw()
	end
end

function item_welder:update(dt)
	item_welder._sprite:update(dt)
end

entities.linkToClassname( item_welder, "item_welder" )
