entities.require("structure_window")

class "structure_window_tinted" ("structure_window")

entities.linkToClassname(structure_window_tinted, "structure_window_tinted")

local tinted_window = structure_window_tinted

function tinted_window:structure_window_tinted()
	structure_window.structure_window(self)

	self:setWindowType("tinted")
end
