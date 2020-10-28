entities.require("item_wirecutters")

class "item_wirecutters_brass" ("item_wirecutters")

function item_wirecutters_brass:item_wirecutters_brass()
	item.item(self)
end

function item_wirecutters_brass:draw()
	entity.draw(self)

	item_wirecutters._sprite:setAnimation("brass")
	item_wirecutters._sprite:draw()
end

entities.linkToClassname( item_wirecutters_brass, "item_wirecutters_brass" )
