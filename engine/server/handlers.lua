--=========== Copyright © 2019, Planimeter, All rights reserved. ===========--
--
-- Purpose: Engine server handlers
--
--==========================================================================--

local debug     = debug
local engine    = engine
local ipairs    = ipairs
local love      = love
local pcall     = pcall
local print     = print
local require   = require
local tostring  = tostring
local unrequire = unrequire
local _G        = _G

module( "engine.server" )

function load( arg )
	require( "engine.server.network" )

	local network = engine.server.network
	local initialized = network.initializeServer()
	if ( not initialized ) then
		return false
	end

	_G._SERVER = true

	require( "game" )
	require( "game.server" )

	local game = _G.game.server
	local status, ret = pcall(game.load, arg )
	if (not status) then print(ret) end

	return true
end

function quit()
	-- Shutdown game
	local game = _G.game and _G.game.server or nil
	if ( game ) then
		local status, ret = pcall(game.shutdown)
		if (not status) then print(ret) end

		unrequire( "game.server" )
		_G.game.server = nil
	end

	unrequire( "game" )
	_G.game = nil

	-- Shutdown server
	local network = engine.server.network
	network.shutdownServer()

	unrequire( "engine.server.network" )
	engine.server.network = nil
	unrequire( "engine.server.payloads" )
	unrequire( "engine.server.handlers" )

	_G._SERVER = nil
end

function update( dt )
	local game   = _G.game and _G.game.server or nil
	local entity = _G.entity

	if ( game ) then
		local status, ret = pcall(game.update, dt )
		if (not status) then print(ret) end

		if ( entity ) then
			local entities = entity.getAll()
			for _, entity in ipairs( entities ) do
				local status, ret = pcall(entity.update, entity, dt )
				if (not status) then print(ret) end
			end
		end
	end

	local network = engine.server.network
	if ( network ) then
		network.update( dt )
	end
end

local function error_printer(msg, layer)
	print((debug.traceback("Error: " ..
	       tostring(msg), 1+(layer or 1)):gsub("\n[^\n]+$", "")))
end

function errhand(msg)
	msg = tostring(msg)

	error_printer(msg, 2)

end
