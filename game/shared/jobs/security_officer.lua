class "job.sec_officer" ("job")

local sec           = job.sec_officer
sec.title           = "Security Officer"
sec.access          = { "security", "sec_doors", "brig", "court", "weapons", "mineral_storeroom" }
sec.extended_access = { "maint_tunnels", "morgue", "forensics_lockers" }
sec.total_positions = 1
sec.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
sec.supervisorsStr  = "the Head of Security"
sec.equip           = {
	-- TODO
	-- sec pda
	-- sec headset
	-- sec jumpsuit
	-- black gloves
	-- jack boots
	-- helmet
	-- armor vest
	-- handcuffs
}

--[[ TODO
function sec:getAccess()
	local access = job:getAccess()

	if (server config allows sec access to maint) then
		table.insert(access, "maint_tunnels")
	end

	return access
end
]]

--[[ TODO
function sec:postSpawn(ply, latejoin)
	set a list of available departments (engineering, medical, science, supply/cargo).
	find the player's preferred security department.
	if its set to none, or the list of available departments is empty, return.
	give the player an armband for their chosen department, and add headset and ID access to that department.
	teleport the player to the department's security spawn
end
]]