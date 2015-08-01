--========= Copyright © 2013-2015, Planimeter, All rights reserved. ==========--
--
-- Purpose: Region class
--
--============================================================================--

-- These values are preserved during real-time scripting.
local regions = region and region.regions or {}

require( "engine.shared.hook" )
require( "engine.shared.region.tileset" )
require( "engine.shared.region.layer" )

class( "region" )

region.regions = regions

if ( _CLIENT ) then
	function region.drawWorld()
		graphics.push()
			graphics.translate( camera.getTranslation() )
			for _, region in ipairs( region.regions ) do
				graphics.push()
					graphics.translate( region:getX(), region:getY() )
					region:draw()
				graphics.pop()
			end
		graphics.pop()
	end
end

function region.exists( name )
	return filesystem.exists( "regions/" .. name .. ".lua" )
end

function region.getAll()
	return table.shallowcopy( region.regions )
end

function region.getByName( name )
	for _, region in ipairs( region.regions ) do
		if ( name == region:getName() ) then
			return region
		end
	end
end

function region.getAtPosition( position )
	for _, region in ipairs( region.regions ) do
		local px, py = position.x, position.y
		local x,  y  = region:getX(), region:getY()
		local width  = region:getWidth()  * region:getTileWidth()
		local height = region:getHeight() * region:getTileHeight()
		if ( math.pointinrectangle( px, py, x, y, width, height ) ) then
			return region
		end
	end
end

function region.load( name, x, y )
	if ( region.getByName( name ) ) then
		return
	end

	local region = region( name, x, y )
	table.insert( region.regions, region )
end

function region.reload( library )
	if ( string.sub( library, 1, 8 ) ~= "regions." ) then
		return
	end

	local name = string.gsub( library, "regions.", "" )
	local r = region.getByName( name )
	r:cleanUp()
	region.unload( name )
	region.load( name )
end

hook.set( "shared", region.reload, "onReloadScript", "reloadRegion" )

if ( _CLIENT ) then
	function region.reloadTiles( filename )
		if ( not string.find( filename, "images/tilesets/" ) ) then
			return
		end

		for _, region in ipairs( region.regions ) do
			for _, regionlayer in ipairs( region:getLayers() ) do
				if ( regionlayer:getType() == "tilelayer" ) then
					regionlayer:initializeTiles()
				end
			end
		end
	end

	hook.set( "client",  region.reloadTiles, "onReloadImage", "reloadTiles")
end

function region.unload( name )
	unrequire( "regions." .. name )

	for i, region in ipairs( region.regions ) do
		if ( name == region:getName() ) then
			region:removeEntities()
			table.remove( region.regions, i )
			return
		end
	end
end

function region.unloadAll()
	for i = #region.regions, 1, -1 do
		local region = region.regions[ i ]
		unrequire( "regions." .. region:getName() )
		table.remove( region.regions, i )
	end
end

concommand( "region", "Loads the specified region",
	function( _, _, _, _, argT )
		local name = argT[ 1 ]
		if ( name == nil ) then
			print( "region <region name>" )
			return
		end

		if ( not region.exists( name ) ) then
			print( name .. " does not exist." )
			return
		end

		engine.disconnect()

		if ( _AXIS and not engine.isSignedIntoAxis() ) then
			print( "You are not signed into Axis." )
			return
		end

		local args = engine.getArguments()

		if ( _CLIENT and not _SERVER ) then
			if ( engine.connecting ) then
				return
			end

			_SERVER = true
			local status, ret = pcall( require, "engine.server" )
			if ( status ~= false ) then
				serverengine = ret
				if ( serverengine.load( args ) ) then
					networkserver.onNetworkInitializedServer()
				else
					print( "Failed to initialize server!" )
					engine.connecting = false
					engine.connected  = false
					engine.disconnect()
					_SERVER = nil
					return
				end
			else
				_SERVER = nil
				print( ret )
				return
			end
		end

		region.load( name )

		engine.connectToListenServer()
	end
)

function region.snapToGrid( x, y )
	local region = region.getAtPosition( vector( x, y ) )
	if ( not region ) then
		return x, y
	end

	local w, h = region:getTileSize()
	x = x - x % w
	y = y - y % h
	return x, y
end

function region:region( name, x, y )
	self.name     = name
	self.data     = require( "regions." .. name )
	self.entities = {}

	self.x = x or 0
	self.y = y or 0

	self:parse()
end

function region:addEntity( entity )
	table.insert( self.entities, entity )
end

if ( _CLIENT ) then
	function region:draw()
		local layers = self:getLayers()
		if ( not layers ) then
			return
		end

		for _, layer in ipairs( layers ) do
			if ( layer:isVisible() ) then
				graphics.push()
					graphics.setOpacity( layer:getOpacity() )
					layer:draw()
					graphics.setOpacity( 1 )
				graphics.pop()
			end
		end
	end
end

function region:cleanUp()
	local entities = self:getEntities()
	for _, entity in pairs( entities ) do
		entity:remove()
	end
end

function region:getEntities()
	return self.entities
end

function region:getFilename()
	return self.name .. ".lua"
end

function region:getFormatVersion()
	return self.formatVersion
end

function region:getLayers()
	return self.layers
end

function region:getName()
	return self.name
end

function region:getOrientation()
	return self.orientation
end

function region:getProperties()
	return self.properties
end

function region:getTilesets()
	return self.tilesets
end

function region:getTileWidth()
	return self.tileWidth
end

function region:getTileHeight()
	return self.tileHeight
end

function region:getWidth()
	return self.width
end

function region:getHeight()
	return self.height
end

function region:getX()
	return self.x
end

function region:getY()
	return self.y
end

local pos    = nil
local min    = nil
local max    = nil
local px     = 0
local py     = 0
local x      = 0
local y      = 0
local width  = 0
local height = 0
local pointinrectangle = math.pointinrectangle

function region:isTileWalkableAtPosition( position )
	-- px = position.x
	-- py = position.y
	-- for _, entity in ipairs( self:getEntities() ) do
	-- 	pos      = entity:getPosition()
	-- 	min, max = entity:getCollisionBounds()
	-- 	if ( min and max ) then
	-- 		min    = pos + min
	-- 		max    = pos + max
	-- 		x      = min.x
	-- 		y      = max.y
	-- 		width  = max.x - min.x
	-- 		height = min.y - max.y
	-- 		if ( pointinrectangle( px, py, x, y, width, height ) ) then
	-- 			return false
	-- 		end
	-- 	end
	-- end
	return true
end

function region:loadTilesets( tilesets )
	if ( self.tilesets ) then
		return
	end

	self.tilesets = {}

	for _, tilesetData in ipairs( tilesets ) do
		local tileset = regiontileset( tilesetData )
		table.insert( self.tilesets, tileset )
	end
end

function region:loadLayers( layers )
	if ( self.layers ) then
		return
	end

	self.layers = {}

	for _, layerData in ipairs( layers ) do
		local layer = regionlayer( layerData )
		layer:setRegion( self )
		layer:parse()

		local gid = layer:getHighestTileGid()
		local tileset = nil
		for _, t in ipairs( self:getTilesets() ) do
			if ( t:getFirstGid() <= gid ) then
				tileset = t
			end
		end
		layer:setTileset( tileset )
		table.insert( self.layers, layer )
	end
end

function region:parse()
	if ( not self.data ) then
		return
	end

	local data = self.data
	self:setFormatVersion( data[ "version" ] )
	self:setOrientation( data[ "orientation" ] )
	self:setWidth( data[ "width" ] )
	self:setHeight( data[ "height" ] )
	self:setTileWidth( data[ "tilewidth" ] )
	self:setTileHeight( data[ "tileheight" ] )
	self:setProperties( table.copy( data[ "properties" ] ) )

	self:loadTilesets( data[ "tilesets" ] )
	self:loadLayers( data[ "layers" ] )

	self.data = nil
end

function region:removeEntities()
	local entities = self:getEntities()
	for _, entity in ipairs( entities ) do
		entity:remove()
	end

	table.clear( entities )
end

function region:setFormatVersion( formatVersion )
	self.formatVersion = formatVersion
end

function region:setName( name )
	self.name = name
end

function region:setOrientation( orientation )
	self.orientation = orientation
end

function region:setProperties( properties )
	self.properties = properties
end

function region:setTileWidth( tileWidth )
	self.tileWidth = tileWidth
end

function region:setTileHeight( tileHeight )
	self.tileHeight = tileHeight
end

function region:getTileSize()
	return self:getTileWidth(), self:getTileHeight()
end

function region:setWidth( width )
	self.width = width
end

function region:setHeight( height )
	self.height = height
end

function region:setX( x )
	self.x = x
end

function region:setY( y )
	self.y = y
end

function region:__tostring()
	return "region: \"" .. self:getFilename() .. "\""
end
