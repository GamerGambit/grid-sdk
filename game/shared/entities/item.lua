entities.require("entity")

class "item" ("entity")

function item:item()
	entity.entity(self)
end

function item:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )

	local body = self:getBody()
	if (not body) then return end

	local fixtures = body:getFixtures()
	local fixture = fixtures[1]
	if (not fixture) then return end

	-- This makes all items have physics with no collisions (like open doors)
	-- TODO this needs to be fixed so that items can be thrown at players and other objects and inflict damage
	fixture:setFilterData(1, 0, 0)
end
