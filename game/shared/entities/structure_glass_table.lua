entities.require("structure")

class "structure_glass_table" ("structure")

entities.linkToClassname(structure_glass_table, "structure_glass_table")

local glass_table = structure_glass_table

function glass_table:structure_glass_table()
	structure.structure(self)

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
