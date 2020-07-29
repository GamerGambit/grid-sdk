class "job.ce" ("job")

local ce           = job.ce
ce.title           = "Chief Engineer"
ce.access          = {
	"engine", "engine_equip", "tech_storage", "maint_tunnels",
	"external_airlocks", "atmospherics", "emergency_storage", "eva",
	"heads", "construction", "sec_doors", "minisat",
	"ce", "rc_announce", "keycard_auth", "tcomsat", "mineral_storeroom"
}
ce.total_positions = 1
ce.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
ce.supervisorsStr  = "the Captain"
ce.equip           = {
	-- TODO
	-- silver ID
	-- ce utility belt
	-- ce PDA
	-- ce headset
	-- ce jumpsuit
	-- brown shoes
	-- white hardhat
	-- black gloves
}
