class "job.geneticist" ("job")

local gen           = job.geneticist
gen.title           = "Geneticist"
gen.access          = { "medical", "morgue", "genetics", "cloning", "research", "mineral_storeroom" }
gen.extended_access = { "chemistry", "xenobiology", "robotics", "tech_storage" }
gen.total_positions = 2
gen.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
gen.supervisorsStr  = "the Chief Medical Officer"
gen.equip           = {
	-- TODO
	-- genetics pda
	-- science headset
	-- genetics jumpsuit
	-- white shoes
	-- lab coat
}
