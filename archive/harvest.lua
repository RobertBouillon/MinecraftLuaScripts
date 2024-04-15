--cc:Tweaked: Fast Farmer
--pastebin get hn9wpSN1 harvest.lua
--harvest

local sides = require("sides")
local inventory = require("inventory")
local timer = require("timer")

------------------ Main Routines

print("Ensure item to harvest is IN FRONT of the turtle")
print()
print("Press enter when ready")
io.read()

local _,plant = turtle.inspect()
plant = plant.name

print("Harvesting  "..plant.."... ")

timer.start()
while true
do
	turtle.dig()

	repeat 
		_,growing = turtle.inspect()
	until (growing.name == plant and (growing.state.age == nil or growing.state.age == 7))
end

turtle.dig()
print("Finished in ".. timer.format())