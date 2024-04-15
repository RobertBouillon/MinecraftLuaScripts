--cc:Tweaked: Fast Farmer
--pastebin get mseF1Kbc farm.lua
--farm

local sides = require("sides")
local inventory = require("inventory")
local timer = require("timer")

------------------ Main Routines

print("Place a fully grown plant IN FRONT of the turtle")
print("Place seed in FIRST slot")
print("Place fertilizer in SECOND slot")
print()
print("Press enter when ready")
io.read()

local _,plant = turtle.inspect()
plant = plant.name

local seed = turtle.getItemDetail(1).name
local fertilizer = turtle.getItemDetail(2).name

print("Planting "..plant.." using "..seed.." and "..fertilizer)

timer.start()
while(turtle.items.count(seed) > 0 and turtle.items.count(fertilizer) > 0)
do
	turtle.dig()

	turtle.items.select(seed)
	repeat until turtle.place()

	repeat 
		turtle.items.select(fertilizer)
		repeat until turtle.place()

		_,growing = turtle.inspect()
	until (growing.name == plant and (growing.state.age == nil or growing.state.age == 7))
end

turtle.dig()
print("Finished in ".. timer.format())