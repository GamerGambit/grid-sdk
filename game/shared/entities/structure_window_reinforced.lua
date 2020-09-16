entities.require("structure_window")

class "structure_window_reinforced" ("structure_window")

entities.linkToClassname(structure_window_reinforced, "structure_window_reinforced")

local reinforced_window = structure_window_reinforced

function reinforced_window:structure_window_reinforced()
	structure_window.structure_window(self)

	self:setWindowType("reinforced")
end
