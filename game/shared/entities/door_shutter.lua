entities.require("door")

class "door_shutter" ("door")
entities.linkToClassname(door_shutter, "door_shutter")

function door_shutter:door_shutter()
	door.door(self)

	if (_CLIENT) then
		local spr = sprite("images.entities.door_shutter")
		spr:setFilter("nearest", "nearest")
		self:setSprite(spr)
	end
end