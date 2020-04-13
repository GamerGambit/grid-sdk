entities.require("entity")

class "player_spawn" ("entity")

function player_spawn:player_spawn()
	entity.entity(self)
end

entities.linkToClassname( player_spawn, "player_spawn" )