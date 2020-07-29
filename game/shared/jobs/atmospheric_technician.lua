class "job.atmos" ("job")

local atm           = job.atmos
atm.title           = "Atmospheric Technician"
atm.access          = { "atmospherics", "maint_tunnels", "emergency_storage", "construction", "mineral_storeroom" }
atm.extended_access = { "engine", "engine_equip", "tech_storage", "external_airlocks" }
atm.total_positions = 3
atm.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
atm.supervisorsStr  = "the Chief Engineer"
atm.equip           = {
	-- TODO
	-- atmos utility belt
	-- atmos PDA
	-- engineering headset
	-- atmos jumpsuit
	-- workboots
	-- analyzer
}
