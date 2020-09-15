entities.require("structure")

class "structure_table" ("structure")

entities.linkToClassname(structure_table, "structure_table")

local nonlua_table = structure_table

function nonlua_table:structure_table()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/table.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
