entities.require("item")

class "item_screwdriver" ("item")

item_screwdriver.handleColors = {
		blue = color(24, 97, 213, 255),
		red = color(255, 0, 0, 255),
		pink = color(213, 24, 141, 255),
		brown = color(160, 82, 18, 255),
		green = color(14, 127, 27, 255),
		cyan = color(24, 162, 213, 255),
		yellow = color(255, 165, 0, 255)
}

item_screwdriver.handleSprite = sprite("images.entities.screwdriver")
item_screwdriver.handleSprite:setFilter("nearest", "nearest")
item_screwdriver.handleSprite:setAnimation("handle")
item_screwdriver.bitsSprite = sprite("images.entities.screwdriver")
item_screwdriver.bitsSprite:setFilter("nearest", "nearest")
item_screwdriver.bitsSprite:setAnimation("bits")
-- TODO add brass

function item_screwdriver:item_screwdriver()
	item.item(self)

	self.useTime = 4
	self.colorKey = table.randomKey(item_screwdriver.handleColors)
end

function item_screwdriver:draw()
	entity.draw(self)

	item_screwdriver.bitsSprite:draw()

	local col = item_screwdriver.handleColors[self.colorKey]
	love.graphics.setColor(col)

	item_screwdriver.handleSprite:draw()
end


entities.linkToClassname( item_screwdriver, "item_screwdriver" )
