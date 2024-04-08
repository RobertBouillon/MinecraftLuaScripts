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
   MenrilCrystal = Item.new("integrateddynamics:crystalized_menril_chunk", "Crystalized Menril Chunk"),
   SulfurDust = Item.new("mekanism:dust_sulfur", "Sulfur Dust"),
   Mushroom = Item.new("minecraft:red_mushroom", "Red_mushroom"),
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
   FluidExtractor = MachineType.new("industrialforegoing:fluid_extractor", "Fluid Extractor"),
   BlockPlacer = MachineType.new("industrialforegoing:block_placer", "Block Placer"),
   LiquidBlazeBurner = MachineType.new("createaddition:liquid_blaze_burner", "Liquid Blaze Burner"),
   Thermo = MachineType.new("pneumaticcraft:thermopneumatic_processing_plant", "Spores Recreator"),
   Mixer = MachineType.new("pneumaticraft:fluid_mixerc", "Latex Pro,cessing Unit"),
   Crafter = MachineType.new("thermal:machine_crafter", "Crafter"),
   Crafter3 = MachineType.new("rftoolsutility:crafter3", "Crafter (3)"),

   SuperCooler = MachineType.new("rftoolsutility:ftbsba:super_cooler", "Super Cooler"),
   SporesRecreator = MachineType.new("industrialforegoing:spores_recreator", "Spores Recreator"),
   LatexProcessingUnit = MachineType.new("industrialforegoing:latex_processing_unit", "Latex Processing Unit"),
   MechanicalSqueezer = MachineType.new("integrateddynamics:mechanical_squeezer", "Mechanical Squeezer"),
   PhytogenicInsolator = MachineType.new("thermal:machine_insolator", "Phytogenic Insolator"),
   Pulverizer = MachineType.new("thermal:machine_pulverizer", "Pulverizer"),
   FluidEncapsulator = MachineType.new("thermal:machine_bottler", "Fluid Encapsulator"),
   RedstoneFurnace = MachineType.new("thermal:machine_furnace", "Redstone Furnace"),
   MagmaCrucible = MachineType.new("thermal:machine_crucible", "Magma Crucible"),
   Pyrolyzer = MachineType.new("thermal:machine_pyrolyzer", "Pyrolyzer"),
}





LatexMachine = {}












setmetatable(LatexMachine, { __index = Machine })

function LatexMachine.new(placerID, extractorID)
   local self = setmetatable(Machine.new(), { __index = LatexMachine })
   self.placer = PeripheralMachine.new(placerID, Machines.BlockPlacer)
   self.extractor = PeripheralMachine.new(extractorID, Machines.FluidExtractor)
   return self
end

function LatexMachine:work(storage)
   local s = storage

   s.item:pushMax(self.placer.storage.item, Things.OakLog, 1)
   s.fluid:pullAll(self.extractor.storage.fluid, Things.Latex)
end

function LatexMachine:clear(storage)
   local s = storage

   s.item:pullAll(self.placer.storage.item, Things.OakLog)
   s.fluid:pullAll(self.extractor.storage.fluid, Things.Latex)
end



Machines.PhytogenicInsolator.worker = function(machine, storage, recipe)

   local item = storage.item
   local fluid = storage.fluid

   item:pullSlots(machine.storage.item, nil, 3)

   for _, thing in ipairs(recipe.inputs) do
      if thing:is("Item") then
         item:pushMax(machine.storage.item, thing, 16, nil, 8)
      elseif thing:is("Fluid") then
         fluid:pushMax(machine.storage.fluid, thing, nil, 8000)
      end
   end
end





local Recipes = {
   Recipe.new(Things.Mushroom, Machines.SporesRecreator.id, Things.Mushroom, Things.Water),
   Recipe.new(Things.Potato, Machines.PhytogenicInsolator.id, Things.Potato, Things.Water),
   Recipe.new(Things.OakLog, Machines.PhytogenicInsolator.id, Things.OakSapling, Things.Water),
   Recipe.new(Things.RawSilver, Machines.SuperCooler.id, Things.ManaPowder, Things.Quicksilver),
   Recipe.new(Things.Quicksilver, Machines.Thermo.id, Things.Cinnabar, Things.MenrilResin),
   Recipe.new(Things.Acetaldehyde, Machines.Mixer.id, Things.MoltenSilver, Things.Ethanol),
   Recipe.new(Things.PhelonicResin, Machines.Mixer.id, Things.Latex, Things.Acetaldehyde),
   Recipe.new(Things.Duroplast, Machines.FluidEncapsulator.id, Things.Paper, Things.PhelonicResin),
   Recipe.new(Things.TinyRubber, Machines.LatexProcessingUnit.id, Things.Latex, Things.Water),
   Recipe.new(Things.Yeast, Machines.Thermo.id, Things.Mushroom, Things.Water),
   Recipe.new(Things.VegetableOil, Machines.Thermo.id, Things.Potato),
   Recipe.new(Things.Ethanol, Machines.Thermo.id, Things.Potato, Things.Yeast),
   Recipe.new(Things.Biodiesel, Machines.Mixer.id, Things.VegetableOil, Things.Ethanol),
   Recipe.new(Things.Ethylene, Machines.Thermo.id, Things.SulfurDust, Things.Ethanol),
   Recipe.new(Things.Polyethylene, Machines.Mixer.id, Things.Ethylene, Things.Latex),
   Recipe.new(Things.MenrilLog, Machines.PhytogenicInsolator.id, Things.MenrilSapling, Things.Water),
   Recipe.new(Things.ForceLog, Machines.PhytogenicInsolator.id, Things.ForceSapling, Things.Water),
   Recipe.new(Things.ForcePlanks, Machines.Crafter3.id, Things.ForceLog),
   Recipe.new(Things.DryRubber, Machines.Crafter3.id, Things.TinyRubber),
   Recipe.new(Things.Plastic, Machines.RedstoneFurnace.id, Things.DryRubber),
   Recipe.new(Things.LDPE, Machines.FluidEncapsulator.id, Things.Plastic, Things.Polyethylene),
   Recipe.new(Things.MoltenSilver, Machines.MagmaCrucible.id, Things.SilverIngot),
   Recipe.new(Things.MenrilResin, Machines.MagmaCrucible.id, Things.MenrilCrystal),
   Recipe.new(Things.MenrilCrystal, Machines.MechanicalSqueezer.id, Things.MenrilLog),
   Recipe.new(Things.LiquidForce, Machines.Pyrolyzer.id, Things.ForcePlanks),

   Recipe.new(Things.Latex, LatexMachine.new, Things.OakLog, Things.Water),
}

return {
   recipes = Recipes,
   machines = {
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
