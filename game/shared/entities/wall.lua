entities.require("entity")

class "wall" ("entity")

function wall:wall()
	entity.entity(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/wall.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function wall:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(wall, "wall")