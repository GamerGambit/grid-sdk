class "job.assistant" ("job")

local ass           = job.assistant
ass.title           = "Assistant"
ass.total_positions = 5
ass.spawn_positions = 5 -- TODO change this value on map-load. Create a `player_spawn` entity which mutates this.
ass.supervisorsStr  = "absolutely everyone"
