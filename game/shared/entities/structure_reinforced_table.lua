entities.require("structure")

class "structure_reinforced_table" ("structure")

entities.linkToClassname(structure_reinforced_table, "structure_reinforced_table")

local reinforced_table = structure_reinforced_table

function reinforced_table:structure_reinforced_table()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_table.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function reinforced_table:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
