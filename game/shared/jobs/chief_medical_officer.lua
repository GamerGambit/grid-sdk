class "job.cmo" ("job")

local cmo           = job.cmo
cmo.title           = "Chief Medical Officer"
cmo.access          = {
	"medical", "morgue", "genetics", "cloning", "heads", "mineral_storeroom",
	"chemistry", "virology", "cmo", "surgery", "rc_announce",
	"keycard_auth", "sec_doors", "maint_tunnels"
}
cmo.total_positions = 1
cmo.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
cmo.supervisorsStr  = "the Captain"
cmo.equip           = {
	-- TODO
	-- silver ID
	-- cmo PDA
	-- cmo headset
	-- cmo jumpsuit
	-- lab coat
	-- brown shoes
}
