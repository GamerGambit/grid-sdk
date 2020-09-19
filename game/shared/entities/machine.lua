entities.require("entity")

class "machine" ("entity")

function machine:machine()
	entity.entity(self)
end

function machine:use(activator, value)
	-- return true so derived classes can check if this handles the call
	if (construction.check(self, activator)) then return true end
end

function machine:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
