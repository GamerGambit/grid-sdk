entities.require("item")

class "item_wrench" ("item")

item_wrench.wrenchSprite = sprite("images.entities.wrench")
item_wrench.wrenchSprite:setFilter("nearest", "nearest")
item_wrench.wrenchSprite:setAnimation("wrench")
-- TODO add brass and medical

function item_wrench:item_wrench()
	item.item(self)

	self.useTime = 4
end

function item_wrench:draw()
	entity.draw(self)

	item_wrench.wrenchSprite:draw()
end

entities.linkToClassname( item_wrench, "item_wrench" )
