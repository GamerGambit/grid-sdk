class "job.chemist" ("job")

local chem           = job.chemist
chem.title           = "Chemist"
chem.access          = { "medical", "chemistry", "mineral_storeroom" }
chem.extended_access = { "morgue", "surgery", "genetics", "cloning" }
chem.total_positions = 2
chem.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
chem.supervisorsStr  = "the Chief Medical Officer"
chem.equip           = {
	-- TODO
	-- science glasses
	-- chemist PDA
	-- medical headset
	-- medical jumpsuit
	-- lab coat
	-- white shoes
}
