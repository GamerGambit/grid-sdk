class "job.detective" ("job")

local det           = job.detective
det.title           = "Detective"
det.access          = { "sec_doors", "forensics_lockers", "morgue", "maint_tunnels", "court", "brig", "weapons", "mineral_storeroom" }
det.extended_access = { }
det.total_positions = 1
det.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
det.supervisorsStr  = "the Head of Security"
det.equip           = {
	-- TODO
	-- detective pda
	-- sec headset
	-- detective suit
	-- black gloves
	-- brown shoes
	-- cigar
	-- lighter
}
