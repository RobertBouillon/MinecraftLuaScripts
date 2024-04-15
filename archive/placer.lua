--cc:Tweaked: Placer
--pastebin get WVVD4F6f placer.lua
--placer

local sides = require("sides")
local inventory = require("inventory")
local timer = require("timer")

------------------ Main Routines

print("Insert item to place in FIRST slot")
print()
print("Press enter when ready")
io.read()

local plant = turtle.getItemDetail(1).name

print("Placing  "..plant.." ...")

timer.start()
while true
do
    turtle.items.select(plant)
    repeat until turtle.place()
end

turtle.dig()
print("Finished in ".. timer.format())