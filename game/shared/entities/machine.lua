entities.require("entity")

class "machine" ("entity")

function machine:machine()
	entity.entity(self)
end

function machine:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
