entities.require("structure")

class "structure.wooden_table" ("structure")

entities.linkToClassname(structure.wooden_table, "structure.wooden_table")

local wooden_table = structure.wooden_table

function wooden_table:wooden_table()
	structure.structure(self)

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
