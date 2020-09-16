require( "engine.client.sprite" )
entities.require("structure")

class "structure_table" ("structure")

entities.linkToClassname(structure_table, "structure_table")

local nonlua_table = structure_table

nonlua_table.types = {
	"metal",
	"glass",
	"poker",
	"reinforced",
	"wood"
}

accessor(structure_table, "tableType")

function nonlua_table:structure_table()
	structure.structure(self)

	self:setTableType("metal")
end

function nonlua_table:setTableType(tableType)
	assert(table.hasvalue(structure_table.types, tableType), string.format("Invalid table type %q", tostring(tableType)))
	self.tableType = tableType
	self:setAnimation(string.format("table_%s", tableType))
end
