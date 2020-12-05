entities.require("structure")

class "structure_wall_reinforced" ("structure")

entities.linkToClassname(structure_wall_reinforced, "structure_wall_reinforced")

local reinforced_wall = structure_wall_reinforced

reinforced_wall.state = {
	intact = 0,
	support_lines = 1,
	cover = 2,
	cut_cover = 3,
	anchor_bolts = 4,
	support_rods = 5,
	sheath = 6
}

function reinforced_wall:structure_wall_reinforced()
	structure.structure(self)

	self.d_state = reinforced_wall.state.intact

	if (_CLIENT) then
		local sprite = assets.loadImage("entities/reinforced_wall.png")
		sprite:setFilter("nearest", "nearest")
		self:setSprite(sprite)
	end
end

function reinforced_wall:setDState(dstate)
	assert(table.hasvalue(reinforced_wall.state, dstate), "Invalid rwall dstate")

	self.d_state = dstate

	-- TODO set anim to reflect dstate. image needs to be updated first
end

construction.register("structure_wall_reinforced", {
	-- INTACT
	item_wirecutters = {
		predicate = function(ent, act, item) return ent.d_state == structure_wall_reinforced.state.intact end,
		onActivate = function(ent, act, item)
			-- TODO play tool sound
			ent:setDState(structure_wall_reinforced.state.support_lines)
			-- TODO [opt] send player a message telling them that they have cut the outer grill
		end
	},

	-- SUPPORT_LINES
	{
		items = { "item_screwdriver", "item_wirecutters" },
		recipe = {
			predicate = function(ent, act, item) return ent.d_state == structure_wall_reinforced.state.support_lines end,
			onActivate = function(ent, act, item)
				if (typeof(item, "item_screwdriver")) then
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is support_lines
					ent:setDState(structure_wall_reinforced.state.cover)
					-- TODO [opt] send player a message telling them they have unsecured the support lines
				else -- wirecutters
					-- TODO play tool sound
					ent:setDState(structure_wall_reinforced.state.intact)
					-- TODO [opt] send player a message telling them they have repaired the outer grill
				end
			end
		}
	},

	-- COVER
	{
		items = { "item_welder", "item_gun_energy_plasmacutter", "item_screwdriver" },
		recipe = {
			predicate = function(ent, act, item) return ent.d_state == structure_wall_reinforced.state.cover end,
			onActivate = function (ent, act, item)
				if (typeof(item, "item_screwdriver")) then
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is cover
					ent:setDState(structure_wall_reinforced.state.support_lines)
					-- TODO [opt] send player a message telling them the support lines are secure
				else -- welder or plasmacutter
					-- TODO check that the welder/plasmacutter has enough fuel
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is cover
					ent:setDState(structure_wall_reinforced.state.cut_cover)
					-- TODO maybe send the player a message tellin them that the metal cover has been dislodged
				end
			end
		}
	},

	-- CUT_COVER
	{
		items = { "item_crowbar", "item_welder" },
		recipe = {
			predicate = function(ent, act, item) return ent.d_state == structure_wall_reinforced.state.cut_cover end,
			onActivate = function(ent, act, item)
				if (typeof(item, "item_crowbar")) then
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is cut_cover
					ent:setDState(structure_wall_reinforced.state.anchor_bolts)
					-- TODO [opt] send player a message telling them that they pryed the cover off
				else -- welder
					-- TODO check that the welder has enough fuel
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is cut_cover
					ent:setDState(structure_wall_reinforced.state.cover)
					-- TODO [opt] send player a message telling them that the metal cover has been welded securely to the frame
				end
			end
		}
	},

	-- ANCHOR_BOLTS
	{
		items = { "item_wrench", "item_crowbar" },
		recipe = {
			predicate = function(ent, act, item) return ent.d_state == structure_wall_reinforced.state.anchor_bolts end,
			onActivate = function(ent, act, item)
				if (typeof(item, "item_wrench")) then
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is anchor_bolts
					ent:setDState(structure_wall_reinforced.state.support_rods)
					-- TODO [opt] send player a message telling them they removed the bolts anchoring the support rods
				else -- crowbar
					-- TODO use tool
					-- TODO make sure the wall still excists and its d_state is anchor_bolts
					ent:setDState(structure_wall_reinforced.state.cut_cover)
					-- TODO [opt] send player a message telling them that they pryed the metal cover back in place
				end
			end
		}
	},

	-- SUPPORT_RODS
	{
		items = { "item_welder", "item_gun_energy_plasmacutter", "item_wrench" },
		recipe = {
			predicate = function(ent, act, item) return ent.d_state == structure_wall_reinforced.state.support_rods end,
			onActivate = function(ent, act, item)
				if (typeof(item, "item_wrench")) then
					-- TODO use tool
					-- make sure the wall still exists and its d_state is support_rods
					ent:setDState(structure_wall_reinforced.state.anchor_bolts)
					-- TODO [opt] send player a message telling them they tighten the bolds anchoring the support rods
				else -- welder or plasmacutter
					-- TODO check that the welder/plasmacutter has enough fuel
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is support_rods
					ent:setDState(structure_wall_reinforced.state.anchor_bolts)
					-- TODO [opt] send player a message telling them that they sliced through the support rods
				end
			end
		}
	},

	-- SHEATH
	{
		items = { "item_crowbar", "item_welder" },
		recipe = {
			predicate = function(ent, act, item) return ent.d_state == structure_wall_reinforced.state.sheath end,
			onActivate = function(ent, act, item)
				if (typeof(item, "item_crowbar")) then
					-- TODO use tool
					-- TODO make sure the wall still exists and that its d_state is sheath

					-- TODO spawn plasteel stack
					local girder = structure_girder()
					girder:setType(structure_girder.state.reinforced)
					girder:setPosition(ent:getPosition())
					ent:remove()

					-- TODO [opt] send player a message telling them that they pryed off the outer sheath
				else -- welder
					-- TODO use tool
					-- TODO make sure the wall still exists and its d_state is sheath
					ent:setDState(structure_wall_reinforced.state.support_rods)
					-- TODO [opt] send player a message telling them they welded the support rods back together
				end
			end
		}
	}
})
