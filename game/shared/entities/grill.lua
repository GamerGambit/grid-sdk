entities.require("entity")

class "grill" ("entity")

function grill:grill()
	entity.entity(self)

	if (_CLIENT) then
		local filename = "images/entities/grill.png"
		local sprite = love.graphics.newImage(filename)
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function grill:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(grill, "grill")