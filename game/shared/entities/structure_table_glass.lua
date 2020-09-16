entities.require("structure_table")

class "structure_table_glass" ("structure_table")

entities.linkToClassname(structure_table_glass, "structure_table_glass")

local glass_table = structure_table_glass

function glass_table:structure_table_glass()
	structure_table.structure_table(self)

	self:setTableType("glass")
end
