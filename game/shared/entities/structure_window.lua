entities.require("structure")

class "structure_window" ("structure")

entities.linkToClassname(structure_window, "structure_window")

local window = structure_window

function window:structure_window()
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
