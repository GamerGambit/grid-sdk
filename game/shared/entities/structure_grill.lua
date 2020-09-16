entities.require("structure")

class "structure_grill" ("structure")

entities.linkToClassname(structure_grill, "structure_grill")

local grill = structure_grill

function grill:structure_grill()
	structure.structure(self)

	self:setAnimation("grill")
end
