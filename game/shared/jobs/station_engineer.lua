class "job.engineer" ("job")

local se           = job.engineer
se.title           = "Station Engineer"
se.access          = { "engine", "engine_equip", "tech_storage", "maint_tunnels", "external_airlocks", "construction", "tcomsat", "mineral_storeroom" }
se.extended_access = { "atmospherics" }
se.total_positions = 5
se.spawn_positions = 5  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
se.supervisorsStr  = "the Chief Engineer"
se.equip           = {
	-- TODO
	-- engineering utility belt
	-- engineering PDA
	-- engineering headset
	-- engineerin jumpsuit
	-- workboots
	-- hardhat
	-- T scanner
}
