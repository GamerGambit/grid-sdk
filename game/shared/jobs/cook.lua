class "job.cook" ("job")

local cook           = job.cook
cook.title           = "Cook"
cook.access          = { "kitchen", "morgue", "mineral_storeroom" }
cook.extended_access = { "hydroponics", "bar" }
cook.total_positions = 2
cook.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
cook.supervisorsStr  = "the Head of Personnel"
cook.equip           = {
	-- TODO
	-- cook PDA
	-- service headset
	-- chef jumpsuit
	-- chef hat
	-- fake moustach
	-- apron
	-- knife
}
