require "tl/Factory"

local Things = {
  ManaPowder    = Item.new("botania:mana_powder",                  "Mana Powder") as Thing,
  ForceSapling  = Item.new("forcecraft:force_sapling",             "Force Sapling" ) as Thing,
  ForceLog      = Item.new("forcecraft:force_log",                 "Force Log" ) as Thing,
  ForcePlanks   = Item.new("forcecraft:force_planks",              "Force Planks" ) as Thing,
  GoldenPower   = Item.new("forcecraft:golden_power_source",       "Golden Power Source" ) as Thing,
  LDPE          = Item.new("ftbskies:ldpe_sheet",                  "LDPE Sheet" ) as Thing,
  Duroplast     = Item.new("immersiveengineering:plate_duroplast", "Duroplast Plate" ) as Thing,
  TinyRubber    = Item.new("industrialforegoing:tinydryrubber",    "Tiny Dry Rubber" ) as Thing,
  DryRubber     = Item.new("industrialforegoing:dryrubber",        "Dry Rubber" ) as Thing,
  Plastic       = Item.new("industrialforegoing:plastic",          "Plastic" ) as Thing,
  MenrilLog     = Item.new("integrateddynamics:menril_log",        "Menril Log" ) as Thing,
  MenrilSapling = Item.new("integrateddynamics:menril_sapling",    "Menril Sapling" ) as Thing,
  MenrilCrystal = Item.new("integrateddynamics:crystalized_menril_chunk", "Crystalized Menril Chunk" ) as Thing,
  SulfurDust    = Item.new("mekanism:dust_sulfur",                 "Sulfur Dust" ) as Thing,
  Mushroom      = Item.new("minecraft:red_mushroom",               "Red_mushroom" ) as Thing,
  Potato        = Item.new("minecraft:potato",                     "Potato" ) as Thing,
  OakSapling		= Item.new("minecraft:oak_sapling",                "Oak Sapling" ) as Thing,
  OakLog			  = Item.new("minecraft:oak_log",                    "Oak Log" ) as Thing,
  Paper         = Item.new("minecraft:paper",                      "Paper" ) as Thing,
  SilverIngot   = Item.new("occultism:silver_ingot",               "Silver Ingot" ) as Thing,
  RawSilver     = Item.new("occultism:raw_silver",                 "Raw Silver" ) as Thing,
  Glycerol 	    = Item.new("pneumaticcraft:glycerol",              "Glycerol" ) as Thing,
  Sulfur        = Item.new("thermal:sulfur",                       "Sulfur" ) as Thing,
  Cinnabar      = Item.new("thermal:cinnabar",                     "Cinnabar" ) as Thing,

  LiquidForce   = Fluid.new("forcecraft:fluid_force_source",       "Fluid Force" ) as Thing,
  Polyethylene  = Fluid.new("ftbskies:polyethylene",               "Polyethylene" ) as Thing,
  MoltenSilver  = Fluid.new("ftbskies:molten_silver",              "Molten Silver" ) as Thing,
  Quicksilver   = Fluid.new("hexerei:quicksilver_fluid",           "Quicksilver Fluid" ) as Thing,
  Acetaldehyde  = Fluid.new("immersiveengineering:acetaldehyde",   "Acetaldehyde" ) as Thing,
  PhelonicResin = Fluid.new("immersiveengineering:phenolic_resin", "Phenolic Resin" ) as Thing,
  Latex         = Fluid.new("industrialforegoing:latex",           "Latex" ) as Thing,
  MenrilResin   = Fluid.new("integrateddynamics:menril_resin",     "Menril Resin" ) as Thing,
  Ethylene      = Fluid.new("mekanism:ethene",                     "Ethene" ) as Thing,
  Water         = Fluid.new("minecraft:water",                     "Water" ) as Thing,
  Lava          = Fluid.new("minecraft:lava",                      "Lava" ) as Thing,
  Yeast         = Fluid.new("pneumaticcraft:yeast_culture",        "Yeast Culture" ) as Thing,
  VegetableOil  = Fluid.new("pneumaticcraft:vegetable_oil",        "Vegetable Oil" ) as Thing,
  Ethanol 	    = Fluid.new("pneumaticcraft:ethanol",              "Ethanol" ) as Thing,
  Biodiesel 	= Fluid.new("pneumaticcraft:biodiesel",              "Biodiesel" ) as Thing,
}

local Machines = {
  FluidExtractor        = MachineType.new("industrialforegoing:fluid_extractor",        "Fluid Extractor"),
  BlockPlacer           = MachineType.new("industrialforegoing:block_placer",           "Block Placer"),
  LiquidBlazeBurner     = MachineType.new("createaddition:liquid_blaze_burner",         "Liquid Blaze Burner"),
  Thermo                = MachineType.new("pneumaticcraft:thermopneumatic_processing_plant",  "Spores Recreator"),
  Mixer                 = MachineType.new("pneumaticraft:fluid_mixerc",                 "Latex Pro,cessing Unit"),
  Crafter               = MachineType.new("thermal:machine_crafter",      "Crafter"),
  Crafter3              = MachineType.new("rftoolsutility:crafter3",                    "Crafter (3)"),

  SuperCooler           = MachineType.new("rftoolsutility:ftbsba:super_cooler",         "Super Cooler"),
  SporesRecreator       = MachineType.new("industrialforegoing:spores_recreator",       "Spores Recreator"),
  LatexProcessingUnit   = MachineType.new("industrialforegoing:latex_processing_unit",  "Latex Processing Unit"),
  MechanicalSqueezer    = MachineType.new("integrateddynamics:mechanical_squeezer",     "Mechanical Squeezer"),
  PhytogenicInsolator   = MachineType.new("thermal:machine_insolator",    "Phytogenic Insolator"),
  Pulverizer            = MachineType.new("thermal:machine_pulverizer",   "Pulverizer"),
  FluidEncapsulator     = MachineType.new("thermal:machine_bottler",      "Fluid Encapsulator"),
  RedstoneFurnace       = MachineType.new("thermal:machine_furnace",      "Redstone Furnace"),
  MagmaCrucible         = MachineType.new("thermal:machine_crucible",     "Magma Crucible"),
  Pyrolyzer             = MachineType.new("thermal:machine_pyrolyzer",    "Pyrolyzer"),
}

--- Machine Customization

--- Latex Machine

global record LatexMachine
  new: function(placerID : string, extractorID : string) : LatexMachine

  placer : Machine
  extractor : Machine

  --Inherited
  type: MachineType
  work: function(self : LatexMachine, storage : Storage)
  clear: function(self : LatexMachine, storage : Storage)
  --work: MachineType.machineWorker
  --clear: MachineType.machineClearer
end
setmetatable(LatexMachine, {__index = Machine})

function LatexMachine.new(placerID : string, extractorID : string) : LatexMachine
  local self: LatexMachine = setmetatable(Machine.new() as LatexMachine, { __index = LatexMachine })
  self.placer     = PeripheralMachine.new(placerID, Machines.BlockPlacer) as Machine
  self.extractor  = PeripheralMachine.new(extractorID, Machines.FluidExtractor) as Machine
  return self
end

function LatexMachine:work(storage : Storage)
  local s = storage as HardStorage

  s.item:pushMax(self.placer.storage.item, Things.OakLog as Item, 1)
  s.fluid:pullAll(self.extractor.storage.fluid, Things.Latex as Fluid)
end

function LatexMachine:clear(storage : Storage)
  local s = storage as HardStorage

  s.item:pullAll(self.placer.storage.item, Things.OakLog as Item)
  s.fluid:pullAll(self.extractor.storage.fluid, Things.Latex as Fluid)
end

--- Phytogenic Insolator

Machines.PhytogenicInsolator.worker = function(machine:Machine, storage : Storage, recipe : Recipe)
  --Local storage should always have the APIs
  local item = storage.item as ItemStorage
  local fluid = storage.fluid as FluidStorage

  item:pullSlots(machine.storage.item, nil, 3)

  for _,thing in ipairs(recipe.inputs) do
    if thing:is("Item") then
      item:pushMax(machine.storage.item, thing as Item, 16, nil, 8)
    elseif thing:is("Fluid") then
      fluid:pushMax(machine.storage.fluid, thing as Fluid, nil, 8000)
    end
  end
end

------



local Recipes : { Recipe } = {
  Recipe.new(Things.Mushroom,     Machines.SporesRecreator.id,      Things.Mushroom, Things.Water),
  Recipe.new(Things.Potato,       Machines.PhytogenicInsolator.id,  Things.Potato, Things.Water),
  Recipe.new(Things.OakLog,       Machines.PhytogenicInsolator.id,  Things.OakSapling, Things.Water),
  Recipe.new(Things.RawSilver,    Machines.SuperCooler.id,          Things.ManaPowder, Things.Quicksilver),
  Recipe.new(Things.Quicksilver,  Machines.Thermo.id,               Things.Cinnabar, Things.MenrilResin),
  Recipe.new(Things.Acetaldehyde, Machines.Mixer.id,                Things.MoltenSilver, Things.Ethanol),
  Recipe.new(Things.PhelonicResin,Machines.Mixer.id,                Things.Latex, Things.Acetaldehyde),
  Recipe.new(Things.Duroplast,    Machines.FluidEncapsulator.id,    Things.Paper, Things.PhelonicResin),
  Recipe.new(Things.TinyRubber,   Machines.LatexProcessingUnit.id,  Things.Latex, Things.Water),
  Recipe.new(Things.Yeast,        Machines.Thermo.id,               Things.Mushroom, Things.Water),
  Recipe.new(Things.VegetableOil, Machines.Thermo.id,               Things.Potato),
  Recipe.new(Things.Ethanol,      Machines.Thermo.id,               Things.Potato, Things.Yeast),
  Recipe.new(Things.Biodiesel,    Machines.Mixer.id,                Things.VegetableOil, Things.Ethanol), -- ItemsOut = {1}
  Recipe.new(Things.Ethylene,     Machines.Thermo.id,               Things.SulfurDust, Things.Ethanol),
  Recipe.new(Things.Polyethylene, Machines.Mixer.id,                Things.Ethylene, Things.Latex),
  Recipe.new(Things.MenrilLog,    Machines.PhytogenicInsolator.id,  Things.MenrilSapling, Things.Water),
  Recipe.new(Things.ForceLog,     Machines.PhytogenicInsolator.id,  Things.ForceSapling, Things.Water),
  Recipe.new(Things.ForcePlanks,  Machines.Crafter3.id,             Things.ForceLog),
  Recipe.new(Things.DryRubber,    Machines.Crafter3.id,             Things.TinyRubber),
  Recipe.new(Things.Plastic,      Machines.RedstoneFurnace.id,      Things.DryRubber),
  Recipe.new(Things.LDPE,         Machines.FluidEncapsulator.id,    Things.Plastic, Things.Polyethylene),
  Recipe.new(Things.MoltenSilver, Machines.MagmaCrucible.id,        Things.SilverIngot),
  Recipe.new(Things.MenrilResin,  Machines.MagmaCrucible.id,        Things.MenrilCrystal),
  Recipe.new(Things.MenrilCrystal,Machines.MechanicalSqueezer.id,   Things.MenrilLog),
  Recipe.new(Things.LiquidForce,  Machines.Pyrolyzer.id,            Things.ForcePlanks),

  Recipe.new(Things.Latex,        LatexMachine.new,                 Things.OakLog, Things.Water),         -- No machine ID?
}

return {
  recipes = Recipes,
  machines = {
    Machines.SuperCooler           ,
    Machines.SporesRecreator       ,
    Machines.LatexProcessingUnit   ,
    Machines.MechanicalSqueezer    ,
    Machines.PhytogenicInsolator   ,
    Machines.Pulverizer            ,
    Machines.FluidEncapsulator     ,
    Machines.RedstoneFurnace       ,
    Machines.MagmaCrucible         ,
    Machines.Pyrolyzer             ,
  },
  craftable = {
    Mushroom =    Things.Mushroom,
    Potato =    Things.Potato,
    OakLog =    Things.OakLog,
    RawSilver =    Things.RawSilver,
    Quicksilver =    Things.Quicksilver,
    Acetaldehyde =    Things.Acetaldehyde,
    PhelonicResin =    Things.PhelonicResin,
    Duroplast =    Things.Duroplast,
    TinyRubber =    Things.TinyRubber,
    Yeast =    Things.Yeast,
    VegetableOil =    Things.VegetableOil,
    Ethanol =    Things.Ethanol,
    Biodiesel =    Things.Biodiesel,
    Ethylene =    Things.Ethylene,
    Polyethylene =    Things.Polyethylene,
    MenrilLog =    Things.MenrilLog,
    ForceLog =    Things.ForceLog,
    ForcePlanks =    Things.ForcePlanks,
    DryRubber =    Things.DryRubber,
    Plastic =    Things.Plastic,
    LDPE =    Things.LDPE,
    MoltenSilver =    Things.MoltenSilver,
    MenrilResin =    Things.MenrilResin,
    MenrilCrystal =    Things.MenrilCrystal,
    LiquidForce =    Things.LiquidForce,
    Latex =    Things.Latex,
  }
}


