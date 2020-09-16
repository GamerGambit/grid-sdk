entities.require("structure_table")

class "structure_table_wood" ("structure_table")

entities.linkToClassname(structure_table_wood, "structure_table_wood")

local wooden_table = structure_table_wood

function wooden_table:structure_table_wood()
	structure_table.structure_table(self)

	self:setTableType("wood")
end
