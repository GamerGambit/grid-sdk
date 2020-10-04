entities.require("machine")

class "door" ("machine")

local setPhysics = function(airlock, bool)
	local body = airlock:getBody()
	if (not body) then return end

	local fixtures = body:getFixtures()
	local fixture = fixtures[1]
	if (not fixture) then return end

	fixture:setFilterData(1, (bool and 65535) or 0, (bool and 1) or 0)
end

local setAnimation = function(airlock, animName)
	local prefix = airlock.animPrefix or ""
	airlock:setAnimation(prefix .. animName)

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

function door:door()
	machine.machine(self)

	self.state = states.closed
	self.openTime = 0
	self.autoCloseTime = 3
	self.animPrefix = ""

	self.required_access = {}     -- all access listed is required
	self.required_one_access = {} -- a single access listed is required

	self.sounds = {
		opening = nil,
		open = nil,
		closing = nil,
		closed = nil
	}
end

function door:tryOpen(activator)
	if (not self:canAccess(activator)) then return end

	self:open()
end

function door:open()
	if (self.state ~= states.closed) then return end
	setAnimation(self, "opening")
	self.state = states.opening

	if (self.sounds.opening) then
		self:emitSound(self.sounds.opening)
	end

	self.nextThink = 0
end

function door:tryClose(activator)
	if (not self:canAccess(activator)) then return end

	self:close()
end

function door:close()
	if (self.state ~= states.open) then return end
	setAnimation(self, "closing")
	setPhysics(self, true)
	self.state = states.closing
	self.openTime = 0

	if (self.sounds.closing) then
		self:emitSound(self.sounds.closing)
	end
end

function door:canAccess(activator)
	if (#self.required_access > 0 or #self.required_one_access  > 0) then
		if (type(activator.getAccess) ~= "function") then return false end -- Not entirely sure what entities would be trying to open doors that dont have an access function?
		local a = activator:getAccess()
		if (not a:canAccess(self.required_access, self.required_one_access)) then return false end
	end

	return true
end

function door:startTouch(other, contact)
	-- TODO this function obviously does not allow non-players to open doors.
	-- valid door openers are the MULEbot, beepsky, and other AI.
	if (not typeof(other, "player")) then return end
	self:tryOpen(other)
end

function door:onAnimationEnd( animation )
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

function door:use(activator, value)
	if (door.use(self, activator, value)) then return end

	if (self.state == states.open) then
		self:tryClose()
	elseif (self.state == states.closed) then
		self:tryOpen()
	end
end

function door:think()
	if (self.autoCloseTime and self.autoCloseTime > 0 and self.openTime > 0 and game.curtime() >= self.openTime + self.autoCloseTime) then
		table.print(self:getBody():getContacts())
		self:close()
		self.nextThink = nil
		return
	end

	self.nextThink = 0
end

function door:spawn()
	machine.spawn(self)

	-- set the animation after so it automatically sets the fillSprite's animation too
	setAnimation(self, "idleclosed")
end

function door:setProperties(properties)
	for k,v in pairs(properties) do
		if (key == "required_access" or key == "required_one_access") then
			local split = string.split(value, ';')

			for i, accessPath in ipairs(split) do
				assert(access.exists(accessPath), string.format("Access type \"%s\" does not exist for entity at %s", accessPath, self:getPosition()))
				table.insert(self[key], accessPath)
			end
		end
	end
end
