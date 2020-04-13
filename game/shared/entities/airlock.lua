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
	self.nextThink = 0
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
	if (animation == "close") then
		self:setAnimation("idleclosed")
		self.state = states.closed
	elseif (animation == "open") then
		self:setAnimation("idleopen")
		setPhysics(self, false)
		self.state = states.open
		self.openTime = game.curtime()
	end
end

function airlock:startTouch( other, contact )
	if (not typeof(other, "player")) then return end
	self:toggle()
end

function airlock:think()
	if (self.openTime > 0 and game.curtime() >= self.openTime + self.autoCloseTime) then
		self:close()
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

	fillType = (fillType == "solid" and skin) or (fillType == "glass" and "glass") or nil
	if (skin) then
		require( "engine.client.sprite" )
		local spr = sprite("images.entities.airlocks." .. skin)
		spr:setFilter("nearest", "nearest")
		self:setSprite(spr)

		if (fillType) then
			self.fillSprite = sprite("images.entities.airlocks.fill." .. fillType)
			self.fillSprite:setFilter("nearest", "nearest")
		end

		-- set the animation after so it automatically sets the fillSprite's animation too
		self:setAnimation("idleclosed")
	end

	if (not skin or not fillType) then
		local x, y = self:getDrawPosition()
		print(string.format("Invalid airlock at %i, %i", x, y))
	end
end

function airlock:draw()
	entity.draw(self)

	if (type(self.fillSprite) == "sprite") then
		self.fillSprite:draw()
	end
end

function airlock:setAnimation(animation)
	entity.setAnimation(self, animation)

	if (type(self.fillSprite) == "sprite") then
		self.fillSprite:setAnimation(animation)
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
	self:setAnimation("open")
	self.state = states.opening
	self:emitSound("sounds/airlock_open")
end

function airlock:close()
	if (self.state ~= states.open) then return end
	self:setAnimation("close")
	setPhysics(self, true)
	self.state = states.closing
	self.openTime = 0
	self:emitSound("sounds/airlock_close")
end

entities.linkToClassname(airlock, "airlock")