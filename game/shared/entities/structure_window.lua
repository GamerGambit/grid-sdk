entities.require("structure")

class "structure_window" ("structure")

entities.linkToClassname(structure_window, "structure_window")

local window = structure_window

window.types = {
	"glass",
	"reinforced",
	"plasma_reinforced",
	"slim_plasma_reinforced",
	"tinted"
}

accessor(structure_window, "windowType")

function window:structure_window()
	structure.structure(self)

	self:setWindowType("glass")
end

function window:setWindowType(windowType)
	assert(table.hasvalue(window.types, windowType), string.format("Invalid window type %q", windowType))

	self.windowType = windowType
	self:setAnimation(string.format("window_%s", windowType))
end
