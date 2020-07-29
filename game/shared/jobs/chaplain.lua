class "job.chaplain" ("job")

local chap           = job.chaplain
chap.title           = "Chaplain"
chap.access          = { "morgue", "chapel_office", "crematorium", "theatre" }
chap.total_positions = 1
chap.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
chap.supervisorsStr  = "the Head of Personnel"
chap.equip           = {
	-- TODO
	-- chaplain PDA
	-- service headset
	-- chaplain jumpsuit
}

function chap:postSpawn(ply, latejoin)
	-- TODO
	-- prompt deity and religion
	-- give bible
end
