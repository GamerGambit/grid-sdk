require( "engine.client.sprite" )
require( "game.shared.construction" )
entities.require("structure")

class "structure_girder" ("structure")
entities.linkToClassname(structure_girder, "structure_girder")

local girder = structure_girder

girder.state = {
	normal = 0,
	displaced = 1,
	reinforced = 2,
	reinforced_struts = 3,
}

local girderStateToAnim = {
	[0] = "normal",
	[1] = "displaced",
	[2] = "reinforced",
	[3] = "reinforced"
}

function girder:structure_girder()
	structure.structure(self)

	self:setState(girder.state.normal)
end

function girder:setProperties(properties)
	for k,v in pairs(properties) do
		if (k == "state") then
			assert(type(girder.state[v]) == "number")
			self:setState(v)
		end
	end
end

function girder:setState(state)
	assert(type(girder.state[state]) == "number" or table.hasvalue(girder.state, state))
	if (state == self.state) then return end

	self.state = girder.state[state] or state

	local body = self:getBody()
	if (body) then
		if (self.state == girder.state.displaced) then
			body:setType("dynamic")
		else
			body:setType("static")
		end
	end

	self:setAnimation(string.format("girder_%s", girderStateToAnim[self.state]))
end

construction.register("structure_girder", {
	item_screwdriver = {
		predicate = function(ent, act) return ent.state == girder.state.displaced or ent.state == girder.state.reinforced or ent.state == girder.state.reinforced_struts end,
		onActivate = function(ent, act)
			if (ent.state == girder.state.displaced) then
				-- TODO [opt] send player a message telling them they are disassembling the girder
				-- use tool
				if (ent.state ~= girder.state.displaced) then return end

				-- TODO [opt] send player a message telling them they disassembled the girder
				-- TODO spawn 2 metal sheets
				-- TODO add finger prints to sheets
				entity.remove(ent)
			elseif (ent.state == girder.state.reinforced) then
				-- TODO [opt] send player a message telling them they are unsecuring support reinforced_struts
				-- TODO use tool
				if (ent.state ~= girder.state.reinforced) then return end

				-- TODO [opt] send player a message telling them they unsecured the support struts
				ent:setState(girder.state.reinforced_struts)
			elseif (ent.state == girder.state.reinforced_struts) then
				-- TODO [opt] send player a message telling them they are securing support reinforced_struts
				-- TODO use tool
				if (ent.state ~= girder.state.reinforced_struts) then return end

				-- TODO [opt] send player a message telling them they secured the support reinforced_struts
				ent:setState(girder.state.reinforced)
			end
		end
	},

	item_wirecutter = {
		predicate = function(ent, act) return ent.state == girder.state.reinforced_struts end,
		onActivate = function(ent, act)
			-- TODO [opt] send player a message telling them they are removing the inner grille
			-- TODO use tool
			if (ent.state ~= girder.state.reinforced_struts) then return end

			-- TODO [opt] send player a message telling them they removed the inner grille
			-- TODO spawn plasteel
			ent:setState(girder.state.normal)
		end
	},

	item_wrench = {
		predicate = function(ent, act) return ent.state == girder.state.normal or ent.state == girder.state.reinforced end,
		onActivate = function(ent, act)
			if (ent.state == girder.state.normal) then
				-- TODO [opt] send player a message telling them they are unsecuring the girder
				-- TODO use tool
				-- TODO add finger prints
				ent:setState(girder.state.displaced)
			else
				-- TODO [opt] send player a message telling them they are securing the girder
				-- TODO use tool
				-- TODO add finger prints
				ent:setState(girder.state.normal)
			end
		end
	}
})
