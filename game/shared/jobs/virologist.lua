class "job.virologist" ("job")

local viro           = job.virologist
viro.title           = "Virologist"
viro.access          = { "medical", "virology", "mineral_storeroom" }
viro.extended_access = { "morgue", "surgery", "chemistry", "genetics", "cloning" }
viro.total_positions = 1
viro.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
viro.supervisorsStr  = "the Chief Medical Officer"
viro.equip           = {
	-- TODO
	-- viro pda
	-- science headset
	-- viro jumpsuit
	-- white shoes
	-- lab coat
}
