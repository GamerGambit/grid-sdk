class "job.lawyer" ("job")

local lawyer           = job.lawyer
lawyer.title           = "Lawyer"
lawyer.access          = { "lawyer", "court", "sec_doors" }
lawyer.total_positions = 2
lawyer.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
lawyer.supervisorsStr  = "the Head of Personnel"
lawyer.equip           = {
	-- TODO
	-- lawyer PDA
	-- security headset
	-- lawyer jumpsuit
	-- briefcase
	-- laser pointer
}
