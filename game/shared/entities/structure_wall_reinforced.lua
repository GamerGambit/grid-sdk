entities.require("structure")

class "structure_wall_reinforced" ("structure")

entities.linkToClassname(structure_wall_reinforced, "structure_wall_reinforced")

local reinforced_wall = structure_wall_reinforced

function reinforced_wall:structure_wall_reinforced()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_wall.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
