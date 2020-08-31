entities.require("structure")

class "structure.grill" ("structure")

entities.linkToClassname(structure.grill, "structure.grill")

local grill = structure.grill

function grill:grill()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/grill.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function grill:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
