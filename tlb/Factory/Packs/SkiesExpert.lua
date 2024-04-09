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
}

local Machines = {

   SuperCooler = MachineType.new("Super Cooler", "rftoolsutility:ftbsba:super_cooler"),
   SporesRecreator = MachineType.new("Spores Recreator", "industrialforegoing:spores_recreator"),
   LatexProcessingUnit = MachineType.new("Latex Processing Unit", "industrialforegoing:latex_processing_unit"),
   MechanicalSqueezer = MachineType.new("Mechanical Squeezer", "integrateddynamics:mechanical_squeezer"),
   PhytogenicInsolator = MachineType.new("Phytogenic Insolator", "thermal:machine_insolator"),
   Pulverizer = MachineType.new("Pulverizer", "thermal:machine_pulverizer"),
   FluidEncapsulator = MachineType.new("Fluid Encapsulator", "thermal:machine_bottler"),
   RedstoneFurnace = MachineType.new("Redstone Furnace", "thermal:machine_furnace"),
   MagmaCrucible = MachineType.new("Magma Crucible", "thermal:machine_crucible"),
   Pyrolyzer = MachineType.new("Pyrolyzer", "thermal:machine_pyrolyzer"),


   FluidExtractor = MachineType.new("Fluid Extractor", "industrialforegoing:fluid_extractor"),
   BlockPlacer = MachineType.new("Block Placer", "industrialforegoing:block_placer"),
   LiquidBlazeBurner = MachineType.new("Liquid Blaze Burner", "createaddition:liquid_blaze_burner"),
   Thermo = MachineType.new("Spores Recreator", "pneumaticcraft:thermopneumatic_processing_plant"),
   Mixer = MachineType.new("Latex Processing Unit", "pneumaticraft:latex_processing_unit"),
   Crafter = MachineType.new("Crafter", "thermal:machine_crafter"),
   Crafter3 = MachineType.new("Crafter (3)", "rftoolsutility:crafter3"),
}

local CompositeMachines = {
   LatexMaker = MachineType.newComposite("Latex Maker", Machines.BlockPlacer, Machines.FluidExtractor),
   HotThermo = MachineType.newComposite("Hot Thermo", Machines.Thermo, Machines.LiquidBlazeBurner),
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
   m.fluid:pullFill(storage.fluid, Things.Water, 500)
   m.fluid:pullFill(storage.fluid, Things.Latex, 500)
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


CompositeMachines.HotThermo.worker = function(machine, storage, itemsIn, itemsOut)
   local thermo = machine.storage[1]
   local burner = machine.storage[2]
   local s = storage

   if machine.delay == nil then
      machine.delay = Delay.new(60)
   end
   local delay = machine.delay
   if not delay:canRun() then return end

   s.fluid:pushFill(burner.fluid, Things.Biodiesel, 1000, 2000)

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
end

CompositeMachines.HotThermo.clearer = function(machine, storage)
   local thermo = machine.storage[1]
   local burner = machine.storage[2]
   local s = storage

   s.fluid:pullAll(thermo.fluid)
   s.item:pull(thermo.item, 1)
   s.fluid:pullAll(burner.fluid)
end




local Recipes = {
   Recipe.new(Things.MenrilCrystal, Machines.MechanicalSqueezer, Things.MenrilLog),
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
   Recipe.new(Things.Biodiesel, Machines.Mixer, Things.VegetableOil, Things.Ethanol),
   Recipe.new(Things.Ethylene, Machines.Thermo, Things.SulfurDust, Things.Ethanol),
   Recipe.new(Things.Polyethylene, Machines.Mixer, Things.Ethylene, Things.Latex),
   Recipe.new(Things.MenrilLog, Machines.PhytogenicInsolator, Things.MenrilSapling, Things.Water),
   Recipe.new(Things.ForceLog, Machines.PhytogenicInsolator, Things.ForceSapling, Things.Water),
   Recipe.new(Things.ForcePlanks, Machines.Crafter3, Things.ForceLog),
   Recipe.new(Things.DryRubber, Machines.Crafter3, Things.TinyRubber),
   Recipe.new(Things.Plastic, Machines.RedstoneFurnace, Things.DryRubber),
   Recipe.new(Things.LDPE, Machines.FluidEncapsulator, Things.Plastic, Things.Polyethylene),
   Recipe.new(Things.MoltenSilver, Machines.MagmaCrucible, Things.SilverIngot),
   Recipe.new(Things.LiquidForce, Machines.Pyrolyzer, Things.ForcePlanks),

   Recipe.new(Things.Latex, CompositeMachines.LatexMaker, Things.OakLog, Things.Water),
   Recipe.new(Things.Quicksilver, CompositeMachines.HotThermo, Things.Cinnabar, Things.MenrilResin),
}

Recipes[1].itemsOut = { Things.MenrilCrystal, Things.MenrilResin }

return {
   recipes = Recipes,
   machines = {
      HotThermo = CompositeMachines.HotThermo,
      LatexMaker = CompositeMachines.LatexMaker,
   },
   detectable = {
      Machines.SuperCooler,
      Machines.SporesRecreator,
      Machines.LatexProcessingUnit,
      Machines.MechanicalSqueezer,
      Machines.PhytogenicInsolator,
      Machines.Pulverizer,
      Machines.FluidEncapsulator,
      Machines.RedstoneFurnace,
      Machines.MagmaCrucible,
      Machines.Pyrolyzer,
      Machines.Crafter3,
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
   },
}
