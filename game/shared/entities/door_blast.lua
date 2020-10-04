entities.require("door")

class "door_blast" ("door")
entities.linkToClassname(door_blast, "door_blast")

function door_blast:door_blast()
	door.door(self)

	self.startOpen = false

	if (_CLIENT) then
		local spr = sprite("images.entities.door_blast")
		spr:setFilter("nearest", "nearest")
		self:setSprite(spr)
	end
end

function door_blast:setProperties(properties)
	door.setProperties(self, properties)

	for k,v in pairs(properties) do
		if (k == "startOpen") then
			self.startOpen = toboolean(v)
		end
	end
end

function door_blast:spawn()
	door.spawn(self)

	if (self.startOpen) then
		self:open()
	end
end