entities.require("structure")

class "structure_reinforced_window" ("structure")

entities.linkToClassname(structure_reinforced_window, "structure_reinforced_window")

local reinforced_window = structure_reinforced_window

function reinforced_window:structure_reinforced_window()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_window.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
