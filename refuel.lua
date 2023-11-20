--cc:Tweaked: Turtle Refueler
--pastebin get SB98ccny refuel.lua

local inventory = require("inventory")

local COAL 			= { name = "minecraft:coal" }
local COAL_BLOCK	= { name = "minecraft:coal_block" }
local CHARCOAL		= { name = "minecraft:charcoal" }

local FUELS = { COAL, COAL_BLOCK, CHARCOAL }

function isFull()
	return turtle.getFuelLevel() == turtle.getFuelLimit()
end

for cindex, ifuel in pairs(FUELS) do
	while turtle.items.select(ifuel) == true and not isFull() do
		turtle.refuel()
	end
end

print(turtle.getFuelLevel() .. "/" .. turtle.getFuelLimit() .. " fuel")
local tofill = turtle.getFuelLimit() - turtle.getFuelLevel()
local amt = math.floor(tofill / 80)
if amt > 0 then
	print(amt .. " coal to refuel turtle")
end
