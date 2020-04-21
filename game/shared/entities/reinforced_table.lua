entities.require("entity")

class "reinforced_table" ("entity")

function reinforced_table:reinforced_table()
	entity.entity(self)

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

entities.linkToClassname(reinforced_table, "reinforced_table")