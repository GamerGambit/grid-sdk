local _G = _G
local require = require

module( "game.server" )

function getPlayerClass()
	local entities = _G.entities
	entities.require( "testplayer" )

	local classmap = entities.getClassMap()
	return classmap[ "testplayer" ]
end

function getSpawnPoint( player )
	-- Find the first `prop_worldgate_spawn` in the player's current map
	local map         = player:getMap()
	local entity      = _G.entity
	local spawnPoints = entity.findByClassname( "player_spawn", map )
	return spawnPoints and spawnPoints[ 1 ] or nil
end

function load( arg )
	require "game.shared"
end

function onPlayerConnect( player )
end

function onPlayerSay( player, message )
	return true
end

function onPlayerUse( player, entity, value )
	return true
end

function tick( timestep )
end

function shutdown()
end

function update( dt )
end
