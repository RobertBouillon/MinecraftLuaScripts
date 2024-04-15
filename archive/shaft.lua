--cc:Tweaked: Passage
--pastebin get jE59aCsf shaft.lua
--shaft

local nav =     require("navigation")
local inv =     require("inventory")
local timer =   require("timer")
local sides =   require("sides")

local COBBLE =      { name = "minecraft:cobblestone" }
local BEDROCK =     { name = "minecraft:bedrock" }

function place(item)
	if not turtle.items.select(item) then return false end
	if not turtle.detect() then turtle.place() end
	return true
end

local function atBedrock()
    local blocked, item = turtle.inspectDown()
    if not blocked then return false end
    return stacksEqual(item, BEDROCK)
end

---- Main Loop
timer.start()
local depth = 0

while not atBedrock() do
    nav.down()
    place(COBBLE)
    depth = depth + 1
end

turtle.turnLeft()
for n=1,depth do
    nav.up()
    place(COBBLE)
end

turtle.turnLeft()
for n=1,depth do
    nav.down()
    place(COBBLE)
end

turtle.turnLeft()
for n=1,depth do
    nav.up()
    place(COBBLE)
end

turtle.turnLeft()
nav.moveHome()  --API can be wonky sometimes and not move properly. Ensure we actually made it home.

print("Completed in "..timer.format())
