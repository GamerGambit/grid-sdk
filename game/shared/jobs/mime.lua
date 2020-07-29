class "job.mime" ("job")

local mime           = job.mime
mime.title           = "Mime"
mime.access          = { "theatre" }
mime.total_positions = 1
mime.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
mime.supervisorsStr  = "the Head of Personnel"
mime.equip           = {
	-- TODO
	-- mime PDA
	-- mime jumpsuit
	-- beret
	-- suspenders
}
