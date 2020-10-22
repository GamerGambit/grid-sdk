local _DEBUG = _DEBUG
local error  = error
local love   = love
local print  = print
local string = string
local tostring = tostring
local pcall = pcall
local require = require

local function prepName(name)
	return string.gsub(string.fixslashes(string.stripextension(name)), '/', '.')
end

module("assets")

_fonts = {}
_images = {}
_sounds = {}
_animations = {}

function loadFont(relativeFontPath, fontSize, hinting, name)
	hinting = hinting or "normal"
	name = name or string.format("%s.%i.%s", prepName(relativeFontPath), fontSize, hinting)

	if (_fonts[name]) then
		return _fonts[name]
	end

	local font = love.graphics.newFont(string.format("fonts/%s", relativeFontPath), fontSize, hinting)
	_fonts[name] = font
	return font
end

function getFont(name)
	local font = _fonts[name]

	if (_DEBUG and not font) then
		print(string.format("No font with the name %q exists", tostring(name)))
		return
	end

	return font
end

function loadImage(relativeImagePath, name)
	name = name or prepName(relativeImagePath)

	if (_images[name]) then
		return _images[name]
	end

	local image = love.graphics.newImage(string.format("images/%s", relativeImagePath))
	_images[name] = image
	return image
end

function getImage(name)
	local image = _images[name]

	if (_DEBUG and not image) then
		print(string.format("No image with the name %q exists", tostring(name)))
		return
	end

	return image
end

function loadSound(relativeSoundPath, _type, name)
	_type = _type or "static"
	name = name or string.format("%s.%s", prepName(relativeSoundPath), _type)

	if (_sounds[name]) then
		return _sounds[name]
	end

	local source = love.audio.newSource(string.format("sounds/%s", relativeSoundPath), _type)
	_sounds[name] = source
	return source
end

function getSound(name)
	local source = _sounds[name]

	if (_DEBUG and not source) then
		print(string.format("No sound with the name %q exists", tostring(name)))
		return
	end

	return source
end

function loadAnimation(animRequirePath, name)
	name = name or animRequirePath

	if (_animations[name]) then
		return _animations[name]
	end

	local status, ret = pcall(require, animRequirePath)
	if (not status) then error(ret) end

	_animations[name] = ret
	return ret
end

function getAnimation(name)
	local anim = _animations[name]

	if (_DEBUG and not anim) then
		print(string.format("No animations with the name %q exist", tostring(name)))
		return
	end

	return anim
end
