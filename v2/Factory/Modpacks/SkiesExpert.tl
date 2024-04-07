require "v2/Factory/Machine"

local Things = {
  ManaPowder    = { __type = "Item", id = "botania:mana_powder",                  name = "Mana Powder" } as Thing,
  LiquidForce   = { __type = "Fluid", id = "forcecraft:fluid_force_source",       name="Fluid Force" } as Thing,
  ForceSapling  = { __type = "Item", id = "forcecraft:force_sapling",             name = "Force Sapling" } as Thing,
  ForceLog      = { __type = "Item", id = "forcecraft:force_log",                 name = "Force Log" } as Thing,
  ForcePlanks   = { __type = "Item", id = "forcecraft:force_planks",              name = "Force Planks" } as Thing,
  GoldenPower   = { __type = "Item", id = "forcecraft:golden_power_source",       name = "Golden Power Source" } as Thing,
  Polyethylene  = { __type = "Fluid", id = "ftbskies:polyethylene",               name="Polyethylene" } as Thing,
  MoltenSilver  = { __type = "Fluid", id = "ftbskies:molten_silver",              name="Molten Silver" } as Thing,
  LDPE          = { __type = "Item", id = "ftbskies:ldpe_sheet",                  name = "LDPE Sheet" } as Thing,
  Quicksilver   = { __type = "Fluid", id = "hexerei:quicksilver_fluid",           name="Quicksilver Fluid" } as Thing,
  Acetaldehyde  = { __type = "Fluid", id = "immersiveengineering:acetaldehyde",   name="Acetaldehyde" } as Thing,
  PhelonicResin = { __type = "Fluid", id = "immersiveengineering:phenolic_resin", name="Phenolic Resin" } as Thing,
  Duroplast     = { __type = "Item", id = "immersiveengineering:plate_duroplast", name = "Duroplast Plate" } as Thing,
  Latex         = { __type = "Fluid", id = "industrialforegoing:latex",           name="Latex" } as Thing,
  TinyRubber    = { __type = "Item", id = "industrialforegoing:tinydryrubber",    name = "Tiny Dry Rubber" } as Thing,
  DryRubber     = { __type = "Item", id = "industrialforegoing:dryrubber",        name = "Dry Rubber" } as Thing,
  Plastic       = { __type = "Item", id = "industrialforegoing:plastic",          name = "Plastic" } as Thing,
  MenrilResin   = { __type = "Fluid", id = "integrateddynamics:menril_resin",     name="Menril Resin" } as Thing,
  MenrilLog     = { __type = "Item", id = "integrateddynamics:menril_log",        name = "Menril Log" } as Thing,
  MenrilSapling = { __type = "Item", id = "integrateddynamics:menril_sapling",    name = "Menril Sapling" } as Thing,
  MenrilCrystal = { __type = "Item", id = "integrateddynamics:crystalized_menril_chunk", name = "Crystalized Menril Chunk" } as Thing,
  Ethylene      = { __type = "Fluid", id = "mekanism:ethene",                     name="Ethene" } as Thing,
  SulfurDust    = { __type = "Item", id = "mekanism:dust_sulfur",                 name = "Sulfur Dust" } as Thing,
  Water         = { __type = "Fluid", id = "minecraft:water",                     name="Water" } as Thing,
  Lava          = { __type = "Fluid", id = "minecraft:lava",                      name="Lava" } as Thing,
  Mushroom      = { __type = "Item", id = "minecraft:red_mushroom",               name = "Red_mushroom" } as Thing,
  Potato        = { __type = "Item", id = "minecraft:potato",                     name = "Potato" } as Thing,
  OakSapling		= { __type = "Item", id = "minecraft:oak_sapling",                name = "Oak_sapling" } as Thing,
  OakLog			  = { __type = "Item", id = "minecraft:oak_log",                    name = "Oak_log" } as Thing,
  Paper         = { __type = "Item", id = "minecraft:paper",                      name = "Paper" } as Thing,
  SilverIngot   = { __type = "Item", id = "occultism:silver_ingot",               name = "Silver Ingot" } as Thing,
  RawSilver     = { __type = "Item", id = "occultism:raw_silver",                 name = "Raw Silver" } as Thing,
  Yeast         = { __type = "Fluid", id = "pneumaticcraft:yeast_culture",        name="Yeast Culture" } as Thing,
  VegetableOil  = { __type = "Fluid", id = "pneumaticcraft:vegetable_oil",        name="Vegetable Oil" } as Thing,
  Ethanol 	    = { __type = "Fluid", id = "pneumaticcraft:ethanol",              name="Ethanol" } as Thing,
  Biodiesel 	  = { __type = "Fluid", id = "pneumaticcraft:biodiesel",            name="Biodiesel" } as Thing,
  Glycerol 	    = { __type = "Item", id = "pneumaticcraft:glycerol",              name = "Glycerol" } as Thing,
  Sulfur        = { __type = "Item", id = "thermal:sulfur",                       name = "Sulfur" } as Thing,
  Cinnabar      = { __type = "Item", id = "thermal:cinnabar",                     name = "Cinnabar" } as Thing,
}

local Machines = {
  LiquidBlazeBurner     = MachineType.new("createaddition:liquid_blaze_burner_2",       "Liquid Blaze Burner"),
  SuperCooler           = MachineType.new("rftoolsutility:ftbsba:super_cooler",         "Super Cooler"),
  SporesRecreator       = MachineType.new("industrialforegoing:spores_recreator",       "Spores Recreator"),
  LatexProcessingUnit   = MachineType.new("industrialforegoing:latex_processing_unit",  "Latex Processing Unit"),
  MechanicalSqueezer    = MachineType.new("integrateddynamics:mechanical_squeezer",     "Mechanical Squeezer"),
  Thermo                = MachineType.new("pneumaticcraft:thermopneumatic_processing_plant",  "Spores Recreator"),
  Mixer                 = MachineType.new("pneumaticraft:fluid_mixerc",                 "Latex Pro,cessing Unit"),
  Crafter3              = MachineType.new("rftoolsutility:crafter3",                    "Crafter (3)"),
  PhytogenicInsolator   = MachineType.new("thermal:machine_insolator",    "Phytogenic Insolator"),
  Pulverizer            = MachineType.new("thermal:machine_pulverizer",   "Pulverizer"),
  Crafter               = MachineType.new("thermal:machine_crafter",      "Crafter"),
  FluidEncapsulator     = MachineType.new("thermal:machine_bottler",      "Fluid Encapsulator"),
  RedstoneFurnace       = MachineType.new("thermal:machine_furnace",      "Redstone Furnace"),
  MagmaCrucible         = MachineType.new("thermal:machine_crucible",     "Magma Crucible"),
  Pyrolyzer             = MachineType.new("thermal:machine_pyrolyzer",    "Pyrolyzer"),
}

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
  Recipe.new(Things.Latex,        Machines.SporesRecreator.id,      Things.OakLog, Things.Water),         -- No machine ID?
  Recipe.new(Things.Ethylene,     Machines.Thermo.id,               Things.SulfurDust, Things.Ethanol),
  Recipe.new(Things.Polyethylene, Machines.Mixer.id,                Things.Ethylene, Things.Latex),
  Recipe.new(Things.MenrilLog,    Machines.PhytogenicInsolator.id,  Things.MenrilSapling, Things.Water),
  Recipe.new(Things.ForceLog,     Machines.PhytogenicInsolator.id,  Things.ForceSapling, Things.Water),
  Recipe.new(Things.ForcePlanks,  Machines.Crafter3.id,             Things.ForceLog),
  Recipe.new(Things.DryRubber,    Machines.Crafter3.id,             Things.TinyRubber),
  Recipe.new(Things.Mushroom,     Machines.SporesRecreator.id,      Things.Mushroom, Things.Water),
  Recipe.new(Things.Plastic,      Machines.RedstoneFurnace.id,      Things.DryRubber),
  Recipe.new(Things.LDPE,         Machines.FluidEncapsulator.id,    Things.Plastic, Things.Polyethylene),
  Recipe.new(Things.MoltenSilver, Machines.MagmaCrucible.id,        Things.SilverIngot),
  Recipe.new(Things.MenrilResin,  Machines.MagmaCrucible.id,        Things.MenrilCrystal),
  Recipe.new(Things.MenrilCrystal,Machines.MechanicalSqueezer.id,   Things.MenrilLog),
  Recipe.new(Things.LiquidForce,  Machines.Pyrolyzer.id,            Things.ForcePlanks),
}

return {
  recipes = Recipes,
  craftable = {

  }
}

