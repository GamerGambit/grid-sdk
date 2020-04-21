entities.require("entity")

class "reinforced_plasma_window" ("entity")

function reinforced_plasma_window:reinforced_plasma_window()
	entity.entity(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_plasma_window.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function reinforced_plasma_window:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(reinforced_plasma_window, "reinforced_plasma_window")