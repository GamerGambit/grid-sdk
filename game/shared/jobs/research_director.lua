class "job.rd" ("job")

local rd           = job.rd
rd.title           = "Research Director"
rd.access          = { "rd", "heads", "tox", "genetics", "morgue",
			            "tox_storage", "teleporter", "sec_doors",
			            "research", "robotics", "xenobiology", "ai_upload",
			            "rc_announce", "keycard_auth", "gateway", "mineral_storeroom",
			            "tech_storage", "minisat", "maint_tunnels", "network" }
rd.extended_access = { }
rd.total_positions = 1
rd.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
rd.supervisorsStr  = "the Captain"
rd.equip           = {
	-- TODO
	-- silver ID card
	-- rd pda
	-- rd headset
	-- rd jumpsuit
	-- brown shoes
	--lab coat
}
