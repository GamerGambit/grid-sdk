entities.require("entity")

class "tinted_window" ("entity")

function tinted_window:tinted_window()
	entity.entity(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/tinted_window.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function tinted_window:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

entities.linkToClassname(tinted_window, "tinted_window")