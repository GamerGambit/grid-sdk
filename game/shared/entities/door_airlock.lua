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

	local skin = properties["skin"]
	local fillType = properties["fillType"]

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

function airlock:startTouch(other, contact)
	-- TODO this function obviously does not allow non-players to open doors.
	-- valid door openers are the MULEbot, beepsky, and other AI.
	if (not typeof(other, "player")) then return end
	self:tryOpen(other)
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
		onActivate = function(ent, act, item)
			-- TODO check if the door has been detonated
			ent.maint_panel_open = not ent.maint_panel_open
			-- TODO [opt] send player a message telling them they opened/closed the maintenance maint_panel_open
			-- TODO play tool sound
			-- TODO update icon
		end
	},

	{
		items = { "item_wirecutters", "item_multitool", "item_device_assembly" },
		recipe = {
			onActivate = function(ent, act, item)
				if (typeof(item, "item_wirecutters") and ent.note) then
					-- TODO remove note
					return
				end

				-- TODO pop up wiring UI
			end
		}
	},

	item_pai_cable = {
		onActivate = function(ent, act, item)
			-- TODO plugin the pAI cable
		end
	},

	item_airlock_painter = {
		onActivate = function(ent, act, item)
			-- TODO set the paint job of the airlock to the one configured on the airlock painter
		end
	},

	item_door_charge = {
		onActivate = function(ent, act, item)
			if (not ent.maint_panel_open) then -- TODO "or wires are shielded"
				-- TODO maybe send the player a message letting them know the maint panel needs to be open and any shielding removed
				return
			end

			-- TODO
			--if (bit.band(ent.obj_flags, EMAGGED) == EMAGGED) then return end

			-- TODO initialize and rename `ent.charge` and `ent.detonated` to be more descriptive

			if (ent.charge and not ent.detonated) then
				-- TODO maybe send the player a message telling them theres already a door charge on the airlock
				return
			end

			if (ent.detonated) then
				-- TODO maybe send the player a message telling them that the maint panel is destroyed
				return
			end

			ent.maint_panel_open = false
			ent.charge = item
			-- TODO remove charge from `act`
		end
	},

	{
		items = { "item_paper", "item_photo" },
		recipe = {
			onActivate = function(ent, act, item)
				if (ent.note) then
					-- TODO maybe send the player a message telling them that there is already a note/photo/document on the door and to use wirecutters to remove it
					return
				end

				ent.note = item
				-- TODO remove `item` from `act`
			end
		}
	}
})
