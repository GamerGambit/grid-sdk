class "job.cargo_tech" ("job")

local car           = job.cargo_tech
car.title           = "Cargo Technician"
car.access          = { "maint_tunnels", "cargo", "cargo_bot", "mailsorting", "mineral_storeroom" }
car.extended_access = { "qm", "mining", "mining_station" }
car.total_positions = 3
car.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
car.supervisorsStr  = "the Quartermaster and Head of Personnel"
car.equip           = {
	-- TODO
	-- cargo PDA
	-- cargo headset
	-- cargo jumpsuit
	-- export scanner
}
