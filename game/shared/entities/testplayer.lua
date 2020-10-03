entities.require("player")

require("game.shared.access")

class "testplayer" ("player")

function testplayer:testplayer()
	player.player(self)
	self:networkNumber( "moveSpeed", ( 32 * 10 ) / 3 )
end

function testplayer:getAccess()
	-- TODO replace this with and ID slot lookup (for PDA/ID card), followed by the item in the active hand
	if (not self.access) then
		self.access = access()
		self.access.list = access.getAllHabitat() -- give all access
	end

	return self.access
end

function testplayer:spawn()
	player.spawn(self)

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize * 0.33, -tileSize * 0.8 )
	self:setCollisionBounds( min, max )
end

-- TODO remove this for prod
TESTPLAYER_ACTIVEHAND_ITEMNAME = "item_screwdriver"
function testplayer:getActiveHand()
	return { getItem = function() return setmetatable({}, { __type = TESTPLAYER_ACTIVEHAND_ITEMNAME }) end }
end

entities.linkToClassname(testplayer, "testplayer")

local t = {}
local pointinrect = math.pointinrect
local getEntitiesAtMousePos = function( px, py )
	table.clear( t )

	local entities = entity.getAll()
	table.foreachi( entities, function( _, entity )
		if ( typeof( entity, "trigger" ) or not entity.sprite) then
			return
		end

		local x, y   = camera.worldToScreen( entity:getDrawPosition() )
		local sprite = entity:getSprite()
		local scale  = camera.getZoom()
		if ( sprite == nil ) then
			return
		end

		local width  = sprite:getWidth()  * scale
		local height = sprite:getHeight() * scale
		if ( pointinrect( px, py, x, y, width, height ) ) then
			table.insert( t, entity )
		end
	end )
	return t
end

concommand( "game.click", "Click stuff", function( _, player )
	if (not _CLIENT) then return end

	local mx, my = love.mouse.getPosition()
	local payload = payload("playerUse")
	-- TODO sort `found` by z-order and only select the top one
	for _, ent in ipairs(getEntitiesAtMousePos(mx, my)) do
		payload:set("entity", ent)
		payload:sendToServer()
	end
end)
