require( "engine.client.sprite" )
require( "game.shared.access" )
require( "game.shared.construction" )
entities.require("door")

class "door_airlock" ("door")
entities.linkToClassname(door_airlock, "door_airlock")

local airlock = door_airlock

function airlock:door_airlock()
	door.door(self)

	self.sounds.closing = "sounds/airlock_close"
	self.sounds.opening = "sounds/airlock_open"

	self.skin = nil
	self.fillType = nil

	self.maint_panel_open = false
end

function airlock:setProperties(properties)
	door.setProperties(self, properties)

	local skin, fillType
	for key, value in pairs(properties) do
		if (_CLIENT) then
			if (key == "skin") then
				skin = value
			elseif (key == "fillType") then
				fillType = value
			end
		end
	end

	assert(skin, "Airlocks must have a skin")
	self.animPrefix = skin .. '.'

	fillType = (fillType == skin and skin) or ((fillType == "glass" or fillType == "glass2") and fillType) or nil
	local spr = sprite("images.entities.airlocks")
	spr:setFilter("nearest", "nearest")
	self:setSprite(spr)

	if (fillType) then
		self.fillType = fillType
		self.fillSprite = sprite("images.entities.airlock_fill")
		self.fillSprite:setFilter("nearest", "nearest")
	end

	-- Not useful in production and will "error" for airlock skins that dont have a fill like vault and highsecurity.
	-- This is mostly so I know if I missed setting the fill on a skin that needs it
	if (_DEBUG and not fillType) then
		local pos = self:getPosition()
		print(string.format("Airlock missing fill type (%s) at %i, %i", skin, pos.x, pos.y))
	end
end

function airlock:draw()
	entity.draw(self)

	if (type(self.fillSprite) == "sprite") then
		self.fillSprite:draw()
	end
end

function airlock:update(dt)
	entity.update(self, dt)

	if (_CLIENT and type(self.fillSprite) == "sprite") then
		self.fillSprite:update(dt)
	end
end

construction.register("door_airlock", {
	-- TODO shielding
	item_screwdriver = {
		onActivate = function(ent, act)
			-- TODO check if the door has been detonated
			ent.maint_panel_open = not ent.maint_panel_open
			-- TODO [opt] send player a message telling them they opened/closed the maintenance maint_panel_open
			-- TODO play tool sound
			-- TODO update icon
		end
	}
	-- TODO (wirecutters && note)
	-- TODO (wirecutters or multitool)
	-- TODO pAI cable
	-- TODO airlock painter
	-- TODO door charge
	-- TODO (paper or photo)
})
