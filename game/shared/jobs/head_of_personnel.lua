class "job.hop" ("job")

local hop           = job.hop
hop.title           = "Head of Personnel"
hop.access          = {
	"security", "sec_doors", "court", "weapons",
	"medical", "engine", "change_ids", "ai_upload", "eva", "heads",
	"all_personal_lockers", "maint_tunnels", "bar", "janitor", "construction", "morgue",
	"crematorium", "kitchen", "cargo", "cargo_bot", "mailsorting", "qm", "hydroponics", "lawyer",
	"theatre", "chapel_office", "library", "research", "mining", "vault", "mining_station",
	"hop", "rc_announce", "keycard_auth", "gateway", "mineral_storeroom"
}
hop.total_positions = 1
hop.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
hop.supervisorsStr  = "the Captain"
hop.equip           = {
	-- TODO
	-- silver ID card
	-- hop PDA
	-- hop headset
	-- hop jumpsuit
	-- brown shoes
	-- hop hat
}
