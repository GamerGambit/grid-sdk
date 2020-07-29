class "job.shaft_miner" ("job")

local sm           = job.shaft_miner
sm.title           = "Shaft Miner"
sm.access          = { "mining", "mining_station", "mailsorting", "mineral_storeroom" }
sm.extended_Access = { "maint_tunnels", "cargo", "cargo_bot", "qm" }
sm.total_positions = 3
sm.spawn_positions = 3  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
sm.supervisorsStr  = "the Quartermaster and Head of Personnel"
sm.equip           = {
	-- TODO
	-- mining PDA
	-- mining headset
	-- mining workboots
	-- black gloves
	-- mining jumpsuit
	-- mining bag
	-- beacon
}
