entities.require("structure")

class "structure.reinforced_window" ("structure")

entities.linkToClassname(structure.reinforced_window, "structure.reinforced_window")

local reinforced_window = structure.reinforced_window

function reinforced_window:reinforced_window()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_window.png")
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
