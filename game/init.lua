require( "engine.shared.hook" )

local game        = game or {}
_G.game           = game

local hook        = hook
local _G          = _G
local love        = love
local math        = math

module( "game" )

tileSize   = 32
initialMap = "box"

local start = love.timer.getTime()
function curtime()
	return math.floor(love.timer.getTime() - start)
end

function call( universe, event, ... )
	local interface = game[ universe ]
	if ( universe == "shared" ) then
		interface = game
	end

	local values = { hook.call( universe, event, ... ) }
	if ( #values > 0 ) then
		return unpack( values )
	end

	return interface[ event ]( ... )
end

function onPlayerConnect( player )
	if ( _SERVER ) then
		_G.player.sendTextAll( player:getName() .. " has joined the game." )
	end
end

function onPlayerDisconnect( player )
end

function onPlayerInitialSpawn( player )
end

function onPlayerSpawn( player )
end

function onReloadScript( modname )
end
