entities.require("entity")

class "wooden_table" ("entity")

function wooden_table:wooden_table()
	entity.entity(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/wooden_table.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function wooden_table:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(wooden_table, "wooden_table")