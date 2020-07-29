class "job.botanist" ("job")

local bot           = job.botanist
bot.title           = "Botanist"
bot.access          = { "hydroponics", "morgue", "mineral_storeroom" }
bot.extended_access = { "kitchen", "bar" }
bot.total_positions = 3
bot.spawn_positions = 2  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
bot.supervisorsStr  = "the Head of Personnel"
bot.equip           = {
	-- TODO
	-- botany PDA
	-- service headset
	-- botany jumpsuit
	-- apron
	-- leather gloves
	-- plant analyser
}
