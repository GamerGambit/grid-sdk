entities.require("structure")

class "structure_wall" ("structure")

entities.linkToClassname(structure_wall, "structure_wall")

local wall = structure_wall

function wall:structure_wall()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/wall.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
