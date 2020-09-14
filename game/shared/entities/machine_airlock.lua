require( "engine.client.sprite" )
require( "game.shared.access" )
entities.require("machine")

class "machine_airlock" ("machine")
entities.linkToClassname(machine_airlock, "machine_airlock")

local airlock = machine_airlock

local setPhysics = function(airlock, bool)
	local body = airlock:getBody()
	if (not body) then return end

	local fixtures = body:getFixtures()
	local fixture = fixtures[1]
	if (not fixture) then return end

	fixture:setFilterData(1, (bool and 65535) or 0, (bool and 1) or 0)
end

local setAnimation = function(airlock, animName)
	if (not airlock.skin) then return end

	airlock:setAnimation(airlock.skin .. '.' .. animName)

	if (_CLIENT and airlock.fillType) then
		airlock.fillSprite:setAnimation(airlock.fillType .. '.' .. animName)
	end
end

local states = {
	open = 1,
	closed = 2,
	opening = 3,
	closing = 4
}

function airlock:machine_airlock()
	machine.machine(self)

	self.state = states.closed
	self.openTime = 0
	self.autoCloseTime = 3
	self.skin = nil
	self.fillType = nil

	self.required_access = {}     -- all access listed is required
	self.required_one_access = {} -- a single access listed is required
end

function airlock:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end

function airlock:use(activator, value)
	if (#self.required_access > 0 or #self.required_one_access  > 0) then
		if (type(activator.getAccess) ~= "function") then return end -- Not entirely sure what entities would be trying to open doors that dont have an access function?
		local a = activator:getAccess()
		if (not a:canAccess(self.required_access, self.required_one_access)) then return end
	end

	if (self.state == states.open) then
		self:close()
	elseif (self.state == states.closed) then
		self:open()
	end
end

function airlock:onAnimationEnd( animation )
	if (string.find(animation, "closing")) then
		setAnimation(self, "idleclosed")
		self.state = states.closed
	elseif (string.find(animation, "opening")) then
		setAnimation(self, "idleopen")
		setPhysics(self, false)
		self.state = states.open
		self.openTime = game.curtime()
	end
end

function airlock:startTouch( other, contact )
	if (not typeof(other, "player")) then return end
	self:use(other)
end

function airlock:think()
	if (self.openTime > 0 and game.curtime() >= self.openTime + self.autoCloseTime) then
		table.print(self:getBody():getContacts())
		self:close()
		self.nextThink = nil
		return
	end

	self.nextThink = 0
end

function airlock:setProperties(properties)
	local skin, fillType
	for key, value in pairs(properties) do
		if (_CLIENT) then
			if (key == "skin") then
				skin = value
			elseif (key == "fillType") then
				fillType = value
			end
		end

		if (key == "required_access" or key == "required_one_access") then
			local split = string.split(value, ';')

			for i, accessPath in ipairs(split) do
				assert(access.exists(accessPath), string.format("Access type \"%s\" does not exist for entity at %s", accessPath, self:getPosition()))
				table.insert(self[key], accessPath)
			end
		end
	end

	assert(skin, "Airlocks must have a skin")
	self.skin = skin

	fillType = (fillType == skin and skin) or ((fillType == "glass" or fillType == "glass2") and fillType) or nil
	local spr = sprite("images.entities.airlocks")
	spr:setFilter("nearest", "nearest")
	self:setSprite(spr)

	if (fillType) then
		self.fillType = fillType
		self.fillSprite = sprite("images.entities.airlock_fill")
		self.fillSprite:setFilter("nearest", "nearest")
	end

	-- set the animation after so it automatically sets the fillSprite's animation too
	setAnimation(self, "idleclosed")

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

function airlock:open()
	if (self.state ~= states.closed) then return end
	setAnimation(self, "opening")
	self.state = states.opening
	self:emitSound("sounds/airlock_open")
	self.nextThink = 0
end

function airlock:close()
	if (self.state ~= states.open) then return end
	setAnimation(self, "closing")
	setPhysics(self, true)
	self.state = states.closing
	self.openTime = 0
	self:emitSound("sounds/airlock_close")
end
