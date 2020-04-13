entities.require("entity")

class "reinforced_wall" ("entity")

function reinforced_wall:reinforced_wall()
	entity.entity(self)

	if (_CLIENT) then
		local filename = "images/entities/reinforced_wall.png"
		local sprite = love.graphics.newImage(filename)
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function reinforced_wall:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(reinforced_wall, "reinforced_wall")