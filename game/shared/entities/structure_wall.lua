entities.require("structure")

class "structure_wall" ("structure")

entities.linkToClassname(structure_wall, "structure_wall")

local wall = structure_wall

wall.types = {
	"wall",
	"reinforced"
}

accessor(structure_wall, "wallType")

function wall:structure_wall()
	structure.structure(self)

	self:setWallType("wall")
end

function wall:setWallType(wallType)
	assert(table.hasvalue(wall.types, wallType), string.format("Invalid wall type %s", wallType))
	self.wallType = wallType

	-- TODO wall/r_wall sprites need to be moved into structures.png
	local spr
	if (wallType == "wall") then
		spr = assets.loadImage("entities/wall.png")
	elseif (wallType == "reinforced") then
		spr = assets.loadImage("entities/wall.png")
	end

	spr:setFilter("nearest", "nearest")
	self:setSprite(spr)
	--self:setAnimation(string.format("wall_%s", wallType))
end
