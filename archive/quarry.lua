--cc:Tweaked: Quarry Program for Turtle
--pastebin get UfndbHaX quarry.lua
--quarry 10 10 10

local sides = require("sides")
local nav = require("navigation")
local inventory = require("inventory")
local timer = require("timer")

local clearEverything = false
local OK_EMPTY_SLOTS = 4 --The number of empty slots after dropping crap necessary to continue mining

local STONE = 			{ name = "minecraft:stone" }
local DIRT = 			{ name = "minecraft:dirt" }
local GRASS = 			{ name = "minecraft:grass_block"}
local COBBLE = 			{ name = "minecraft:cobblestone" }
local GRAVEL = 			{ name = "minecraft:gravel" }
local SAND = 			{ name = "minecraft:sand" }
local SANDSTONE = 		{ name = "minecraft:sandstone" }
local NETHERRACK = 		{ name = "minecraft:netherrack" }
local DIORITE = 		{ name = "minecraft:diorite" }
local ANDESITE = 		{ name = "minecraft:andesite" }
local GRANITE = 		{ name = "minecraft:granite" }
local COAL = 			{ name = "minecraft:coal" }
local GRANITE_C = 		{ name = "create:granite_cobblestone" }
local ANDESITE_C = 		{ name = "create:andesite_cobblestone" }
local DIORITE_C = 		{ name = "create:diorite_cobblestone" }
local STELLA_ARC = 		{ name = "forbidden_arcanus:stella_arcanum" }
local BEDROCK = 		{ name = "minecraft:bedrock" }
local COARSE_DIRT = 	{ name = "minecraft:coarse_dirt" }
local TUFF = 			{ name = "minecraft:tuff" }
local DEEPSLATE_C = 	{ name = "minecraft:cobbled_deepslate" }
local DEEPSLATE =   	{ name = "minecraft:deepslate" }
local LIMESTONE =   	{ name = "create:limestone" }
local CALCITE =     	{ name = "minecraft:calcite" }
local SMOOTH_BASALT = 	{ name = "minecraft:smooth_basalt" }
local RED_SAND = 		{ name = "minecraft:red_sand" }
local YELLOW_TC = 		{ name = "minecraft:yellow_terracotta" }

 
local crap = { 
	STONE, 
	DIRT, 
	GRASS, 
	COBBLE, 
	GRAVEL, 
	SAND, 
	SANDSTONE, 
	NETHERRACK, 
	DIORITE, 
	ANDESITE, 
	GRANITE, 
	GRANITE_C, 
	ANDESITE_C, 
	DIORITE_C,
	STELLA_ARC,
	BEDROCK,
	COARSE_DIRT,
	TUFF,
	DEEPSLATE_C,
	DEEPSLATE,
	LIMESTONE,
	CALCITE,
	SMOOTH_BASALT,
	RED_SAND,
	YELLOW_TC 
}
	
local danger = { STELLA_ARC, BEDROCK }


local function showFinalMessage()
	print("completed in " .. timer.format() .. " with " .. turtle.getFuelLevel() .. " fuel remaining")
end

local function abort(reason)
	nav.turnTo(sides.front)
	showFinalMessage()
	error(reason)
end

local function isCrap(item)
	for _, icrap in pairs(crap) do
		if stacksEqual(icrap, item) then
			return true
		end
	end
	return false
end

local function isDangerous(item)
	for _, idanger in pairs(danger) do
		if stacksEqual(idanger, item) then
			return true, item
		end
	end
	return false
end

local function dropCrap()
	local dropped = false
	for n=1,16 do
		if turtle.getItemCount(n) > 0 then
			if isCrap(turtle.getItemDetail(n, true)) then
				turtle.select(n)
				turtle.dropUp()
				dropped = true
			end
		end
	end
	return dropped
end

local function unload()
	local facing = nav.getDirection()
	local position = nav.getPosition()
	moveTo({x=0,y=0})
	moveTo({z=0})
	nav.turnTo(sides.left)
	dropCrap() --HACK: Can pick up crap en route back
	if not turtle.items.depositAll(sides.front) then abort("Inventory full") end
	moveTo(position)
	nav.turnTo(facing)
end

local function checkInventory()
	if turtle.items.isFull() then
		dropCrap()
    turtle.items.compact()
		
		if turtle.items.count() >= turtle.items.size() - OK_EMPTY_SLOTS then 
			unload() 
		end
	end
end

local function digUp()
	local exists,item = turtle.inspectUp()
	if(exists and (clearEverything or not isCrap(item))) then
		turtle.digUp()
	end
end

local function digDown()
	local exists,item = turtle.inspectDown()
	if(exists and (clearEverything or not isCrap(item))) then
		turtle.digDown()
	end
end

local function getRequiredFuelLevel(x,y,z)
	return x * y * (z / 3) + 200
end

local function flee(reason)
	if nav.getPosition().y == 0 then 
		nav.up()
		nav.up()
		nav.up()
	end
	nav.moveTo({x=0})
	nav.moveTo({y=0})
	nav.moveTo({z=0})
	dropCrap()
	unload()
	abort(reason)
end

local function fleeBlock(block)
	flee("Encountered " .. block.name .. " at level " .. nav.getPosition().z)
end

local function isDangerAhead()
	local exists,item = turtle.inspect()
	if exists then
		return isDangerous(item)
	end
	return false
end

local function forward()
	local danger, item = isDangerAhead()
	if danger then fleeBlock(item) end
	nav.forward()
end

local function isDangerDown()
	local exists,item = turtle.inspectDown()
	if exists then
		return isDangerous(item)
	end
	return false
end

local function down()
	local danger, item = isDangerDown()
	if isDangerDown() then fleeBlock(item) end
	nav.down()
end

local function isDangerUp()
	local exists,item = turtle.inspectUp()
	if exists then
		return isDangerous(item)
	end
	return false
end

local function up()
	local danger, item = isDangerUp()
	if danger then fleeBlock(item) end
	nav.up()
end


function moveTo(position)
	local navOffset = nav.getPosition()
	position = navOffset.union(position)
	local delta = position.subtract(navOffset)
	
	if delta.z > 0 then
		for i=1,delta.z do up() end
	elseif delta.z < 0 then
		for i=1,-delta.z do down() end
	end

	if delta.x > 0 then
		nav.turnTo(sides.right)
		for i=1,delta.x do forward() end
	elseif delta.x < 0 then
		nav.turnTo(sides.left)
		for i=1,-delta.x do forward() end
	end
	
	if delta.y > 0 then
		nav.turnTo(sides.front)
		for i=1,delta.y do forward() end
	elseif delta.y <0 then
		nav.turnTo(sides.back)
		for i=1,-delta.y do forward() end
	end
end

------------------------------------  MAIN ROUTINES
 
local tArgs = { ... }

if #tArgs ~= 3 then
        print( "Usage: quarry <depth> <distance> <width>" )
        return
end

-- Mine in a quarry pattern until we hit something we can't dig
local depth 	= tonumber( tArgs[1] )
local distance 	= tonumber( tArgs[2] )
local width 	= tonumber( tArgs[3] )

--Validation
if depth < 1 then
        print( "Quarry depth must be greater than 0" )
        return
end

if distance < 1 then
        print( "Quarry distance must be greater than 0" )
        return
end

if width < 1 then
        print( "Quarry width must be greater than 0" )
        return
end
 
if width % 2 == 1 then
        print( "Quarry width must be an even number" )
        return
end


if turtle.getFuelLevel() < getRequiredFuelLevel(width,distance,depth) then
	local fuelRequired = getRequiredFuelLevel(width,distance,depth)
	io.write("Not enough fuel (" .. fuelRequired .. " required)\n")
	return
end

if inventory.wrap(sides.left) == nil then
	io.write("Chest required to the left of turtle\n")
	return
end

turtle.select(1)
local zs = -math.floor(depth / 3) -- We mine straight, up, and down
local xs = width / 2 -- a zig and a zag
timer.start()

for z=1,zs,-1 do
	moveTo({z=(z-1)*3-3})
	for x=1,xs do
		moveTo({x=(x-1)*2})
		nav.turnTo(sides.front)
		
		digUp()
		digDown()
		for y=1,distance do
			forward()
			digUp()
			digDown()
			checkInventory()
		end

		moveTo({x=(x-1)*2+1})
		nav.turnTo(sides.back)
		for n=1,distance do
			digUp()
			digDown()
			forward()
			checkInventory()
		end
		digUp()
		digDown()

		moveTo({y=0}) --HACK: Ensure we reset
	end
end

dropCrap()
nav.moveHome()
unload()
nav.turnTo(sides.front)
showFinalMessage()
