class "job.cyborg" ("job")

local borg           = job.cyborg
borg.title           = "Cyborg"
borg.access          = { }
borg.extended_access = { }
borg.total_positions = 0
borg.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
borg.supervisorsStr  = "your laws and the A.I."
borg.equip           = { }
