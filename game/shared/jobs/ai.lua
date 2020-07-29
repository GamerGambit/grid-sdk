class "job.ai" ("job")

local ai           = job.ai
ai.title           = "A.I."
ai.access          = { }
ai.extended_access = { }
ai.total_positions = 1
ai.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
ai.supervisorsStr  = "your laws"
ai.equip           = { }
ai.lateShuttle     = false

--[[ TODO
function ai:postSpawn(ply, latejoin)
	if (latejoin) then
		find a latejoin AI core and "move" the player to it.
		mark the core as unavailable.
	end

	set the player's name to their preferred AI name.
	in case we have been created after our cyborgs, connect them to us.
end
]]

--[[ TODO
function ai:canLateJoin(ply)
	return true if any latejoin AI cores are available.
	return false
end
]]