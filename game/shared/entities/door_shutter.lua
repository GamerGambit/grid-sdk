entities.require("door")

class "door_shutter" ("door")
entities.linkToClassname(door_shutter, "door_shutter")

function door_shutter:door_shutter()
	door.door(self)

	self.startOpen = false

	if (_CLIENT) then
		local spr = sprite("images.entities.door_shutter")
		spr:setFilter("nearest", "nearest")
		self:setSprite(spr)
	end
end

function door_shutter:setProperties(properties)
	door.setProperties(self, properties)

	self.startOpen = toboolean(properties["startOpen"])
end

function door_shutter:spawn()
	door.spawn(self)

	if (self.startOpen) then
		self:setAnimation("idleopen")
	end
end