entities.require("entity")

class "structure" ("entity")

function structure:structure()
	entity.entity(self)
end

function structure:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end