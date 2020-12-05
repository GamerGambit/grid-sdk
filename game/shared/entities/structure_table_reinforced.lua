entities.require("structure_table")

class "structure_table_reinforced" ("structure_table")

entities.linkToClassname(structure_table_reinforced, "structure_table_reinforced")

local reinforced_table = structure_table_reinforced

function reinforced_table:structure_table_reinforced()
	structure_table.structure_table(self)

	self:setTableType("reinforced")
	self.destruction_ready = false
end

construction.register("structure_table_reinforced", {
	item_welder = {
		onActivate = function(ent, act, item)
			-- TODO make sure theres enough fuel in the welder to proceed

			if (ent.destruction_ready) then
				-- TODO use tool
				-- TODO maybe send a message to the player telling them they are strengthening the reinforced table
				ent.destruction_ready = false
			else
				-- TODO use tool
				-- TODO maybe send a message to the player telling them they are weakening the reinforced table
				ent.destruction_ready = true
			end
		end
	}
})
