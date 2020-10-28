entities.require("item")

class "item_crowbar" ("item")

item_crowbar.crowbarSprite = sprite("images.entities.crowbar")
item_crowbar.crowbarSprite:setFilter("nearest", "nearest")

function item_crowbar:item_crowbar()
	item.item(self)

	self.useTime = 4
	self.anim = "crowbar"
end

function item_crowbar:draw()
	entity.draw(self)

	item_crowbar.crowbarSprite:setAnimation(self.anim)
	item_crowbar.crowbarSprite:draw()
end

entities.linkToClassname( item_crowbar, "item_crowbar" )
