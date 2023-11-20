--cc:Tweaked: Passage
--pastebin get xzvapSjN passage.lua
--passage 10

local nav = require("navigation")
local inv = require("inventory")
local timer = require("timer")
local sides = require("sides")

local COBBLE = { name = "minecraft:cobblestone" }
local GLASS= { name = "minecraft:glass" }



function place(item)
	if turtle.detect() then turtle.dig() end
	if not inv.findAndSelect(item) then return false end
	
	turtle.place()
	return true
end


function placeDown(item)
	if turtle.detectDown() then turtle.digDown() end
	if not inv.findAndSelect(item) then return false end
	
	turtle.placeDown()
	return true
end

function placeUp(item)
	if turtle.detectDown() then turtle.digDown() end
	if not inv.findAndSelect(item) then return false end
	
	turtle.placeUp()
	return true
end

function placeLeft(item)
	nav.turnTo(sides.left)
	return place(item)
end

function placeRight(item)
	nav.turnTo(sides.right)
	return place(item)
end


local length = 0
local windowEvery = 5



local function checkParameters(length, windowEvery)
	--local fuelNeeded = (length * 3) + 1  -- 1 for endcap
	--checkFuel(fuelNeeded)
	
	local glassNeeded = math.ceil(length / windowEvery) * 2 + 1  -- plus one for endcap
	local glassIHave = inv.count(GLASS)
	if glassIHave < glassNeeded then
		print("Please add "..(glassNeeded - glassIHave).." more glass")
		return false
	end
	
	local bricksNeeded = length * 6 - glassNeeded + 1 -- plus one for endcap
	local bricksIHave = inv.count(COBBLE)
	if bricksIHave < bricksNeeded then
		print("Please add "..(bricksNeeded - bricksIHave).." more cobblestone")
		return false
	end
	
	return true
	
end

local function surround(window)
	WINDOW = GLASS
	if not window then WINDOW = COBBLE end

	placeDown(COBBLE)
	placeLeft(COBBLE)
	nav.up()
	placeLeft(WINDOW)
	placeUp(COBBLE)
	placeRight(WINDOW)
	nav.down()
	placeRight(COBBLE)
end


---- Main Loop
local tArgs = { ... }

if #tArgs ~= 2 then
		print( "Usage: passage <distance> <window every n>" )
		return false
end

-- Mine in a quarry pattern until we hit something we can't dig
local length 		= tonumber( tArgs[1] )
local windowEvery 	= tonumber( tArgs[2] )

if not checkParameters(length, windowEvery) then return end

timer.start()

for n=1,length do
	nav.turnTo(sides.front)
	nav.forward()
	surround(n % windowEvery == 0)
end

nav.turnTo(sides.front)
place(COBBLE)
nav.up()
place(GLASS)
nav.down()

print("Completed in "..timer.format())
