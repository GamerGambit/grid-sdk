entities.require("structure")

class "structure.window" ("structure")

entities.linkToClassname(structure.window, "structure.window")

local window = structure.window

function window:window()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/window.png")
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
