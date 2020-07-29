class "job.hos" ("job")

local hos           = job.hos
hos.title           = "Head of Security"
hos.access          = {
	"security", "sec_doors", "brig", "armory", "court", "weapons",
	"forensics_lockers", "morgue", "maint_tunnels", "all_personal_lockers",
	"research", "engine", "mining", "medical", "construction", "mailsorting",
	"heads", "hos", "rc_announce", "keycard_auth", "gateway", "maint_tunnels", "mineral_storeroom"
}
hos.extended_access = { }
hos.total_positions = 1
hos.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
hos.supervisorsStr  = "the Captain"
hos.equip           = {
	-- TODO
	-- silver ID
	-- hos pda
	-- hos headset
	-- hos jumpsuit
	-- sunglasses
	-- e-gun
	-- handcuffs
	-- beret
	-- black gloves
	-- jack boots
}