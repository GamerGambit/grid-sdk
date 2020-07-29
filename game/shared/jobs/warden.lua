class "job.warden" ("job")

local warden           = job.warden
warden.title           = "Warden"
warden.access          = { "security", "sec_doors", "brig", "armory", "court", "weapons", "mineral_storeroom" }
warden.extended_access = { "maint_tunnels", "morgue", "forensics_lockers" }
warden.total_positions = 1
warden.spawn_positions = 1  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
warden.supervisorsStr  = "the Head of Security"
warden.equip           = {
	-- TODO
	-- warden pda
	-- sec headset
	-- warden clothes
	-- sunglasses
	-- taser
	-- handcuffs
	-- black gloves
	-- jack boots
}

--[[ TODO
function warden:getAccess()
	local access = job:getAccess()

	if (server config allows sec access to maint) then
		table.insert(access, "maint_tunnels")
	end

	return access
end
]]