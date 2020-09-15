entities.require("structure")

class "structure_tinted_window" ("structure")

entities.linkToClassname(structure_tinted_window, "structure_tinted_window")

local tinted_window = structure_tinted_window

function tinted_window:structure_tinted_window()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/tinted_window.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
