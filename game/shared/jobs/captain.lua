class "job.captain" ("job")

local cap           = job.captain
cap.title           = "Captain"
cap.total_positions = 1
cap.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
cap.supervisorsStr  = "Apollox officials and Space law"
cap.equip           = {
	-- TODO
	-- gold ID card
	-- captain PDA
	-- sunglasses
	-- captain headset
	-- captain gloves
	-- captain jumpsuit
	-- captain carapace
	-- brown shoes
	-- captain hat
	-- habitat charter
}

function cap:getAccess()
	return access.getAllHabitat()
end
