require( "engine.client.sprite" )

local _DEBUG = _DEBUG
local love   = love
local print  = print
local string = string
local tostring = tostring
local sprite = sprite
local type = type
local assert = assert
local pairs = pairs
local ipairs = ipairs
local table = table

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

-----------------------------------------------------------
--	ANIMATION
-----------------------------------------------------------
local function processAnimFrame(frame, frameTime)
	if (type(frame) == "number") then
		return { { command = sprite._commands.setFrameIndex, value = frame } }
	elseif (type(frame) == "function") then
		local ret = {}

		-- TODO try to revisit this later on to remove the "while true"
		while (true) do
			local i = frame()

			if (not i) then break end

			table.insert(ret, { command = sprite._commands.setFrameIndex, value = i })
		end

		return ret
	elseif (type(frame) == "table") then
		if (type(frame.frameTime) == "number" and frame.frames) then
			local ret = processAnimFrame(frame.frames, frameTime)
			table.insert(ret, 1, { command = sprite._commands.setFrameTime, value = frame.frameTime })
			table.insert(ret, { command = sprite._commands.setFrameTime, value = frameTime })
			return ret
		elseif (type(frame.from) == "number" and type(frame.to) == "number") then
			local ret = {}

			for frameIndex = frame.from, frame.to, (frame.from < frame.to and 1 or -1) do
				table.insert(ret, { command = sprite._commands.setFrameIndex, value = frameIndex })
			end

			return ret
		else
			local ret = {}

			for i, v in ipairs(frame) do
				table.append(ret, processAnimFrame(v, frameTime))
			end

			return ret
		end
	else
		assert(false, "Frame table must contain frame indices, a range, or a frame sub-table")
	end
end

function loadSpriteAnimations(spriteName, animTbl, frameTime)
	if (_animations[spriteName]) then
		return _animations[spriteName]
	end

	if (not animTbl) then return end
	assert(type(animTbl) == "table", "Animations must be a table")

	local ret = {}

	for animName, frameTbl in pairs(animTbl) do
		local sequence = processAnimFrame(frameTbl, frameTime)

		if (#sequence > 0) then
			-- This removes the trailing frameTime reset command. If it stays, the animation will never end and the "onAnimationEnd" function is never called
			if (sequence[#sequence].command == sprite._commands.setFrameTime) then
				table.remove(sequence)
			end

			table.insert(sequence, 1, { command = sprite._commands.setFrameTime, value = frameTime })
			ret[animName] = sequence
		else
			print(string.format("WARNING: animation is empty [%s/%s]", spriteName, animName))
		end
	end

	_animations[spriteName] = ret
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
