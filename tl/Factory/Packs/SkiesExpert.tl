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
  Substrate     = Item.new("mekanism:substrate",                   "Substrate"      ) as Thing,
  Redstone      = Item.new("minecraft:redstone",                   "Redstone"       ) as Thing,
  BasicCircuit  = Item.new("mekanism:basic_control_circuit",       "Basic Circuit"  ) as Thing,
  EmptyPCB      = Item.new("pneumaticcraft:empty_pcb",             "Empty PCB"      ) as Thing,
  LogicCircuit  = Item.new("immersiveengineering:logic_circuit",   "Logic Circuit"  ) as Thing,
  UpgradeMatrix = Item.new("pneumaticcraft:upgrade_matrix",        "Upgrade Matrix" ) as Thing,
  Lapis         = Item.new("minecraft:lapis_lazuli",               "Lapis Lazuli"   ) as Thing,
  Diamond       = Item.new("minecraft:diamond",                    "Diamond"        ) as Thing,
  Gold          = Item.new("minecraft:gold_ingot",                 "Gold Ingot"     ) as Thing,
  CertusCrystal = Item.new("ae2:certus_quartz_crystal",            "Certus Crystal" ) as Thing,
  FluixCrystal  = Item.new("ae2:certus_quartz_crystal",            "Certus Crystal" ) as Thing,
  Solder        = Item.new("ftbskies:conductive_soldering_alloy",  "Solder"         ) as Thing,
  Glowstone     = Item.new("minecraft:glowstone",                  "Glowstone"      ) as Thing,
  ChargedCertus = Item.new("ae2:charged_certus_quartz_crystal",    "Charged Certus" ) as Thing,
  PolishedRose  = Item.new("create:polished_rose_quartz",          "Rose Quartz"    ) as Thing,
  IesniumDust   = Item.new("occultism:iesmium_dust",               "Iesnium Dust"   ) as Thing,
  SilverDust    = Item.new("occultism:silver_dust",                "Silver Dust"    ) as Thing,
  FormationCore = Item.new("ae2:formation_core",                   "Formation Core" ) as Thing,
  AnnihilationCore = Item.new("ae2:annihilation_core",             "Annihilation Core" ) as Thing,
  CalculationProcessor  = Item.new("ae2:printed_calculation_processor",  "Calculation Proc"   ) as Thing,
  EngineeringProcessor  = Item.new("ae2:printed_engineering_processor",  "Engineering Proc"   ) as Thing,
  LogicProcessor        = Item.new("ae2:printed_logic_processor",        "Logic Processor"    ) as Thing,
  PrintedSilicon        = Item.new("ae2:printed_silicon",          "Printed Silicon"    ) as Thing,

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
  Biodiesel     = Fluid.new("pneumaticcraft:biodiesel",            "Biodiesel"      ) as Thing,
  RedstoneAcid  = Fluid.new("immersiveengineering:redstone_acid",  "Redstone Acid"  ) as Thing,
  Source        = Fluid.new("starbunclemania:source_fluid",        "Liquefied Source"  ) as Thing,
  Fuel          = Fluid.new("ad_astra:fuel",                       "Fuel"  ) as Thing,
  EnergizedGlowstone= Fluid.new("thermal:glowstone",               "Energized Glowstone"    ) as Thing,
  VolatileRedstone      = Fluid.new("ftbskies:volatile_redstone",  "Volatile Redstone"      ) as Thing,
  DestabilizedRedstone  = Fluid.new("thermal:redstone",            "Destabilized Redstone"  ) as Thing,
}

local Machines = {
  -- Detectable
  SuperCooler           = MachineType.new("Super Cooler",           "ftbsba:super_cooler"),
  SporesRecreator       = MachineType.new("Spores Recreator",       "industrialforegoing:spores_recreator"),
  LatexProcessingUnit   = MachineType.new("Latex Processing Unit",  "industrialforegoing:latex_processing_unit"),
  MechanicalSqueezer    = MachineType.new("Mechanical Squeezer",    "integrateddynamics:mechanical_squeezer"),
  PhytogenicInsolator   = MachineType.new("Phytogenic Insolator",   "thermal:machine_insolator"),
  Pulverizer            = MachineType.new("Pulverizer",             "thermal:machine_pulverizer"),
  FluidEncapsulator     = MachineType.new("Fluid Encapsulator",     "thermal:machine_bottler"),
  RedstoneFurnace       = MachineType.new("Redstone Furnace",       "thermal:machine_furnace"),
  MagmaCrucible         = MachineType.new("Magma Crucible",         "thermal:machine_crucible"),
  Pyrolyzer             = MachineType.new("Pyrolyzer",              "thermal:machine_pyrolyzer"),
  FractioningStill      = MachineType.new("Fractioning Still",      "thermal:machine_refinery"),
  UVLightBox            = MachineType.new("UV Light Box",           "pneumaticcraft:uv_light_box"),
  Inscriber             = MachineType.new("Inscriber",              "ae2:inscriber"),
  DissolutionChamber    = MachineType.new("Dissolution Chamber",    "industrialforegoing:dissolution_chamber"),

  -- Component Machines
  FluidExtractor        = MachineType.new("Fluid Extractor",        "industrialforegoing:fluid_extractor"),
  BlockPlacer           = MachineType.new("Block Placer",           "industrialforegoing:block_placer"),
  LiquidBlazeBurner     = MachineType.new("Liquid Blaze Burner",    "createaddition:liquid_blaze_burner"),
  Thermo                = MachineType.new("Spores Recreator",       "pneumaticcraft:thermopneumatic_processing_plant"),
  Mixer                 = MachineType.new("Fluid Mixer",            "pneumaticcraft:fluid_mixer"),
  Crafter               = MachineType.new("Crafter",                "thermal:machine_crafter"),
  Crafter3              = MachineType.new("Crafter (3)",            "rftoolsutility:crafter3"),
  CustomMachine         = MachineType.new("Custom Machine",         "custommachinery:custom_machine_tile"),
}

local CompositeMachines = {
  LatexMaker  = MachineType.newComposite("Latex Maker",       Machines.BlockPlacer,   Machines.FluidExtractor),
  HotThermo   = MachineType.newComposite("Hot Thermo",        Machines.Thermo,        Machines.LiquidBlazeBurner),
  FabricationMatrix = MachineType.newComposite("Fabrication Matrix",  Machines.CustomMachine),
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
  m.fluid:pullFill(storage.fluid, Things.Water as Fluid,1000)      --Fill with water
  m.fluid:pullFill(storage.fluid, Things.Latex as Fluid,200,1000)      --Fill with Latex
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

--- Dissolution Chamber
Machines.DissolutionChamber.clearer = ifclearer
Machines.DissolutionChamber.worker = function (machine:Machine, storage : Storage, itemsIn : {Thing})
  local s = storage as HardStorage
  local i = machine.storage[1].item as ItemStorage
  local f = machine.storage[1].fluid as FluidStorage

  local inv = i:list()

  --Output
  for slot = 9, 11 do
    if inv[slot] ~= nil then i:push(s.item,slot) end
  end

  --Input
  for _,thing in ipairs(itemsIn) do
    if thing:is("Fluid") then
      f:pullFill(s.fluid, thing as Fluid, 2000)
    end
  end

  for slot = 1, 8 do
    if itemsIn[slot] ~= nil then
      i:pull(s.item, itemsIn[slot] as Item, 1, slot)
    end
  end
end


-- Pneumaticcraft
local function workPneumaticcraftMachine(machine:Machine, storage : Storage, itemsIn : {Thing}, itemsOut : {Thing}) : boolean
  local thermo = machine.storage[1]
  local s = storage as HardStorage

  if machine.delay == nil then
    machine.delay = Delay.new(20) --These machines are SLOW, and without an API, we would pull and push too often
  end
  local delay = machine.delay as Delay
  if not delay:canRun() then return false end

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
  return true
end

Machines.Thermo.worker = workPneumaticcraftMachine
Machines.Mixer.worker = workPneumaticcraftMachine

Machines.Thermo.clearer = function(machine : Machine, storage : Storage)
  local thermo = machine.storage[1]
  local s = storage as HardStorage

  s.fluid:pullAll(thermo.fluid)
  s.item:pull(thermo.item, 1)
end

Machines.Mixer.clearer = function(machine : Machine, storage : Storage)
  local thermo = machine.storage[1]
  local s = storage as HardStorage

  s.fluid:pullAll(thermo.fluid)
end

--- Hot Thermo
CompositeMachines.HotThermo.worker = function (machine:Machine, storage : Storage, itemsIn : {Thing}, itemsOut : {Thing})
  local s = storage as HardStorage

  if workPneumaticcraftMachine(machine,storage,itemsIn,itemsOut) then
    local burner = machine.storage[2]
    s.fluid:pushFill(burner.fluid, Things.Biodiesel as Fluid, 1000, 2000)
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



--- Inscriber
Machines.Inscriber.worker = function (machine:Machine, storage : Storage, itemsIn : {Thing})
  local s = storage as HardStorage
  local m = machine.storage[1].item as ItemStorage

  local inv = m:list()

  if inv[4] ~= nil then s.item:pull(m,4) end

  for slot = 1, 3 do
    if inv[slot] ~= nil and itemsIn[slot].name ~= inv[slot].name then s.item:pull(m,nil,nil,slot) end
    if inv[slot] == nil then s.item:push(m,itemsIn[slot] as Item,1,slot) end
  end
end



local Recipes : { Recipe } = {
  Recipe.new(Things.MenrilCrystal,Machines.MechanicalSqueezer,   Things.MenrilLog),
  Recipe.new(Things.DestabilizedRedstone,   Machines.FractioningStill,   Things.VolatileRedstone),
  Recipe.new(Things.RedstoneAcid,           Machines.FractioningStill,   Things.VolatileRedstone),
  Recipe.new(Things.Biodiesel,    Machines.Mixer,                Things.VegetableOil, Things.Ethanol), -- ItemsOut = {1}
  Recipe.new(Things.LiquidForce,  Machines.Pyrolyzer,            Things.ForcePlanks),

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
  Recipe.new(Things.Polyethylene, Machines.Mixer,                Things.Ethylene, Things.Latex),
  Recipe.new(Things.MenrilLog,    Machines.PhytogenicInsolator,  Things.MenrilSapling, Things.Water),
  Recipe.new(Things.ForceLog,     Machines.PhytogenicInsolator,  Things.ForceSapling, Things.Water),
  Recipe.new(Things.ForcePlanks,  Machines.Crafter3,             Things.ForceLog),
  Recipe.new(Things.DryRubber,    Machines.Crafter3,             Things.TinyRubber),
  Recipe.new(Things.Plastic,      Machines.RedstoneFurnace,      Things.DryRubber),
  Recipe.new(Things.LDPE,         Machines.FluidEncapsulator,    Things.Plastic, Things.Polyethylene),
  Recipe.new(Things.MoltenSilver, Machines.MagmaCrucible,        Things.SilverIngot),
  Recipe.new(Things.BasicCircuit, Machines.FluidEncapsulator,    Things.LogicCircuit, Things.MenrilResin),
  Recipe.new(Things.EmptyPCB,     Machines.FluidEncapsulator,    Things.LogicCircuit, Things.DestabilizedRedstone),
  Recipe.new(Things.Fuel,         Machines.Mixer,                Things.Source, Things.Biodiesel),
  Recipe.new(Things.UpgradeMatrix,Machines.Thermo,               Things.Water, Things.Lapis),
  Recipe.new(Things.EnergizedGlowstone,Machines.MagmaCrucible,   Things.Glowstone),



  --AE2
  Recipe.new(Things.CalculationProcessor, Machines.Inscriber,    Things.CertusCrystal, Things.PrintedSilicon, Things.Solder),
  Recipe.new(Things.EngineeringProcessor, Machines.Inscriber,    Things.Diamond, Things.PrintedSilicon, Things.Solder),
  Recipe.new(Things.LogicProcessor,       Machines.Inscriber,    Things.Gold, Things.PrintedSilicon, Things.Solder),

  --IF
  Recipe.new(Things.FluixCrystal,       Machines.Inscriber,    Things.Gold, Things.PrintedSilicon, Things.Solder),

  --Composites
  Recipe.new(Things.Latex,        CompositeMachines.LatexMaker,  Things.OakLog, Things.Water),
  Recipe.new(Things.Quicksilver,  CompositeMachines.HotThermo,   Things.Cinnabar, Things.MenrilResin),
  Recipe.new(Things.Ethylene,     CompositeMachines.HotThermo,   Things.SulfurDust, Things.Ethanol),
  Recipe.new(Things.VolatileRedstone,  CompositeMachines.HotThermo,   Things.Acetaldehyde, Things.Redstone),

  Recipe.new(Things.IesniumDust,  CompositeMachines.FabricationMatrix,    Things.SilverDust, Things.LiquidForce),
  Recipe.new(Things.FormationCore,CompositeMachines.FabricationMatrix,    Things.ChargedCertus, Things.EnergizedGlowstone),
  Recipe.new(Things.AnnihilationCore,CompositeMachines.FabricationMatrix, Things.PolishedRose, Things.EnergizedGlowstone),
}

Recipes[1].itemsOut = {Things.MenrilCrystal, Things.MenrilResin}
Recipes[2].itemsOut = {Things.Substrate, Things.DestabilizedRedstone, Things.RedstoneAcid}
Recipes[3].itemsOut = {Things.Substrate, Things.DestabilizedRedstone, Things.RedstoneAcid}
Recipes[4].itemsOut = {Things.Biodiesel, Things.Glycerol}
Recipes[5].itemsOut = {Things.LiquidForce, Things.GoldenPower}

return {
  recipes = Recipes,
  machines = {
    HotThermo = CompositeMachines.HotThermo,
    LatexMaker = CompositeMachines.LatexMaker,
    FabricationMatrix = CompositeMachines.FabricationMatrix
  },
  detectable = {
    Machines.SuperCooler           ,
    Machines.SporesRecreator       ,
    Machines.MechanicalSqueezer    ,
    Machines.LatexProcessingUnit   ,
    Machines.PhytogenicInsolator   ,
    Machines.Pulverizer            ,
    Machines.FluidEncapsulator     ,
    Machines.RedstoneFurnace       ,
    Machines.MagmaCrucible         ,
    Machines.Pyrolyzer             ,
    Machines.Crafter3              ,
    Machines.FractioningStill      ,
    Machines.Inscriber             ,
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
    AnnihilationCore = Things.AnnihilationCore
    }
}


