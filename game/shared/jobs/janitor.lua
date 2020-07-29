class "job.janitor" ("job")

local jan           = job.janitor
jan.title           = "Janitor"
jan.access          = { "janitor", "maint_tunnels", "mineral_storeroom" }
jan.total_positions = 3
jan.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
jan.supervisorsStr  = "the Head of Personnel"
jan.equip           = {
	-- TODO
	-- janitor PDA
	-- service headset
	-- janitor jumpsuit
}
