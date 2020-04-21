require( "engine.client.sprite" )

entities.require("entity")

class "airlock" ("entity")

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

function airlock:airlock()
	entity.entity(self)

	self.state = states.closed
	self.openTime = 0
	self.autoCloseTime = 3
	self.skin = nil
	self.fillType = nil
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
	self:toggle()
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
	self:open()
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

function airlock:toggle()
	local curAnim = self:getAnimation()

	if (curAnim == "idleopen") then
		self:close()
	elseif (curAnim == "idleclosed") then
		self:open()
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

entities.linkToClassname(airlock, "airlock")