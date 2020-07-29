class "job.clown" ("job")

local clown           = job.clown
clown.title           = "Clown"
clown.access          = { "theatre" }
clown.total_positions = 1
clown.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
clown.supervisorsStr  = "the Head of Personnel"
clown.equip           = {
	-- TODO
	-- clown PDA
	-- clown jumpsuit
	-- clown shoes
	-- clown mask
	-- bikehorn
	-- clown stamp
	-- waterflower
	-- banana
}
