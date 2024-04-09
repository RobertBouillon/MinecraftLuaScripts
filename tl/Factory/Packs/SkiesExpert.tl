require "tl/Factory"

local Things = {
  ManaPowder    = Item.new("botania:mana_powder",                  "Mana Powder"    ) as Thing,
  ForceSapling  = Item.new("forcecraft:force_sapling",             "Force Sapling"  ) as Thing,
  ForceLog      = Item.new("forcecraft:force_log",                 "Force Log"      ) as Thing,
  ForcePlanks   = Item.new("forcecraft:force_planks",              "Force Planks"   ) as Thing,
  GoldenPower   = Item.new("forcecraft:golden_power_source",       "Golden Power Source"  ) as Thing,
  LDPE          = Item.new("ftbskies:ldpe_sheet",                  "LDPE Sheet"           ) as Thing,
  Duroplast     = Item.new("immersiveengineering:plate_duroplast", "Duroplast Plate"      ) as Thing,
  TinyRubber    = Item.new("industrialforegoing:tinydryrubber",    "Tiny Dry Rubber"      ) as Thing,
  DryRubber     = Item.new("industrialforegoing:dryrubber",        "Dry Rubber"     ) as Thing,
  Plastic       = Item.new("industrialforegoing:plastic",          "Plastic"        ) as Thing,
  MenrilLog     = Item.new("integrateddynamics:menril_log",        "Menril Log"     ) as Thing,
  MenrilSapling = Item.new("integrateddynamics:menril_sapling",    "Menril Sapling" ) as Thing,
  MenrilCrystal = Item.new("integrateddynamics:crystalized_menril_chunk", "Crystalized Menril"  ) as Thing,
  SulfurDust    = Item.new("mekanism:dust_sulfur",                 "Sulfur Dust"                ) as Thing,
  Mushroom      = Item.new("minecraft:red_mushroom",               "Mushroom"       ) as Thing,
  Potato        = Item.new("minecraft:potato",                     "Potato"         ) as Thing,
  OakSapling		= Item.new("minecraft:oak_sapling",                "Oak Sapling"    ) as Thing,
  OakLog			  = Item.new("minecraft:oak_log",                    "Oak Log"        ) as Thing,
  Paper         = Item.new("minecraft:paper",                      "Paper"          ) as Thing,
  SilverIngot   = Item.new("occultism:silver_ingot",               "Silver Ingot"   ) as Thing,
  RawSilver     = Item.new("occultism:raw_silver",                 "Raw Silver"     ) as Thing,
  Glycerol 	    = Item.new("pneumaticcraft:glycerol",              "Glycerol"       ) as Thing,
  Sulfur        = Item.new("thermal:sulfur",                       "Sulfur"         ) as Thing,
  Cinnabar      = Item.new("thermal:cinnabar",                     "Cinnabar"       ) as Thing,

  LiquidForce   = Fluid.new("forcecraft:fluid_force_source",       "Fluid Force"    ) as Thing,
  Polyethylene  = Fluid.new("ftbskies:polyethylene",               "Polyethylene"   ) as Thing,
  MoltenSilver  = Fluid.new("ftbskies:molten_silver",              "Molten Silver"  ) as Thing,
  Quicksilver   = Fluid.new("hexerei:quicksilver_fluid",           "Quicksilver Fluid"  ) as Thing,
  Acetaldehyde  = Fluid.new("immersiveengineering:acetaldehyde",   "Acetaldehyde"       ) as Thing,
  PhelonicResin = Fluid.new("immersiveengineering:phenolic_resin", "Phenolic Resin"     ) as Thing,
  Latex         = Fluid.new("industrialforegoing:latex",           "Latex"          ) as Thing,
  MenrilResin   = Fluid.new("integrateddynamics:menril_resin",     "Menril Resin"   ) as Thing,
  Ethylene      = Fluid.new("mekanism:ethene",                     "Ethene"         ) as Thing,
  Water         = Fluid.new("minecraft:water",                     "Water"          ) as Thing,
  Lava          = Fluid.new("minecraft:lava",                      "Lava"           ) as Thing,
  Yeast         = Fluid.new("pneumaticcraft:yeast_culture",        "Yeast Culture"  ) as Thing,
  VegetableOil  = Fluid.new("pneumaticcraft:vegetable_oil",        "Vegetable Oil"  ) as Thing,
  Ethanol 	    = Fluid.new("pneumaticcraft:ethanol",              "Ethanol"        ) as Thing,
  Biodiesel 	= Fluid.new("pneumaticcraft:biodiesel",              "Biodiesel"      ) as Thing,
}

local Machines = {
  -- Detectable
  SuperCooler           = MachineType.new("Super Cooler",           "rftoolsutility:ftbsba:super_cooler"),
  SporesRecreator       = MachineType.new("Spores Recreator",       "industrialforegoing:spores_recreator"),
  LatexProcessingUnit   = MachineType.new("Latex Processing Unit",  "industrialforegoing:latex_processing_unit"),
  MechanicalSqueezer    = MachineType.new("Mechanical Squeezer",    "integrateddynamics:mechanical_squeezer"),
  PhytogenicInsolator   = MachineType.new("Phytogenic Insolator",   "thermal:machine_insolator"),
  Pulverizer            = MachineType.new("Pulverizer",             "thermal:machine_pulverizer"),
  FluidEncapsulator     = MachineType.new("Fluid Encapsulator",     "thermal:machine_bottler"),
  RedstoneFurnace       = MachineType.new("Redstone Furnace",       "thermal:machine_furnace"),
  MagmaCrucible         = MachineType.new("Magma Crucible",         "thermal:machine_crucible"),
  Pyrolyzer             = MachineType.new("Pyrolyzer",              "thermal:machine_pyrolyzer"),

  -- Component Machines
  FluidExtractor        = MachineType.new("Fluid Extractor",        "industrialforegoing:fluid_extractor"),
  BlockPlacer           = MachineType.new("Block Placer",           "industrialforegoing:block_placer"),
  LiquidBlazeBurner     = MachineType.new("Liquid Blaze Burner",    "createaddition:liquid_blaze_burner"),
  Thermo                = MachineType.new("Spores Recreator",       "pneumaticcraft:thermopneumatic_processing_plant"),
  Mixer                 = MachineType.new("Latex Processing Unit",  "pneumaticraft:latex_processing_unit"),
  Crafter               = MachineType.new("Crafter",                "thermal:machine_crafter"),
  Crafter3              = MachineType.new("Crafter (3)",            "rftoolsutility:crafter3"),
}

local CompositeMachines = {
  LatexMaker  = MachineType.newComposite("Latex Maker",       Machines.BlockPlacer,   Machines.FluidExtractor),
  HotThermo   = MachineType.newComposite("Hot Thermo",        Machines.Thermo,        Machines.LiquidBlazeBurner)
}



--- Machine Customization
local ifclearer  = function (machine:Machine, storage : Storage)
  local m = machine.storage[1] as HardStorage
  m.item:pushAll(storage.item)
  m.fluid:pushAll(storage.fluid)
end

Machines.LatexProcessingUnit.clearer  = ifclearer
Machines.LatexProcessingUnit.worker = function (machine:Machine, storage : Storage)
  --REASON: Spores Recreator API only works locally and doesn't allow it to be targeted by push / pull commands
  local m = machine.storage[1] as HardStorage
  m.item:pushSlots(storage.item, nil as Item, 3)                  --Empty output
  m.fluid:pullFill(storage.fluid, Things.Water as Fluid,500)      --Fill with water
  m.fluid:pullFill(storage.fluid, Things.Latex as Fluid,500)      --Fill with Latex
end

Machines.SporesRecreator.clearer  = ifclearer
Machines.SporesRecreator.worker  = function (machine:Machine, storage : Storage)
  --REASON: Spores Recreator API only works locally and doesn't allow it to be targeted by push / pull commands
  local m = machine.storage[1] as HardStorage
  m.item:pushSlots(storage.item, nil as Item, 6)                  --Empty output
  m.fluid:pullFill(storage.fluid, Things.Water as Fluid,500)      --Fill with water
  m.item:pullFill(storage.item, Things.Mushroom as Item,3,32,64)  --Fill with Mushrooms
end


Machines.PhytogenicInsolator.worker = function(machine:Machine, storage : Storage, itemsIn : {Thing})
  -- REASON: We only want to pull from slot 3+
  local item = storage.item as ItemStorage
  local fluid = storage.fluid as FluidStorage

  item:pullSlots(machine.storage[1].item, nil, 3)

  for _,thing in ipairs(itemsIn) do
    if thing:is("Item") then
      item:pushFill(machine.storage[1].item, thing as Item, 1, 8, 16)
    elseif thing:is("Fluid") then
      fluid:pushFill(machine.storage[1].fluid, thing as Fluid, nil, 8000)
    end
  end
end

--- Latex Machine
CompositeMachines.LatexMaker.worker = function (machine:Machine, storage : Storage)
  local placer = machine.storage[1].item as ItemStorage
  local extractor = machine.storage[2].fluid as FluidStorage
  local s = storage as HardStorage

  placer:pullFill(s.item, Things.OakLog as Item, nil, nil, 1)
  extractor:pushWhen(s.fluid, Things.Latex as Fluid, 950)
end

CompositeMachines.LatexMaker.clearer = function (machine : Machine, storage : Storage)
  local placer = machine.storage[1].item as ItemStorage
  local extractor = machine.storage[2].fluid as FluidStorage
  local s = storage as HardStorage

  placer:pushAll(s.item, Things.OakLog as Item)
  extractor:pushAll(s.fluid, Things.Latex as Fluid)
end

--- Hot Thermo
CompositeMachines.HotThermo.worker = function (machine:Machine, storage : Storage, itemsIn : {Thing}, itemsOut : {Thing})
  local thermo = machine.storage[1]
  local burner = machine.storage[2]
  local s = storage as HardStorage

  if machine.delay == nil then
    machine.delay = Delay.new(60) --These machines are SLOW, and without an API, we would pull and push too often
  end
  local delay = machine.delay as Delay
  if not delay:canRun() then return end

  s.fluid:pushFill(burner.fluid, Things.Biodiesel as Fluid, 1000, 2000)

  for _,thing in ipairs(itemsIn) do
    if thing:is("Item") then
      s.item:push(thermo.item, thing as Item)
    else
      s.fluid:push(thermo.fluid, thing as Fluid)
    end
  end

  s.fluid:pull(thermo.fluid)
  for _,thing in ipairs(itemsOut) do
    if thing:is("Item") then 
      s.item:pull(thermo.item, 1)
      break
    end
  end
end

CompositeMachines.HotThermo.clearer = function (machine : Machine, storage : Storage)
  local thermo = machine.storage[1]
  local burner = machine.storage[2]
  local s = storage as HardStorage

  s.fluid:pullAll(thermo.fluid)
  s.item:pull(thermo.item, 1)
  s.fluid:pullAll(burner.fluid)
end




local Recipes : { Recipe } = {
  Recipe.new(Things.MenrilCrystal,Machines.MechanicalSqueezer,   Things.MenrilLog),
  Recipe.new(Things.MenrilResin,  Machines.MagmaCrucible,        Things.MenrilCrystal),
  Recipe.new(Things.Mushroom,     Machines.SporesRecreator,      Things.Mushroom, Things.Water),
  Recipe.new(Things.Potato,       Machines.PhytogenicInsolator,  Things.Potato, Things.Water),
  Recipe.new(Things.OakLog,       Machines.PhytogenicInsolator,  Things.OakSapling, Things.Water),
  Recipe.new(Things.RawSilver,    Machines.SuperCooler,          Things.ManaPowder, Things.Quicksilver),
  Recipe.new(Things.Acetaldehyde, Machines.Mixer,                Things.MoltenSilver, Things.Ethanol),
  Recipe.new(Things.PhelonicResin,Machines.Mixer,                Things.Latex, Things.Acetaldehyde),
  Recipe.new(Things.Duroplast,    Machines.FluidEncapsulator,    Things.Paper, Things.PhelonicResin),
  Recipe.new(Things.TinyRubber,   Machines.LatexProcessingUnit,  Things.Latex, Things.Water),
  Recipe.new(Things.Yeast,        Machines.Thermo,               Things.Mushroom, Things.Water),
  Recipe.new(Things.VegetableOil, Machines.Thermo,               Things.Potato),
  Recipe.new(Things.Ethanol,      Machines.Thermo,               Things.Potato, Things.Yeast),
  Recipe.new(Things.Biodiesel,    Machines.Mixer,                Things.VegetableOil, Things.Ethanol), -- ItemsOut = {1}
  Recipe.new(Things.Ethylene,     Machines.Thermo,               Things.SulfurDust, Things.Ethanol),
  Recipe.new(Things.Polyethylene, Machines.Mixer,                Things.Ethylene, Things.Latex),
  Recipe.new(Things.MenrilLog,    Machines.PhytogenicInsolator,  Things.MenrilSapling, Things.Water),
  Recipe.new(Things.ForceLog,     Machines.PhytogenicInsolator,  Things.ForceSapling, Things.Water),
  Recipe.new(Things.ForcePlanks,  Machines.Crafter3,             Things.ForceLog),
  Recipe.new(Things.DryRubber,    Machines.Crafter3,             Things.TinyRubber),
  Recipe.new(Things.Plastic,      Machines.RedstoneFurnace,      Things.DryRubber),
  Recipe.new(Things.LDPE,         Machines.FluidEncapsulator,    Things.Plastic, Things.Polyethylene),
  Recipe.new(Things.MoltenSilver, Machines.MagmaCrucible,        Things.SilverIngot),
  Recipe.new(Things.LiquidForce,  Machines.Pyrolyzer,            Things.ForcePlanks),

  Recipe.new(Things.Latex,        CompositeMachines.LatexMaker,  Things.OakLog, Things.Water),
  Recipe.new(Things.Quicksilver,  CompositeMachines.HotThermo,   Things.Cinnabar, Things.MenrilResin),
}

Recipes[1].itemsOut = {Things.MenrilCrystal, Things.MenrilResin}

return {
  recipes = Recipes,
  machines = {
    HotThermo = CompositeMachines.HotThermo,
    LatexMaker = CompositeMachines.LatexMaker
  },
  detectable = {
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
    Machines.Crafter3              ,
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


