entities.require("structure_window")

class "structure_window_slim_plasma_reinforced" ("structure_window")

entities.linkToClassname(structure_window_slim_plasma_reinforced, "structure_window_slim_plasma_reinforced")

local reinforced_plasma_window_slim = structure_window_slim_plasma_reinforced

function reinforced_plasma_window_slim:structure_window_slim_plasma_reinforced()
	structure_window.structure_window(self)

	self:setWindowType("slim_plasma_reinforced")
end
