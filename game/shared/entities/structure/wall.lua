entities.require("structure")

class "structure.wall" ("structure")

entities.linkToClassname(structure.wall, "structure.wall")

local wall = structure.wall

function wall:wall()
	structure.structure(self)

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
