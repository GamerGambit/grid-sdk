entities.require("structure")

class "structure_reinforced_wall" ("structure")

entities.linkToClassname(structure_reinforced_wall, "structure_reinforced_wall")

local reinforced_wall = structure_reinforced_wall

function reinforced_wall:structure_reinforced_wall()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_wall.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function reinforced_wall:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
