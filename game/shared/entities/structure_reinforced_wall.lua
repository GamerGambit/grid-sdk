entities.require("structure")

class "structure_reinforced_wall" ("structure")

entities.linkToClassname(structure_reinforced_wall, "structure_reinforced_wall")

local reinforced_wall = structure_reinforced_wall

function reinforced_wall:structure_reinforced_wall()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_wall.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
