--=========== Copyright © 2019, Planimeter, All rights reserved. ===========--
--
-- Purpose: NPC class
--
--==========================================================================--

entities.require( "character" )

class "npc" ( "character" )

function npc:npc()
	character.character( self )

	self:networkNumber( "moveSpeed", 66 )

	if ( _CLIENT ) then
		require( "engine.client.sprite" )
		local sprite = sprite( "images.player" )
		sprite:setFilter( "nearest", "nearest" )
		self:setSprite( sprite )
	end
end

function npc:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics( "dynamic" )
	self:setCollisionBounds( min, max )

	local status, ret = pcall(game.call, "shared", "onNPCSpawn", self )
	if (not status) then print(ret) end
end

function npc:__tostring()
	return "npc: " .. self:getName()
end
