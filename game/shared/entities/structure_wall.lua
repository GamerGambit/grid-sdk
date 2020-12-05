require( "game.shared.construction" )
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

construction.register("structure_wall", {
	{
		items = { "item_welder", "item_gun_energy_plasmacutter" },
		recipe = {
			onActivate = function(ent, act, item)
				--TODO [below]
				--[[
				-- cleaning
				if (typeof(tool, "item_welder") and act.intent == intents.help) then
					ent.dent_decals = {}
					return
				end
				]]

				--
				-- TODO check that the tool is on and has enough fuel
				-- TODO [opt] send player a message telling them they are slicing through the outer plating
				if (not ent) then return end -- TODO properly check validity of ent (e.g entity.isValid(ent)/IsValid(ent)) AFTER the process is done
				--TODO spawn metal sheets
				local pos = ent:getPosition()
				ent:remove()
				local girder = entity.create("structure_girder")
				girder:setPosition(pos)
				girder:spawn()
			end
		}
	},

	{
		items = { "item_wallframe", "item_poster", "item_electronic_assembly_wallmount" },
		recipe = {
			onActivate = function(ent, act, item)
				if (typeof(item, "item_wallframe")) then
					-- TODO attach wallframe
				elseif (typeof(item, "item_poster")) then
					-- TODO attach poster
				else -- "item_electronic_assembly_wallmount"
					-- TODO mount assembly
				end
			end
		}
	},

	item_pickaxe_drill_jackhammer = {
		onActivate = function(ent, act, item)
			ent:remove()
		end
	}
})
