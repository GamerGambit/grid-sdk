entities.require("item")

class "item_wirecutters" ("item")

item_wirecutters.handleColors = {
		blue = color(24, 97, 213, 255),
		red = color(149, 23, 16, 255),
		pink = color(213, 24, 141, 255),
		brown = color(160, 82, 18, 255),
		green = color(14, 127, 27, 255),
		cyan = color(24, 162, 213, 255),
		yellow = color(213, 140, 24, 255)
}

item_wirecutters.handleSprite = sprite("images.entities.wirecutters")
item_wirecutters.handleSprite:setFilter("nearest", "nearest")
item_wirecutters.handleSprite:setAnimation("handle")
item_wirecutters.bitsSprite = sprite("images.entities.wirecutters")
item_wirecutters.bitsSprite:setFilter("nearest", "nearest")
item_wirecutters.bitsSprite:setAnimation("bits")
-- TODO add brass

function item_wirecutters:item_wirecutters()
	item.item(self)

	self.useTime = 4
	self.colorKey = table.randomKey(item_wirecutters.handleColors)
end

function item_wirecutters:draw()
	entity.draw(self)

	item_wirecutters.bitsSprite:draw()

	local col = item_wirecutters.handleColors[self.colorKey]
	love.graphics.setColor(col)

	item_wirecutters.handleSprite:draw()
end

entities.linkToClassname( item_wirecutters, "item_wirecutters" )
