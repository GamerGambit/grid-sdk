class "job.doctor" ("job")

local doc           = job.doctor
doc.title           = "Medical Doctor"
doc.access          = { "medical", "morgue", "surgery", "cloning", "mineral_storeroom" }
doc.extended_access = { "chemistry", "genetics", "cloning" }
doc.total_positions = 5
doc.spawn_positions = 3  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
doc.supervisorsStr  = "the Chief Medical Officer"
doc.equip           = {
	-- TODO
	-- silver ID
	-- doctor PDA
	-- doctor headset
	-- doctor jumpsuit
	-- lab coat
	-- brown shoes
}
