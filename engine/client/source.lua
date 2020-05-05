--=========== Copyright © 2019, Planimeter, All rights reserved. ===========--
--
-- Purpose: Source class
--
--==========================================================================--

class( "source" )

source._sources = source._sources or {}

local function copy( k )
	if ( string.find( k, "__" ) == 1 ) then
		return
	end

	source[ k ] = function( self, ... )
		local filename = self:getFilename()
		local source = source._sources[ filename ]
		if ( source == nil ) then
			return
		end

		local self = source.source
		return self[ k ]( self, ... )
	end
end

local _R = debug.getregistry()
for k in pairs( _R.Source ) do
	copy( k )
end

local function reload( filename )
	print( "Updating " .. filename .. "..." )

	local status, ret = pcall( assets.loadSound, filename, "stream" )
	if ( status == true ) then
		local info = love.filesystem.getInfo( string.format("sounds/%s", filename) )
		source._sources[ filename ].source  = ret
		source._sources[ filename ].modtime = info.modtime

		if ( game ) then
			local status, ret = pcall(game.call, "client", "onReloadSound", filename )
			if (not status) then print(ret) end
		else
			hook.call( "client", "onReloadSound", filename )
		end
	else
		print( ret )
	end
end

function source.update( dt )
	for k, v in pairs( source._sources ) do
		local info = love.filesystem.getInfo( string.format("sounds/%s", k) )
		if ( info.modtime ~= v.modtime ) then
			reload( k )
		end
	end
end

function source.reload( library )
	if ( string.sub( library, 1, 7 ) ~= "sounds." ) then
		return
	end
	-- TODO: Reload soundscript.
end

hook.set( "client", source.reload, "onReloadScript", "reloadSound" )

function source:source( filename )
	local status, ret = pcall( require, filename )
	if ( status == true ) then
		self.data     = ret
		self.filename = self.data[ "source" ]
	else
		self.filename = filename
	end
end

accessor( source, "data" )
accessor( source, "filename" )

function source:parse()
	local filename = self:getFilename()
	source._sources[ filename ] = {
		source  = assets.loadSound( filename, "stream" ),
		modtime = love.filesystem.getInfo( string.format("sounds/%s", filename) ).modtime
	}

	local data = self:getData()
	if ( data == nil ) then
		return
	end

	local volume = data[ "volume" ]
	if ( volume ) then
		self:setVolume( volume )
	end
end

function source:play()
	local filename = self:getFilename()
	if ( source._sources[ filename ] == nil ) then
		self:parse()
	end

	local source = source._sources[ filename ].source
	if ( source:isPlaying() ) then
		source = source:clone()
		source:seek( 0 )
	end

	love.audio.play( source )
end

function source:__tostring()
	local t = getmetatable( self )
	setmetatable( self, {} )
	local s = string.gsub( tostring( self ), "table", "source" )
	setmetatable( self, t )
	return s
end
