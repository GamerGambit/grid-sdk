entities.require("structure")

class "structure_tinted_window" ("structure")

entities.linkToClassname(structure_tinted_window, "structure_tinted_window")

local tinted_window = structure_tinted_window

function tinted_window:structure_tinted_window()
	structure.structure(self)

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
