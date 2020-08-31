entities.require("structure")

class "structure.table" ("structure")

entities.linkToClassname(structure.table, "structure.table")

local nonlua_table = structure.table

function nonlua_table:table()
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
