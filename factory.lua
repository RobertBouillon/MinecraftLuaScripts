require "tl/Factory"
require "tl/Storage"
local skies = require("tl/Factory/Packs/SkiesExpert")

local storage = Storage.new("functionalstorage:storage_controller_1")
local factory = Factory.new(storage)

local Things = skies.craftable

factory:addRecipes(skies.recipes)
factory:detectMachines(skies.detectable)

factory:addCompositeMachine(skies.machines.LatexMaker, 1, 1)
factory:addCompositeMachine(skies.machines.FabricationMatrix, 1)

-- Hot Thermo
factory:addDedicatedMachine(Things.VolatileRedstone, 12, 1)
factory:addDedicatedMachine(Things.Quicksilver,   17, 4)
factory:addDedicatedMachine(Things.Ethylene,      10, 1)

-- Thermo
factory:addDedicatedMachine(Things.Yeast,         15)
factory:addDedicatedMachine(Things.VegetableOil,  13)
factory:addDedicatedMachine(Things.Ethanol,       14)
factory:addDedicatedMachine(Things.UpgradeMatrix, 11)

-- Mixer
factory:addDedicatedMachine(Things.Acetaldehyde,   3)
factory:addDedicatedMachine(Things.PhelonicResin,  4)
factory:addDedicatedMachine(Things.Biodiesel,      5)
factory:addDedicatedMachine(Things.Polyethylene,   6)
factory:addDedicatedMachine(Things.Fuel,           8)


factory:make(2000000, Things.Latex)
factory:make(5000000, Things.Biodiesel)

factory:make(200000, Things.Quicksilver)
factory:make(20000, Things.Acetaldehyde)
factory:make(20000, Things.PhelonicResin)
factory:make(20000, Things.VegetableOil)
factory:make(20000, Things.Yeast)
factory:make(20000, Things.Ethanol)
factory:make(20000, Things.Ethylene)
factory:make(200000, Things.Polyethylene)
factory:make(20000, Things.MoltenSilver)
factory:make(20000, Things.MenrilResin)
factory:make(2000000, Things.LiquidForce)
factory:make(20000, Things.DestabilizedRedstone)
factory:make(20000, Things.RedstoneAcid)
factory:make(20000, Things.VolatileRedstone)
factory:make(80000, Things.Fuel)
factory:make(400000, Things.EnergizedGlowstone)

factory:make(200, Things.Mushroom)
factory:make(200, Things.Potato)
factory:make(200, Things.OakLog)
factory:make(0, Things.RawSilver)
factory:make(200, Things.Duroplast)
factory:make(200, Things.TinyRubber)
factory:make(200, Things.MenrilLog)
factory:make(200, Things.ForceLog)
factory:make(200, Things.ForcePlanks)
factory:make(200, Things.DryRubber)
factory:make(500, Things.Plastic)
factory:make(200, Things.LDPE)
factory:make(200, Things.MenrilCrystal)
factory:make(2, Things.EmptyPCB)
factory:make(16, Things.BasicCircuit)
factory:make(52, Things.UpgradeMatrix)
--factory:make(100, Things.IesniumDust) --Recipes need minimum quantities
factory:make(16, Things.FormationCore)
factory:make(16, Things.AnnihilationCore)



factory:make(8, Things.CalculationProcessor)
factory:make(8, Things.EngineeringProcessor)
factory:make(8, Things.LogicProcessor)



factory:run()
