--=========== Copyright © 2019, Planimeter, All rights reserved. ===========--
--
-- Purpose: Engine server interface
--
--==========================================================================--

require( "engine.shared.network.payload" )

local convar   = convar
local engine   = engine
local ipairs   = ipairs
local payload  = payload
local pcall    = pcall
local print    = print
local map      = map
local require  = require
local tostring = tostring
local _CLIENT  = _CLIENT
local _G       = _G

module( "engine.server" )

require( "engine.server.handlers" )
require( "engine.server.payloads" )

function onConnect( event )
	print( tostring( event.peer ) .. " has connected." )
	onPostConnect( event )
end

function onPostConnect( event )
	-- Initialize map
	local mapName = _G.game.initialMap
	require( "engine.shared.map" )
	_G.map.load( mapName )

	-- Initialize player
	require( "engine.shared.entities" )
	_G.entities.require( "player" )
	local player = _G.player.initialize( event.peer )
	player:setMap( _G.map.getByName( mapName ) )

	player:onConnect()

	-- Set spawn point
	local status, ret = pcall(_G.game.server.getSpawnPoint, player )
	if (not status) then print(ret) end

	local spawnPoint = status and ret or nil
	local position = _G.vector.origin + _G.vector( 0, _G.game.tileSize )
	if ( spawnPoint ) then
		position = spawnPoint:getPosition()
	end
	player:setNetworkVar( "position", position )

	-- Send server info
	sendServerInfo( player )
end

function onReceive( event )
	local payload = _G.payload.initializeFromData( event.data )
	payload:setPeer( event.peer )
	payload:dispatchToHandler()
end

function onDisconnect( event )
	local player = _G.player.getByPeer( event.peer )
	if ( player ) then
		player:onDisconnect()
		player:remove()
	end

	print( tostring( event.peer ) .. " has disconnected." )
end

function sendServerInfo( player )
	local payload = payload( "serverInfo" )
	payload:set( "map", _G.game.initialMap )
	player:send( payload )
end

shutdown = quit

function tick( timestep )
	local game   = _G.game and _G.game.server or nil
	local entity = _G.entity
	local map    = _G.map

	if ( game == nil ) then
		return
	end

	local status, ret = pcall(game.tick, timestep )
	if (not status) then print(ret) end

	if ( entity ) then
		local entities = entity.getAll()
		for _, entity in ipairs( entities ) do
			local status, ret = pcall(entity.tick, entity, timestep )
			if (not status) then print(ret) end
		end
	end

	map.tick( timestep )

	if ( entity ) then
		local entities = entity.getAll()
		for _, entity in ipairs( entities ) do
			local status, ret = pcall(entity.onPostWorldUpdate, entity, timestep )
			if (not status) then print(ret) end
		end
	end

	if ( _CLIENT ) then
		engine.client.broadcastVoiceRecording()
	end
end

function upload( filename, peer )
	-- TODO: Split by MTU of less than 1500 bytes.
	local payload = payload( "upload" )
	payload:set( "filename", filename )
	payload:set( "file", love.filesystem.read( filename ) )
	peer:send( payload:serialize() )
end
