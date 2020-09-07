require( "engine.client.sprite" )
entities.require("structure")

class "structure.girder" ("structure")
entities.linkToClassname(structure.girder, "structure.girder")

local girder = structure.girder

girder.state = {
	normal = 0,
	displaced = 1,
	reinforced = 2
}

function girder:girder()
	structure.structure(self)

	if (_CLIENT) then
		local sprite =sprite("images.entities.girder")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
		self:setState(girder.state.normal)
	end
end

function girder:setProperties(properties)
	for k,v in pairs(properties) do
		if (k == "state") then
			assert(type(girder.state[v]) == "number")
			self:setState(v)
		end
	end
end

function girder:setState(state)
	assert(type(girder.state[state]) == "number" or table.hasvalue(girder.state, state))
	if (state == self.state) then return end

	self.state = girder.state[state] or state

	local body = self:getBody()
	if (body) then
		if (self.state == girder.state.displaced) then
			body:setType("dynamic")
		else
			body:setType("static")
		end
	end

	self:setAnimation(state)
end

function girder:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics()
	self:setCollisionBounds( min, max )
end
