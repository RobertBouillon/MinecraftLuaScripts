require "tl/Factory"
require "tl/Storage"
local skies = require("tl/Factory/Packs/SkiesExpert")

local storage = Storage.new("functionalstorage:storage_controller_4")
local factory = Factory.new(storage)

factory:addRecipes(skies.recipes)
factory:detectMachines(skies.machines)
factory:make(200, skies.craftable.Potato)

factory:run()