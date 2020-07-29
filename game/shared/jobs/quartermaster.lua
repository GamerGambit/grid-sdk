class "job.qm" ("job")

local qm           = job.qm
qm.title           = "Quartermaster"
qm.access          = {
	"maint_tunnels", "mailsorting", "cargo", "cargo_bot", "qm", "mining", "mining_station", "mineral_storeroom", "vault"
}
qm.total_positions = 1
qm.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
qm.supervisorsStr  = "the Head of Personnel"
qm.equip           = {
	-- TODO
	-- qm PDA
	-- qm headset
	-- qm jumpsuit
	-- brown shoes
	-- sunglasses
}
