local tl = require("tl")
tl.loader()

require "v2/Factory"
local skies = require("v2/Factory/Packs/SkiesExpert")

local storage = Storage.new("functionalstorage:storage_controller_4")
local factory = Factory.new(storage)

factory:addRecipes(skies.recipes)
factory:detectMachines(skies.machines)
factory:make(20, skies.craftable.Potato)

factory:run()