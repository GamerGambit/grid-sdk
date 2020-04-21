entities.require("entity")

-- due to the way the class system works, I cant name this "table"
-- otherwise it will be merged with the Lua table library and break

class "nonlua_table" ("entity")

function nonlua_table:nonlua_table()
	entity.entity(self)

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

entities.linkToClassname(nonlua_table, "nonlua_table")