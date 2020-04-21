entities.require("entity")

class "glass_table" ("entity")

function glass_table:glass_table()
	entity.entity(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/glass_table.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function glass_table:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(glass_table, "glass_table")