--cc:Tweaked: AE2 Inscriber Automation
--pastebin get 2M3g5Q16 inscriber.lua
--inscriber

local sides = require("sides")
local inventory = require("inventory")

local SILICON_PRESS = 			"ae2:silicon_press"
local ENGINEERING_PRESS = 		"ae2:engineering_processor_press"
local LOGIC_PRESS = 			"ae2:logic_processor_press"
local CALCULATION_PRESS =   	"ae2:calculation_processor_press"

local LOGIC_CIRCUIT =			"ae2:printed_logic_processor"
local ENGINEERING_CIRCUIT = 	"ae2:printed_engineering_processor"
local CALCULATION_CIRCUIT = 	"ae2:printed_calculation_processor"
local SILICON_CIRCUIT = 		"ae2:printed_silicon"

local SILICON = 				"ftbic:silicon"
local DIAMOND = 				"minecraft:diamond"
local GOLD = 					"minecraft:gold_ingot"
local CERTUS_QUARTZ = 			"ae2:certus_quartz_crystal"
local REDSTONE = 				"minecraft:redstone"

local PRINTED_SILICON_RECIPE = 				{ SILICON_PRESS,		SILICON }
local PRINTED_ENGINEERING_CIRCUIT_RECIPE = 	{ ENGINEERING_PRESS, 	DIAMOND }
local PRINTED_LOGIC_CIRCUIT_RECIPE = 		{ LOGIC_PRESS,			GOLD }
local PRINTED_CALCULATION_CIRCUIT_RECIPE = 	{ CALCULATION_PRESS,	CERTUS_QUARTZ }

local LOGIC_PROCESSOR_RECIPE = 				{ LOGIC_CIRCUIT,		REDSTONE,	SILICON_CIRCUIT }
local CALCULATION_PROCESSOR_RECIPE = 		{ CALCULATION_CIRCUIT,	REDSTONE, 	SILICON_CIRCUIT }
local ENGINEERING_PROCESSOR_RECIPE = 		{ ENGINEERING_CIRCUIT, 	REDSTONE, 	SILICON_CIRCUIT }

local RECIPES = {
	PRINTED_SILICON_RECIPE,
	PRINTED_ENGINEERING_CIRCUIT_RECIPE,
	PRINTED_LOGIC_CIRCUIT_RECIPE,
	PRINTED_CALCULATION_CIRCUIT_RECIPE,
	LOGIC_PROCESSOR_RECIPE,
	CALCULATION_PROCESSOR_RECIPE,
	ENGINEERING_PROCESSOR_RECIPE
}

local chest 	= inventory.wrap(sides.left)
local inscriber = inventory.wrap(sides.right)
local slots 	= { 1,3,2 }

local function canMake(recipe,loaded,avail)
	for slot,ingredient in pairs(recipe) do
		local isLoaded = stacksEqual(ingredient, loaded[slots[slot]])
		if not isLoaded then
			if avail[ingredient] == nil then return false end
		end
	end
	return true
end

local function canMakeSomething()
	local loaded = inscriber.list()
	local avail = chest.counts()
	
	for _,recipe in pairs(RECIPES) do
		if canMake(recipe,loaded,avail) then return true, recipe end
	end
	return false
end

local function make(recipe)
	for n=1,3 do
		local inscriberSlot	= slots[n]
		local ingredient 	= recipe[n]
		local itemInSlot 	= inscriber.item(inscriberSlot)
		local isLoaded 		= stacksEqual(ingredient, itemInSlot)
		
		if not isLoaded then
			if itemInSlot ~= ingredient and itemInSlot ~= nil then repeat chest.pull(inscriber, inscriberSlot) until inscriber.item(inscriberSlot) == nil end
			if ingredient ~= nil then
				repeat 
					local found, slot = chest.find(ingredient)
					if not found then return end
				until chest.push(inscriber, slot, 1, inscriberSlot)
			end
		end
	end
end

local function takeProduct()
	chest.pull(inscriber, 4)
end
	
while true do
	local canMake, recipe = canMakeSomething()
	
	if canMake then
		repeat takeProduct() until not make(recipe)
	end
	takeProduct() 
end