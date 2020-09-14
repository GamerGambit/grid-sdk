entities.require("structure")

class "structure_table" ("structure")

entities.linkToClassname(structure_table, "structure_table")

local nonlua_table = structure_table

function nonlua_table:structure_table()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/table.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function nonlua_table:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
