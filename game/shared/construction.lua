--[[
	CONSTRUCTION

	This module is responsible for representing all available building "recipes".
	`_lookup` is a table of tables of pairs.
		The keys are the entity types, with the values being a "recipe" table.
		The "recipe" table is essentially a key-value pair.
			The key is the item/tool needed to active the recipe.
			The value is a table which provides a predicate to determine if the recipe can be used on the entity in its current state.

	In the event that a recipe results in the entity's destruction (e.g welding a girder), or the recipe "drops" items (e.g. welding a wall),
		this should be handled in `onActivate`

	_lookup = {
		"girder" = {
			"tool_wrench" = {
					onActivate = function(ent, act, item) ent.secured = not ent.secured end
				},
			"item_rod" = {
					predicate = function(ent, act, item) return true end, -- rods are always welcome
					onActivate = function(ent, act, item) ent.reinforced = true end
				},
			"item_plasteel" = {
					predicate = function(ent, act, item) return ent.secured and ent.reinforced end,
					onActivate = function(ent, act, item)
							local rw = ents.create("reinforced_wall")
							rw:setPosition(ent:getPosition())
							rw:spawn()
							ent:remove()
						end
				}
		}
	}
]]
--[[
	RECIPE

	`predicate`  (ent, act, item) = callback to check if the recipe is available given the entity's current state. If `predicate` is not a function, it is assumed to return true. (probably in the callback)
	`onActivate` (ent, act, item) = callback when the predicate succeeds. Any item consumption should be done here
]]

require "engine.shared.entities"

local assert        = assert
local entities      = entities
local ipairs        = ipairs
local pairs         = pairs
local strFormat     = string.format
local tblShallowCopy = table.shallowcopy
local tblMerge      = table.merge
local tostring      = tostring
local type          = type
local typeof        = typeof

local recipeMT = {
	predicate  = function(ent, act, item) return true end,
	onActivate = function(ent, act, item) end
}

module "construction"

_lookup = _lookup or {}

function check(ent, activator)
	local recipes = _lookup[type(ent)]

	 -- if no recipes are registered for the exact entity type, try checking base classes
	if (type(recipes) ~= "table") then
		local found = false

		for k, v in pairs(_lookup) do
			if (typeof(ent, k)) then
				found = true
				recipes = v
				break
			end
		end

		if (not found) then return false end
	end

	-- TODO add more checks here for things like mech suits/vehicles
	-- what if the activator does not have arms? like a robot?
	local item = activator:getActiveHand():getItem()
	local itemType = type(item)
	local itemRecipes = recipes[itemType]

	 -- if no recipe is registered for the exact item type, try checking base classes
	if (type(itemRecipes) ~= "table") then
		local found = false

		for k,v in pairs(recipes) do
			if (typeof(itemType, k)) then
				found = true
				itemRecipes = v
				break
			end
		end

		if (not found) then return false end
	end

	for _, recipe in ipairs(itemRecipes) do
		if (recipe.predicate(ent, activator, item)) then
			--[[
			-- DEPRECATED, moved to `onActivate`
			-- TODO maybe revisit this later. One idea I had was to make `onActivate` return a table of items to spawn,
			--	however one problem was dealing with things like metal sheets which have a quantity but are represented by a single entity.
			--	One solution I had was to make `onActivate` return a mixed table of strings/pairs/tuples like `wall = { "girder" , { "metal_sheet", 10 } }`
			--	"girder" would be treated as an object to spawn in. "metal_sheet" would be treated the same, except the "10" would be passed to a "setup" function.

			local res = nil
			if (type(recipe.result) == "string") then
				assert(tblHasValue(entsGetAll(), recipe.result), strFormat("Result entity %q does not exist for recipe %s|%s", recipe.result, type(ent), itemType))

				-- TODO how does `ent` rotation translate to `res` rotation?
				local pos = ent:getPosition()
				ent:remove()
				res = entity.create(recipe.result)
				res:setPosition(pos)
				res:spawn()
			end

			if (type(recipe.onActivate) == "function") then recipe.onActivate(ent, activator, res) end
			]]

			recipe.onActivate(ent, activator, item)
		end
	end

	return true
end

local function registerItem(entType, itemType, recipeTbl)
	local allEnts = entities.getAll()
	entities.require(itemType)
	--assert(tblHasValue(allEnts, itemType), strFormat("Invalid item type %q for recipe %q", itemType, entType))

	local newRecipe = tblShallowCopy(recipeMT)
	tblMerge(newRecipe, recipeTbl)

	_lookup[entType][itemType] = _lookup[entType][itemType] or {}
	table.insert(_lookup[entType][itemType], newRecipe)
end

function register(entType, recipesTbl)
	local allEnts = entities.getAll()
	-- TODO RE-ENABLE THIS FOR PROD. Needs to defer actual registration until after all entities are loaded.
	--assert(not tblHasValue(allEnts, entType), strFormat("Invalid entity type %q for recipe", entType))
	assert(type(recipesTbl) == "table", strFormat("\"recipeTbl\" should be a table for recipe %q", entType))

	_lookup[entType] = _lookup[entType] or {}

	for itemType, recipeTbl in pairs(recipesTbl) do
		if (type(itemType) == "string") then
			registerItem(entType, itemType, recipeTbl)
		elseif (type(itemType) == "number") then -- if the itemType is a number, we expect `recipeTbl` to be `N = { items = { ... }, recipe = { ... } }`
			assert(type(recipeTbl.items) == "table") -- TODO add message
			assert(type(recipeTbl.recipe) == "table", strFormat("No recipe table found in %s/%s", entType, tostring(itemType))) -- TODO add message
			for _, itemType in ipairs(recipeTbl.items) do
				registerItem(entType, itemType, recipeTbl.recipe)
			end
		end
	end
end

function clear()
	_lookup = {}
end
