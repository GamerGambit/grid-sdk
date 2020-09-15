entities.require("structure")

class "structure_window" ("structure")

entities.linkToClassname(structure_window, "structure_window")

local window = structure_window

function window:structure_window()
	structure.structure(self)

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/window.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end
