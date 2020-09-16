entities.require("structure_table")

class "structure_table_reinforced" ("structure_table")

entities.linkToClassname(structure_table_reinforced, "structure_table_reinforced")

local reinforced_table = structure_table_reinforced

function reinforced_table:structure_table_reinforced()
	structure_table.structure_table(self)

	self:setTableType("reinforced")
end
