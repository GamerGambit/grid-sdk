entities.require("structure")

class "structure_reinforced_table" ("structure")

entities.linkToClassname(structure_reinforced_table, "structure_reinforced_table")

local reinforced_table = structure_reinforced_table

function reinforced_table:structure_reinforced_table()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_table.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
