class "access"

access._names = {}

function access.register(name)
	assert(not access.exists(name), string.format("Access name \"%s\" already exists", name))
	table.insert(access._names, name)
end

function access.exists(name)
	return table.hasvalue(access._names, name)
end

function access.getAllHabitat()
	local all = {
		"security", "sec_doors", "brig", "armory", "forensics_lockers", "court",
		"medical", "genetics", "morgue", "rd",
		"tox", "tox_storage", "chemistry", "engine", "engine_equip", "maint_tunnels",
		"external_airlocks", "change_ids", "ai_upload",
		"teleporter", "eva", "heads", "captain", "all_personal_lockers",
		"tech_storage", "chapel_office", "atmospherics", "kitchen",
		"bar", "janitor", "crematorium", "robotics", "cargo", "construction",
		"hydroponics", "library", "lawyer", "virology", "cmo", "qm", "surgery",
		"theatre", "research", "mining", "mailsorting", "weapons",
		"vault", "mining_station", "xenobiology", "ce", "hop", "hos", "rc_announce",
		"keycard_auth", "tcomsat", "gateway", "mineral_storeroom", "minisat", "network", "cloning"
	}

	if (_DEBUG) then
		for _, v in ipairs(all) do
			assert(access.exists(v), string.format("Access name %q does not exist", v))
		end
	end

	return all
end

function access:access()
	self.list = {}
end

function access:hasAccess(name)
	assert(access.exists(name), string.format("Access name \"%s\" does not exist", name))
	return table.hasvalue(self.list, name)
end

function access:canAccess(allRequired, oneRequired)
	assert(type(allRequired) == "table")

	if (#allRequired == 0 and #oneRequired == 0) then return true end

	for _, name in ipairs(allRequired) do
		if (not self:hasAccess(name)) then return false end
	end

	if (type(oneRequired) == "table" and #oneRequired > 0) then
		for _, name in ipairs(oneRequired) do
			if (self:hasAccess(name)) then return true end
		end

		return false
	end

	return true
end

function access:grantAccess(strOrTbl)
	assert(type(strOrTbl) == "string" or type(strOrTbl) == "table")

	local list
	if (type(strOrTbl) == "string") then
		list = string.split(strOrTbl, ';')
	elseif (type(strOrTbl) == "table") then
		list = strOrTbl
	end

	for _, name in ipairs(list) do
		assert(access.exists(name), string.format("Access name \"%s\" does not exist", name))
		if (not self:hasAccess(name)) then
			table.insert(self.list, name)
		end
	end
end

function access:revokeAccess(strOrTbl)
	assert(type(strOrTbl) == "string" or type(strOrTbl) == "table")

	local list
	if (type(strOrTbl) == "string") then
		list = string.split(strOrTbl, ';')
	elseif (type(strOrTbl) == "table") then
		list = strOrTbl
	end

	local removeKeys = {}
	for k, v in ipairs(self.list) do
		if (table.hasvalue(list, v)) then
			table.insert(removeKeys, k)
		end
	end

	for _, k in ipairs(removeKeys) do
		table.remove(self.list, k)
	end
end

access.register("security")             -- Security equipment, security records, gulag item storage, secbots
access.register("brig")                 -- Brig cells+timers, permabrig, gulag+gulag shuttle, prisoner management console
access.register("armory")               -- Armory, gulag teleporter, execution chamber
access.register("forensics_lockers")    -- Detective's office, forensics lockers, security+medical records
access.register("medical")
access.register("morgue")
access.register("tox")                  -- R&D department, R&D console, burn chamber on some maps
access.register("tox_storage")          -- Toxins storage, burn chamber on some maps
access.register("genetics")
access.register("engine")               -- Engineering area, power monitor, power flow control console
access.register("engine_equip")         -- APCs, EngiVend/YouTool, engineering equipment lockers
access.register("maint_tunnels")
access.register("external_airlocks")
access.register("emergency_storage")    -- Not in use
access.register("change_ids")
access.register("ai_upload")
access.register("teleporter")
access.register("eva")
access.register("heads")                -- Bridge, EVA storage windoors, gateway shutters, AI integrity restorer, clone record deletion, comms console
access.register("captain")
access.register("all_personal_lockers")
access.register("chapel_office")
access.register("tech_storage")
access.register("atmospherics")
access.register("bar")
access.register("janitor")
access.register("crematorium")
access.register("kitchen")
access.register("robotics")
access.register("rd")
access.register("cargo")
access.register("construction")
access.register("chemistry")
access.register("cargo_bot")            -- Not in use
access.register("hydroponics")
access.register("manufacturing")        -- Only used on research.dmm away mission
access.register("library")
access.register("lawyer")
access.register("virology")
access.register("cmo")
access.register("qm")
access.register("court")
access.register("surgery")
access.register("theatre")
access.register("research")
access.register("mining")
access.register("mining_office")        -- Not in use
access.register("mailsorting")
access.register("mint")                 -- Not in use
access.register("mint_vault")           -- Not in use
access.register("vault")
access.register("mining_station")
access.register("xenobiology")
access.register("ce")
access.register("hop")
access.register("hos")
access.register("rc_announce")          -- Request console announcements
access.register("keycard_auth")         -- Used for events which require at least two people to confirm them
access.register("tcomsat")              -- has access to the entire telecomms satellite / machinery
access.register("gateway")
access.register("sec_doors")            -- Outer brig doors, department security posts
access.register("mineral_storeroom")    -- For releasing minerals from the ORM
access.register("minisat")
access.register("weapons")              -- Weapon authorization for secbots
access.register("network")              -- NTnet diagnostics/monitoring software
access.register("cloning")              -- Cloning room and clone pod ejection

--BEGIN CENTCOM ACCESS
--[[
	Should leave plenty of room if we need to add more access levels.
	Mostly for admin fun times.
]]
access.register("centcom.general")      -- General facilities. CentCom ferry.
access.register("centcom.thunder")      -- Thunderdome.
access.register("centcom.specops")      -- Special Ops. Captain's display case, Marauder and Seraph mechs.
access.register("centcom.medical")      -- Medical/Research
access.register("centcom.living")       -- Living quarters.
access.register("centcom.storage")      -- Generic storage areas.
access.register("centcom.teleporter")   -- Teleporter.
access.register("centcom.captain")      -- Captain's office/ID comp/AI.
access.register("centcom.bar")          -- The non-existent CentCom Bar

--The Syndicate
access.register("syndicate")            -- General Syndicate Access. Includes Syndicate mechs and ruins.
access.register("syndicate_leader")     -- Nuke Op Leader Access

--Away Missions or Ruins
--[[
	For generic away-mission/ruin access. Why would normal crew have access to a long-abandoned derelict
	or a 2000 year-old temple?
]]
access.register("away.general")         -- General facilities.
access.register("away.maint")           -- Away maintenance
access.register("away.med")             -- Away medical
access.register("away.sec")             -- Away security
access.register("away.engine")          -- Away engineering
access.register("away.generic1")        -- Away generic access
access.register("away.generic2")
access.register("away.generic3")
access.register("away.generic4")

--Special, for anything that's basically internal
access.register("bloodcult")
access.register("clockcult")