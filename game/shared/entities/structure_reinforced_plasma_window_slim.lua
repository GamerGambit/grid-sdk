entities.require("structure")

class "structure_reinforced_plasma_window_slim" ("structure")

entities.linkToClassname(structure_reinforced_plasma_window_slim, "structure_reinforced_plasma_window_slim")

local reinforced_plasma_window_slim = structure_reinforced_plasma_window_slim

function reinforced_plasma_window_slim:structure_reinforced_plasma_window_slim()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_plasma_window_slim.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function reinforced_plasma_window_slim:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -7 )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
