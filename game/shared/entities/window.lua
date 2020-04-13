entities.require("entity")

class "window" ("entity")

function window:window()
	entity.entity(self)

	if (_CLIENT) then
		local filename = "images/entities/window.png"
		local sprite = love.graphics.newImage(filename)
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function window:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(window, "window")