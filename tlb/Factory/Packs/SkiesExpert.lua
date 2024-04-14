local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; require("tl/Factory")

local Things = {
   ManaPowder = Item.new("botania:mana_powder", "Mana Powder"),
   ForceSapling = Item.new("forcecraft:force_sapling", "Force Sapling"),
   ForceLog = Item.new("forcecraft:force_log", "Force Log"),
   ForcePlanks = Item.new("forcecraft:force_planks", "Force Planks"),
   GoldenPower = Item.new("forcecraft:golden_power_source", "Golden Power Source"),
   LDPE = Item.new("ftbskies:ldpe_sheet", "LDPE Sheet"),
   Duroplast = Item.new("immersiveengineering:plate_duroplast", "Duroplast Plate"),
   TinyRubber = Item.new("industrialforegoing:tinydryrubber", "Tiny Dry Rubber"),
   DryRubber = Item.new("industrialforegoing:dryrubber", "Dry Rubber"),
   Plastic = Item.new("industrialforegoing:plastic", "Plastic"),
   MenrilLog = Item.new("integrateddynamics:menril_log", "Menril Log"),
   MenrilSapling = Item.new("integrateddynamics:menril_sapling", "Menril Sapling"),
   MenrilCrystal = Item.new("integrateddynamics:crystalized_menril_chunk", "Crystalized Menril"),
   SulfurDust = Item.new("mekanism:dust_sulfur", "Sulfur Dust"),
   Mushroom = Item.new("minecraft:red_mushroom", "Mushroom"),
   Potato = Item.new("minecraft:potato", "Potato"),
   OakSapling = Item.new("minecraft:oak_sapling", "Oak Sapling"),
   OakLog = Item.new("minecraft:oak_log", "Oak Log"),
   Paper = Item.new("minecraft:paper", "Paper"),
   SilverIngot = Item.new("occultism:silver_ingot", "Silver Ingot"),
   RawSilver = Item.new("occultism:raw_silver", "Raw Silver"),
   Glycerol = Item.new("pneumaticcraft:glycerol", "Glycerol"),
   Sulfur = Item.new("thermal:sulfur", "Sulfur"),
   Cinnabar = Item.new("thermal:cinnabar", "Cinnabar"),
   Substrate = Item.new("mekanism:substrate", "Substrate"),
   Redstone = Item.new("minecraft:redstone", "Redstone"),
   BasicCircuit = Item.new("mekanism:basic_control_circuit", "Basic Circuit"),
   EmptyPCB = Item.new("pneumaticcraft:empty_pcb", "Empty PCB"),
   LogicCircuit = Item.new("immersiveengineering:logic_circuit", "Logic Circuit"),
   UpgradeMatrix = Item.new("pneumaticcraft:upgrade_matrix", "Upgrade Matrix"),
   Lapis = Item.new("minecraft:lapis_lazuli", "Lapis Lazuli"),
   Diamond = Item.new("minecraft:diamond", "Diamond"),
   Gold = Item.new("minecraft:gold_ingot", "Gold Ingot"),
   CertusCrystal = Item.new("ae2:certus_quartz_crystal", "Certus Crystal"),
   FluixCrystal = Item.new("ae2:certus_quartz_crystal", "Certus Crystal"),
   Solder = Item.new("ftbskies:conductive_soldering_alloy", "Solder"),
   Glowstone = Item.new("minecraft:glowstone", "Glowstone"),
   ChargedCertus = Item.new("ae2:charged_certus_quartz_crystal", "Charged Certus"),
   PolishedRose = Item.new("create:polished_rose_quartz", "Rose Quartz"),
   IesniumDust = Item.new("occultism:iesmium_dust", "Iesnium Dust"),
   SilverDust = Item.new("occultism:silver_dust", "Silver Dust"),
   FormationCore = Item.new("ae2:formation_core", "Formation Core"),
   AnnihilationCore = Item.new("ae2:annihilation_core", "Annihilation Core"),
   CalculationProcessor = Item.new("ae2:printed_calculation_processor", "Calculation Proc"),
   EngineeringProcessor = Item.new("ae2:printed_engineering_processor", "Engineering Proc"),
   LogicProcessor = Item.new("ae2:printed_logic_processor", "Logic Processor"),
   PrintedSilicon = Item.new("ae2:printed_silicon", "Printed Silicon"),

   LiquidForce = Fluid.new("forcecraft:fluid_force_source", "Fluid Force"),
   Polyethylene = Fluid.new("ftbskies:polyethylene", "Polyethylene"),
   MoltenSilver = Fluid.new("ftbskies:molten_silver", "Molten Silver"),
   Quicksilver = Fluid.new("hexerei:quicksilver_fluid", "Quicksilver Fluid"),
   Acetaldehyde = Fluid.new("immersiveengineering:acetaldehyde", "Acetaldehyde"),
   PhelonicResin = Fluid.new("immersiveengineering:phenolic_resin", "Phenolic Resin"),
   Latex = Fluid.new("industrialforegoing:latex", "Latex"),
   MenrilResin = Fluid.new("integrateddynamics:menril_resin", "Menril Resin"),
   Ethylene = Fluid.new("mekanism:ethene", "Ethene"),
   Water = Fluid.new("minecraft:water", "Water"),
   Lava = Fluid.new("minecraft:lava", "Lava"),
   Yeast = Fluid.new("pneumaticcraft:yeast_culture", "Yeast Culture"),
   VegetableOil = Fluid.new("pneumaticcraft:vegetable_oil", "Vegetable Oil"),
   Ethanol = Fluid.new("pneumaticcraft:ethanol", "Ethanol"),
   Biodiesel = Fluid.new("pneumaticcraft:biodiesel", "Biodiesel"),
   RedstoneAcid = Fluid.new("immersiveengineering:redstone_acid", "Redstone Acid"),
   Source = Fluid.new("starbunclemania:source_fluid", "Liquefied Source"),
   Fuel = Fluid.new("ad_astra:fuel", "Fuel"),
   EnergizedGlowstone = Fluid.new("thermal:glowstone", "Energized Glowstone"),
   VolatileRedstone = Fluid.new("ftbskies:volatile_redstone", "Volatile Redstone"),
   DestabilizedRedstone = Fluid.new("thermal:redstone", "Destabilized Redstone"),
}

local Machines = {

   SuperCooler = MachineType.new("Super Cooler", "ftbsba:super_cooler"),
   SporesRecreator = MachineType.new("Spores Recreator", "industrialforegoing:spores_recreator"),
   LatexProcessingUnit = MachineType.new("Latex Processing Unit", "industrialforegoing:latex_processing_unit"),
   MechanicalSqueezer = MachineType.new("Mechanical Squeezer", "integrateddynamics:mechanical_squeezer"),
   PhytogenicInsolator = MachineType.new("Phytogenic Insolator", "thermal:machine_insolator"),
   Pulverizer = MachineType.new("Pulverizer", "thermal:machine_pulverizer"),
   FluidEncapsulator = MachineType.new("Fluid Encapsulator", "thermal:machine_bottler"),
   RedstoneFurnace = MachineType.new("Redstone Furnace", "thermal:machine_furnace"),
   MagmaCrucible = MachineType.new("Magma Crucible", "thermal:machine_crucible"),
   Pyrolyzer = MachineType.new("Pyrolyzer", "thermal:machine_pyrolyzer"),
   FractioningStill = MachineType.new("Fractioning Still", "thermal:machine_refinery"),
   UVLightBox = MachineType.new("UV Light Box", "pneumaticcraft:uv_light_box"),
   Inscriber = MachineType.new("Inscriber", "ae2:inscriber"),
   DissolutionChamber = MachineType.new("Dissolution Chamber", "industrialforegoing:dissolution_chamber"),


   FluidExtractor = MachineType.new("Fluid Extractor", "industrialforegoing:fluid_extractor"),
   BlockPlacer = MachineType.new("Block Placer", "industrialforegoing:block_placer"),
   LiquidBlazeBurner = MachineType.new("Liquid Blaze Burner", "createaddition:liquid_blaze_burner"),
   Thermo = MachineType.new("Spores Recreator", "pneumaticcraft:thermopneumatic_processing_plant"),
   Mixer = MachineType.new("Fluid Mixer", "pneumaticcraft:fluid_mixer"),
   Crafter = MachineType.new("Crafter", "thermal:machine_crafter"),
   Crafter3 = MachineType.new("Crafter (3)", "rftoolsutility:crafter3"),
   CustomMachine = MachineType.new("Custom Machine", "custommachinery:custom_machine_tile"),
}

local CompositeMachines = {
   LatexMaker = MachineType.newComposite("Latex Maker", Machines.BlockPlacer, Machines.FluidExtractor),
   HotThermo = MachineType.newComposite("Hot Thermo", Machines.Thermo, Machines.LiquidBlazeBurner),
   FabricationMatrix = MachineType.newComposite("Fabrication Matrix", Machines.CustomMachine),
}




local ifclearer = function(machine, storage)
   local m = machine.storage[1]
   m.item:pushAll(storage.item)
   m.fluid:pushAll(storage.fluid)
end

Machines.LatexProcessingUnit.clearer = ifclearer
Machines.LatexProcessingUnit.worker = function(machine, storage)

   local m = machine.storage[1]

   m.item:pushSlots(storage.item, nil, 3)
   m.fluid:pullFill(storage.fluid, Things.Water, 1000)
   m.fluid:pullFill(storage.fluid, Things.Latex, 200, 1000)
end

Machines.SporesRecreator.clearer = ifclearer
Machines.SporesRecreator.worker = function(machine, storage)

   local m = machine.storage[1]
   m.item:pushSlots(storage.item, nil, 6)
   m.fluid:pullFill(storage.fluid, Things.Water, 500)
   m.item:pullFill(storage.item, Things.Mushroom, 3, 32, 64)
end


Machines.PhytogenicInsolator.worker = function(machine, storage, itemsIn)

   local item = storage.item
   local fluid = storage.fluid

   item:pullSlots(machine.storage[1].item, nil, 3)

   for _, thing in ipairs(itemsIn) do
      if thing:is("Item") then
         item:pushFill(machine.storage[1].item, thing, 1, 8, 16)
      elseif thing:is("Fluid") then
         fluid:pushFill(machine.storage[1].fluid, thing, nil, 8000)
      end
   end
end


CompositeMachines.LatexMaker.worker = function(machine, storage)
   local placer = machine.storage[1].item
   local extractor = machine.storage[2].fluid
   local s = storage

   placer:pullFill(s.item, Things.OakLog, nil, nil, 1)
   extractor:pushWhen(s.fluid, Things.Latex, 950)
end

CompositeMachines.LatexMaker.clearer = function(machine, storage)
   local placer = machine.storage[1].item
   local extractor = machine.storage[2].fluid
   local s = storage

   placer:pushAll(s.item, Things.OakLog)
   extractor:pushAll(s.fluid, Things.Latex)
end


Machines.DissolutionChamber.clearer = ifclearer
Machines.DissolutionChamber.worker = function(machine, storage, itemsIn)
   local s = storage
   local i = machine.storage[1].item
   local f = machine.storage[1].fluid

   local inv = i:list()


   for slot = 9, 11 do
      if inv[slot] ~= nil then i:push(s.item, slot) end
   end


   for _, thing in ipairs(itemsIn) do
      if thing:is("Fluid") then
         f:pullFill(s.fluid, thing, 2000)
      end
   end

   for slot = 1, 8 do
      if itemsIn[slot] ~= nil then
         i:pull(s.item, itemsIn[slot], 1, slot)
      end
   end
end



local function workPneumaticcraftMachine(machine, storage, itemsIn, itemsOut)
   local thermo = machine.storage[1]
   local s = storage

   if machine.delay == nil then
      machine.delay = Delay.new(20)
   end
   local delay = machine.delay
   if not delay:canRun() then return false end

   for _, thing in ipairs(itemsIn) do
      if thing:is("Item") then
         s.item:push(thermo.item, thing)
      else
         s.fluid:push(thermo.fluid, thing)
      end
   end

   s.fluid:pull(thermo.fluid)
   for _, thing in ipairs(itemsOut) do
      if thing:is("Item") then
         s.item:pull(thermo.item, 1)
         break
      end
   end
   return true
end

Machines.Thermo.worker = workPneumaticcraftMachine
Machines.Mixer.worker = workPneumaticcraftMachine

Machines.Thermo.clearer = function(machine, storage)
   local thermo = machine.storage[1]
   local s = storage

   s.fluid:pullAll(thermo.fluid)
   s.item:pull(thermo.item, 1)
end

Machines.Mixer.clearer = function(machine, storage)
   local thermo = machine.storage[1]
   local s = storage

   s.fluid:pullAll(thermo.fluid)
end


CompositeMachines.HotThermo.worker = function(machine, storage, itemsIn, itemsOut)
   local s = storage

   if workPneumaticcraftMachine(machine, storage, itemsIn, itemsOut) then
      local burner = machine.storage[2]
      s.fluid:pushFill(burner.fluid, Things.Biodiesel, 1000, 2000)
   end
end

CompositeMachines.HotThermo.clearer = function(machine, storage)
   local thermo = machine.storage[1]
   local burner = machine.storage[2]
   local s = storage

   s.fluid:pullAll(thermo.fluid)
   s.item:pull(thermo.item, 1)
   s.fluid:pullAll(burner.fluid)
end




Machines.Inscriber.worker = function(machine, storage, itemsIn)
   local s = storage
   local m = machine.storage[1].item

   local inv = m:list()

   if inv[4] ~= nil then s.item:pull(m, 4) end

   for slot = 1, 3 do
      if inv[slot] ~= nil and itemsIn[slot].name ~= inv[slot].name then s.item:pull(m, nil, nil, slot) end
      if inv[slot] == nil then s.item:push(m, itemsIn[slot], 1, slot) end
   end
end



local Recipes = {
   Recipe.new(Things.MenrilCrystal, Machines.MechanicalSqueezer, Things.MenrilLog),
   Recipe.new(Things.DestabilizedRedstone, Machines.FractioningStill, Things.VolatileRedstone),
   Recipe.new(Things.RedstoneAcid, Machines.FractioningStill, Things.VolatileRedstone),
   Recipe.new(Things.Biodiesel, Machines.Mixer, Things.VegetableOil, Things.Ethanol),
   Recipe.new(Things.LiquidForce, Machines.Pyrolyzer, Things.ForcePlanks),

   Recipe.new(Things.MenrilResin, Machines.MagmaCrucible, Things.MenrilCrystal),
   Recipe.new(Things.Mushroom, Machines.SporesRecreator, Things.Mushroom, Things.Water),
   Recipe.new(Things.Potato, Machines.PhytogenicInsolator, Things.Potato, Things.Water),
   Recipe.new(Things.OakLog, Machines.PhytogenicInsolator, Things.OakSapling, Things.Water),
   Recipe.new(Things.RawSilver, Machines.SuperCooler, Things.ManaPowder, Things.Quicksilver),
   Recipe.new(Things.Acetaldehyde, Machines.Mixer, Things.MoltenSilver, Things.Ethanol),
   Recipe.new(Things.PhelonicResin, Machines.Mixer, Things.Latex, Things.Acetaldehyde),
   Recipe.new(Things.Duroplast, Machines.FluidEncapsulator, Things.Paper, Things.PhelonicResin),
   Recipe.new(Things.TinyRubber, Machines.LatexProcessingUnit, Things.Latex, Things.Water),
   Recipe.new(Things.Yeast, Machines.Thermo, Things.Mushroom, Things.Water),
   Recipe.new(Things.VegetableOil, Machines.Thermo, Things.Potato),
   Recipe.new(Things.Ethanol, Machines.Thermo, Things.Potato, Things.Yeast),
   Recipe.new(Things.Polyethylene, Machines.Mixer, Things.Ethylene, Things.Latex),
   Recipe.new(Things.MenrilLog, Machines.PhytogenicInsolator, Things.MenrilSapling, Things.Water),
   Recipe.new(Things.ForceLog, Machines.PhytogenicInsolator, Things.ForceSapling, Things.Water),
   Recipe.new(Things.ForcePlanks, Machines.Crafter3, Things.ForceLog),
   Recipe.new(Things.DryRubber, Machines.Crafter3, Things.TinyRubber),
   Recipe.new(Things.Plastic, Machines.RedstoneFurnace, Things.DryRubber),
   Recipe.new(Things.LDPE, Machines.FluidEncapsulator, Things.Plastic, Things.Polyethylene),
   Recipe.new(Things.MoltenSilver, Machines.MagmaCrucible, Things.SilverIngot),
   Recipe.new(Things.BasicCircuit, Machines.FluidEncapsulator, Things.LogicCircuit, Things.MenrilResin),
   Recipe.new(Things.EmptyPCB, Machines.FluidEncapsulator, Things.LogicCircuit, Things.DestabilizedRedstone),
   Recipe.new(Things.Fuel, Machines.Mixer, Things.Source, Things.Biodiesel),
   Recipe.new(Things.UpgradeMatrix, Machines.Thermo, Things.Water, Things.Lapis),
   Recipe.new(Things.EnergizedGlowstone, Machines.MagmaCrucible, Things.Glowstone),




   Recipe.new(Things.CalculationProcessor, Machines.Inscriber, Things.CertusCrystal, Things.PrintedSilicon, Things.Solder),
   Recipe.new(Things.EngineeringProcessor, Machines.Inscriber, Things.Diamond, Things.PrintedSilicon, Things.Solder),
   Recipe.new(Things.LogicProcessor, Machines.Inscriber, Things.Gold, Things.PrintedSilicon, Things.Solder),


   Recipe.new(Things.FluixCrystal, Machines.Inscriber, Things.Gold, Things.PrintedSilicon, Things.Solder),


   Recipe.new(Things.Latex, CompositeMachines.LatexMaker, Things.OakLog, Things.Water),
   Recipe.new(Things.Quicksilver, CompositeMachines.HotThermo, Things.Cinnabar, Things.MenrilResin),
   Recipe.new(Things.Ethylene, CompositeMachines.HotThermo, Things.SulfurDust, Things.Ethanol),
   Recipe.new(Things.VolatileRedstone, CompositeMachines.HotThermo, Things.Acetaldehyde, Things.Redstone),

   Recipe.new(Things.IesniumDust, CompositeMachines.FabricationMatrix, Things.SilverDust, Things.LiquidForce),
   Recipe.new(Things.FormationCore, CompositeMachines.FabricationMatrix, Things.ChargedCertus, Things.EnergizedGlowstone),
   Recipe.new(Things.AnnihilationCore, CompositeMachines.FabricationMatrix, Things.PolishedRose, Things.EnergizedGlowstone),
}

Recipes[1].itemsOut = { Things.MenrilCrystal, Things.MenrilResin }
Recipes[2].itemsOut = { Things.Substrate, Things.DestabilizedRedstone, Things.RedstoneAcid }
Recipes[3].itemsOut = { Things.Substrate, Things.DestabilizedRedstone, Things.RedstoneAcid }
Recipes[4].itemsOut = { Things.Biodiesel, Things.Glycerol }
Recipes[5].itemsOut = { Things.LiquidForce, Things.GoldenPower }

return {
   recipes = Recipes,
   machines = {
      HotThermo = CompositeMachines.HotThermo,
      LatexMaker = CompositeMachines.LatexMaker,
      FabricationMatrix = CompositeMachines.FabricationMatrix,
   },
   detectable = {
      Machines.SuperCooler,
      Machines.SporesRecreator,
      Machines.MechanicalSqueezer,
      Machines.LatexProcessingUnit,
      Machines.PhytogenicInsolator,
      Machines.Pulverizer,
      Machines.FluidEncapsulator,
      Machines.RedstoneFurnace,
      Machines.MagmaCrucible,
      Machines.Pyrolyzer,
      Machines.Crafter3,
      Machines.FractioningStill,
      Machines.Inscriber,
   },
   craftable = {
      Mushroom = Things.Mushroom,
      Potato = Things.Potato,
      OakLog = Things.OakLog,
      RawSilver = Things.RawSilver,
      Quicksilver = Things.Quicksilver,
      Acetaldehyde = Things.Acetaldehyde,
      PhelonicResin = Things.PhelonicResin,
      Duroplast = Things.Duroplast,
      TinyRubber = Things.TinyRubber,
      Yeast = Things.Yeast,
      VegetableOil = Things.VegetableOil,
      Ethanol = Things.Ethanol,
      Biodiesel = Things.Biodiesel,
      Ethylene = Things.Ethylene,
      Polyethylene = Things.Polyethylene,
      MenrilLog = Things.MenrilLog,
      ForceLog = Things.ForceLog,
      ForcePlanks = Things.ForcePlanks,
      DryRubber = Things.DryRubber,
      Plastic = Things.Plastic,
      LDPE = Things.LDPE,
      MoltenSilver = Things.MoltenSilver,
      MenrilResin = Things.MenrilResin,
      MenrilCrystal = Things.MenrilCrystal,
      LiquidForce = Things.LiquidForce,
      Latex = Things.Latex,
      DestabilizedRedstone = Things.DestabilizedRedstone,
      RedstoneAcid = Things.RedstoneAcid,
      VolatileRedstone = Things.VolatileRedstone,
      BasicCircuit = Things.BasicCircuit,
      EmptyPCB = Things.EmptyPCB,
      Fuel = Things.Fuel,
      UpgradeMatrix = Things.UpgradeMatrix,
      CalculationProcessor = Things.CalculationProcessor,
      EngineeringProcessor = Things.EngineeringProcessor,
      LogicProcessor = Things.LogicProcessor,
      EnergizedGlowstone = Things.EnergizedGlowstone,
      IesniumDust = Things.IesniumDust,
      FormationCore = Things.FormationCore,
      AnnihilationCore = Things.AnnihilationCore,
   },
}
