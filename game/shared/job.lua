class "job"

job.title           = "base job"
job.access          = {} -- normal access for this job, used for high population
job.extended_access = {} -- extended access used on low population (skeleton crew) to grant additional access. It is combined with `access`.
job.total_positions = 0  -- how many players can be this job?
job.spawn_positions = 0  -- how many players can spawn in as this job? --[[ TODO change this value on map-load. Create a `player_spawn` entity which mutates this. ]]
job.supervisorsStr  = "" -- "You answer directly to [supervisorStr]"
job.equip           = {} -- Starting items like PDA, headset, jumpsuit, etc
job.lateShuttle     = true

function job:getAccess()
	--[[
		if (_DEBUG) then
			local ret = table.shallowcopy(self.access)
			table.append(ret, self.extended_access)

			-- this should assert if there is duplicates in `access` and `extended_access`
			-- this really isnt that big a deal but it helps keep the access lists cleaner
			assert(#table.unique(ret) == #self.access + #self.extended_access)

			return ret
		end
	]]
	return self.access
end

function job:postSpawn(ply, latejoin)
end

function job:canLateJoin(ply)
	return true
end
