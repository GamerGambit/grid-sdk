entities.require("entity")

class "machine" ("entity")

function machine:machine()
	entity.entity(self)
end

entities.linkToClassname( machine, "machine" )
