class "job.roboticist" ("job")

local rob           = job.roboticist
rob.title           = "Roboticist"
rob.access          = { "robotics", "tech_storage", "morgue", "research", "mineral_storeroom" }
rob.extended_access = { "tox", "tox_storage", "xenobiology", "genetics" }
rob.total_positions = 2
rob.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
rob.supervisorsStr  = "the Research Director"
rob.equip           = {
	-- TODO
	-- robotics pda
	-- science headset
	-- robotics jumpsuit
	-- lab coat
}
