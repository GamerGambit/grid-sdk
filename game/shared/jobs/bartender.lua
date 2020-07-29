class "job.bartender" ("job")

local bar           = job.bartender
bar.title           = "Bartender"
bar.access          = { "bar", "mineral_storeroom" }
bar.extended_access = { "hydroponics", "kitchen", "morgue", "weapons" }
bar.total_positions = 1
bar.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
bar.supervisorsStr  = "the Head of Personnel"
bar.equip           = {
	-- TODO
	-- glasses
	-- bartender PDA
	-- service headset
	-- lace shoes
	-- bartender jumpsuit
	-- vest
}
