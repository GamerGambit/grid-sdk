entities.require("structure")

class "structure_grill" ("structure")

entities.linkToClassname(structure_grill, "structure_grill")

local grill = structure_grill

accessor(grill, "anchored")

function grill:structure_grill()
	structure.structure(self)

	self:setAnimation("grill")
end

function grill:setAnchored(bAnchored)
	self.anchored = toboolean(bAnchored)

	local body = self:getBody()
	assert(body, "Failed to change anchor state of grill (no physics body)")

	if (bAnchored) then
		body:setType("static")
	else
		body:setType("dynamic")
	end
end

function grill:spawn()
	structure.spawn(self)

	self:setAnchored(true)
end

local function chance(prb)
	if (prb == 0) then return false end
	if (prb == 100) then return true end

	return math.random() * 100 < prb
end

-- shock user with probability prb (if all connections & power are working)
-- returns `true` if shocked, `false` otherwise
function grill:shock(mob, prb)
	if (not self.anchored or self.broken) then return false end
	if (not chance(prb)) then return false end

	-- TODO make sure the user is in range (out of range, no shock)
	-- TODO make sure there is a cable under the grill (no cable, no shock)
	-- TODO try to electrocute the mob, if success, create sparks and return true, otherwise return false

	return false
end

construction.register("structure_grill", {
	item_wirecutters = {
		onActivate = function(ent, act, item)
			if (not self:shock(act, 100)) then
				-- TODO play tool sound
				-- TODO spawn a stack of rods
				ent:remove()
			end
		end
	},

	item_screwdriver = {
		-- TODO add predicate to check there is at least hull plating at the ent's location to prevent anchoring a grill to space/nothing
		onActivate = function(ent, act, item)
			-- TODO
			if (not shock(act, 90)) then
				-- TODO play tool sound
				ent:setAnchored(not ent:getAnchored())
				-- TODO maybe send the player a message telling them whether they fastened/loosened the grill
			end
		end
	}

	-- TODO rod stack
	-- TODO glass stack (incl normal glass, reinforced glass, plasma glass, reinforced plasma glass, titanium glass, plasma titanium glass)
})
