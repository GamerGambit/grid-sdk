class "job.scientist" ("job")

local sci           = job.scientist
sci.title           = "Scientist"
sci.access          = { "tox", "tox_storage", "research", "xenobiology", "mineral_storeroom" }
sci.extended_access = { "robotics", "tech_storage", "genetics" }
sci.total_positions = 5
sci.spawn_positions = 3  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
sci.supervisorsStr  = "the Research Director"
sci.equip           = {
	-- TODO
	-- toxins pda
	-- science headset
	-- science jumpsuit
	-- white shoes
	-- lab coat
}
