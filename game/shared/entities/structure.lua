entities.require("entity")

class "structure" ("entity")

function structure:structure()
	entity.entity(self)

	if (_CLIENT) then
		local sprite = sprite("images.obj.structures")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function structure:use(activator, value)
	-- return true so derived classes can check if this handles the call
	if (construction.check(self, activator)) then return true end
end

function structure:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end