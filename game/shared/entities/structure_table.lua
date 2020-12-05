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
	self.deconstruction_ready = true
end

function nonlua_table:setTableType(tableType)
	assert(table.hasvalue(structure_table.types, tableType), string.format("Invalid table type %q", tostring(tableType)))
	self.tableType = tableType
	self:setAnimation(string.format("table_%s", tableType))
end

function nonlua_table:use(activator, value)
	structure.use(self, activator, value)

	-- TODO handle placing active hand item on table where the user clicked
end

construction.register("structure_table", {
	item_screwdriver = {
		predicate = function(ent, act, item) return ent.deconstruction_ready end,
		onActivate = function(ent, act, item)
			-- TODO use tool
			-- TODO spawn sheet stack
			-- TODO spawn table frame
			ent:remove()
		end
	},

	item_wrench = {
		predicate = function(ent, act, item) return ent.deconstruction_ready end,
		onActivate = function(ent, act, item)
			-- TODO use tool
			-- TODO spawn sheet stack
			-- TODO spawn rod stack
			ent:remove()
		end
	},

	item_storage_bag_tray = {
		predicate = function(ent, act, item) return not item.empty end, -- make sure the tray has some stuff on it
		onActivate = function(ent, act, item)
			-- TODO empty the tray onto the table
		end
	}
})
