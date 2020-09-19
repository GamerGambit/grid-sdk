require( "engine.client.camera" )
require( "game.shared.construction" )

local gui       = gui
local map       = map
local _G        = _G
local require   = require
local construction = construction

local r_draw_position = convar( "r_draw_position", "0", nil, nil,
                                "Draws position" )

module( "game.client" )

function draw()
	if ( not _G.localplayer._initialized ) then
		return
	end

	-- Draw panels to worldspace
	gui.preDrawWorld()

	-- Draw world
	map.drawWorld()
end

function load( arg )
	require "game.shared"
end

function onMainMenuActivate()
end

function onMainMenuClose()
end

function tick( timestep )
end

function shutdown()
	construction.clear()
end

function update( dt )
end
