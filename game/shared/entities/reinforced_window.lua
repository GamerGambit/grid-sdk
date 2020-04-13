entities.require("entity")

class "reinforced_window" ("entity")

function reinforced_window:reinforced_window()
	entity.entity(self)

	if (_CLIENT) then
		local filename = "images/entities/reinforced_window.png"
		local sprite = love.graphics.newImage(filename)
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function reinforced_window:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(reinforced_window, "reinforced_window")