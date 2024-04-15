local inv     = require("inventory")
local fluids  = require("fluids")
local timer  = require("timer")

local STORAGE   = inv.wrap      ("functionalstorage:storage_controller_0")
local FLUIDS    = fluids.wrap   ("functionalstorage:storage_controller_0")

local MUSHROOM      = "minecraft:red_mushroom"
local WATER         = "minecraft:water"
local YEAST         = "pneumaticcraft:yeast_culture"
local POTATO        = "minecraft:potato"
local VEGETABLE_OIL = "pneumaticcraft:vegetable_oil"
local ETHANOL 		  = "pneumaticcraft:ethanol"
local BIODIESEL 	  = "pneumaticcraft:biodiesel"
local GLYCEROL 		  = "pneumaticcraft:glycerol"
local SAPLING		    = "minecraft:oak_sapling"
local OAK			      = "minecraft:oak_log"
local SULFUR        = "thermal:sulfur"
local SULFUR_DUST   = "mekanism:dust_sulfur"
local LAVA          = "minecraft:lava"
local ETHYLENE      = "mekanism:ethene"
local LATEX         = "industrialforegoing:latex"
local TINY_RUBBER   = "industrialforegoing:tinydryrubber"
local DRY_RUBBER    = "industrialforegoing:dryrubber"
local PLASTIC       = "industrialforegoing:plastic"
local LDPE          = "ftbskies:ldpe_sheet"
local POLYETHYLENE  = "ftbskies:polyethylene"
local MOLTEN_SILVER = "ftbskies:molten_silver"
local ACET          = "immersiveengineering:acetaldehyde"
local DUROPLAST     = "immersiveengineering:plate_duroplast"
local SILVER        = "occultism:silver_ingot"
local RAW_SILVER    = "occultism:raw_silver"
local PHELONIC_RESIN= "immersiveengineering:phenolic_resin"
local PAPER         = "minecraft:paper"
local MENRIL_LOG    = "integrateddynamics:menril_log"
local MENRIL_SAPLING= "integrateddynamics:menril_sapling"
local MENRIL_RESIN  = "integrateddynamics:menril_resin"
local FORCE_SAPLING = "forcecraft:force_sapling"
local FORCE_LOG     = "forcecraft:force_log"
local FORCE_PLANKS  = "forcecraft:force_planks"
local LIQUID_FORCE  = "forcecraft:fluid_force_source"
local MENRIL_CRYSTAL= "integrateddynamics:crystalized_menril_chunk"
local CINNABAR      = "thermal:cinnabar"
local GOLDEN_POWER  = "forcecraft:golden_power_source"
local MANA_POWDER   = "botania:mana_powder"
local QUICKSILVER   = "hexerei:quicksilver_fluid"

local MUSHROOM_MAX    = 2000
local POTATO_MAX      = 2000
local OAK_MAX         = 10000
local SULFUR_DUST_MAX = 2000
local PLASTIC_MAX     = 2000
local LDPE_MAX        = 2000
local BIODIESEL_MAX   = 4000000
local MENRIL_LOG_MAX  = 2000
local FORCE_LOG_MAX   = 2000
local FORCE_PLANKS_MAX= 2000
local MENRIL_CRYSTAL_MAX=200
local DUROPLAST_MAX   = 64

local function makeYeast(machine)
  STORAGE.push(machine, MUSHROOM)
  FLUIDS.push(machine.name, WATER)
  FLUIDS.pull(machine.name, YEAST)
end

local function makeMushrooms(machine)
  if STORAGE.count(MUSHROOM) > MUSHROOM_MAX then return end
  -- Have to handle this manually
  -- https://github.com/cc-tweaked/CC-Tweaked/issues/1764#issuecomment-2018681013

  --STORAGE.push(machine, MUSHROOM)
  --machine.push(storage, MUSHROOM)

  --HACK
  local _,slot = STORAGE.find(MUSHROOM)
  local m = peripheral.wrap(machine.name)
  if slot ~= nil then 
    m.pullItems(STORAGE.name,slot,3)
  end
  
  local _,toSlot = STORAGE.find(MUSHROOM)

  for slot,item in pairs(m.list()) do
    if slot >= 6 then
		  m.pushItems(STORAGE.name,slot, nil, toSlot)
	  end
  end
  --/HACK
  
  FLUIDS.push(machine.name, WATER)
end

local function makeVegetableOil(machine, crop)
  if crop == nil then crop = POTATO end
  STORAGE.push(machine, crop)
  FLUIDS.pull(machine.name, VEGETABLE_OIL)
end

local function makeEthanol(machine, crop)
  if crop == nil then crop = POTATO end
  STORAGE.push(machine, crop)
  FLUIDS.push(machine.name, YEAST)
  FLUIDS.pull(machine.name, ETHANOL)
end

local function makeBiodiesel(vo,ethanol,biod,glycerol)
  if FLUIDS.count(BIODIESEL) > BIODIESEL_MAX then return end
  FLUIDS.pushMax(vo, VEGETABLE_OIL, 400)
  FLUIDS.pushMax(ethanol, ETHANOL, 400)
  
  FLUIDS.pull(biod)
  --STORAGE.pull(glycerol)
  peripheral.call(glycerol,"pushItems",STORAGE.name,1)
end

local function usePhyto(machine,seed)
  FLUIDS.push(machine.name, WATER)

  --STORAGE.pull(machine,POTATO,nil,1)
  --Only push output
  for slot,_ in pairs(machine.list()) do
    if slot > 1 then
  		machine.push(STORAGE.name,slot)
    end
  end
  STORAGE.push(machine,seed)
end

local function usePulverizer(machine,item)
  STORAGE.push(machine,item)

  for slot,_ in pairs(machine.list()) do
    if slot > 1 then
		machine.push(STORAGE.name,slot)
	end
  end
end

local function fillItems(machine,item,maxCount)
  local count = maxCount - machine.count(item)
  machine.pull(STORAGE,item,count,1)
end

local function makeLatex(placer,extractor)
  local count = placer.count(item)
  if count < 1 then
    local _, oak = STORAGE.find(OAK)
	peripheral.call(placer.name,"pullItems",STORAGE.name,oak,1,1)
  end
  FLUIDS.pull(extractor.name)
end

local function heatMachines(obsidian, placer)
  FLUIDS.pushMax(placer, LAVA, 1000)
  obsidian.push(STORAGE)
end

local function makeEthylene(machine)
  FLUIDS.push(machine, ETHANOL, 1000)
  STORAGE.push(machine,SULFUR_DUST)

  FLUIDS.pull(machine)
end

local function makePolyethylene(machine)
  FLUIDS.push(machine, ETHYLENE, 1000)
  FLUIDS.push(machine, LATEX, 1000)

  FLUIDS.pull(machine)
end

local function makePotatoes(machine)
  if STORAGE.count(POTATO) > POTATO_MAX then return end
  usePhyto(machine,POTATO)
end

local function makeOak(machine)
  if STORAGE.count(OAK) > OAK_MAX then return end
  usePhyto(machine,SAPLING)
end

local function makeMenrilLogs(machine)
  if STORAGE.count(MENRIL_LOG) > MENRIL_LOG_MAX then return end
  usePhyto(machine,MENRIL_SAPLING)
end

local function makeForceLogs(machine)
  if STORAGE.count(FORCE_LOG) > FORCE_LOG_MAX then return end
  usePhyto(machine,FORCE_SAPLING)
end

local function makeTinyRubber(machine)
  FLUIDS.push(machine, LATEX, 1000)
  FLUIDS.push(machine, WATER, 1000)
  STORAGE.pull(machine)
end

local function makeRubber(machine)
  STORAGE.push(machine, TINY_RUBBER)
  STORAGE.pull(machine, DRY_RUBBER)
end

local function makePlastic(machine)
  if STORAGE.count(PLASTIC) > PLASTIC_MAX then return end

  STORAGE.push(machine, DRY_RUBBER)
  STORAGE.pull(machine, PLASTIC)
end

local function makeLPDE(machine)
  if STORAGE.count(LDPE) > LDPE_MAX then return end

  STORAGE.push(machine, PLASTIC)
  FLUIDS.push(machine, POLYETHYLENE)

  STORAGE.pull(machine, LDPE)
end

local function makeMoltenSilver(machine)
  STORAGE.push(machine, SILVER)

  FLUIDS.pull(machine.name)
end

local function makeAcet(machine)
  FLUIDS.push(machine,MOLTEN_SILVER)
  FLUIDS.push(machine,ETHANOL)

  FLUIDS.pull(machine)
end

local function makePhelonicResin(machine)
  FLUIDS.push(machine,LATEX)
  FLUIDS.push(machine,ACET)

  FLUIDS.pull(machine,PHELONIC_RESIN)
end

local function makeDuroplast(machine)
  if STORAGE.count(DUROPLAST) > DUROPLAST_MAX then return end

  FLUIDS.push(machine, PHELONIC_RESIN)
  STORAGE.push(machine, PAPER)

  STORAGE.pull(machine, DUROPLAST)
end

local function makeMenrilResin(machine)
  if STORAGE.count(MENRIL_CRYSTAL) > MENRIL_CRYSTAL_MAX then return end

  STORAGE.push(machine, MENRIL_LOG)
  FLUIDS.pull(machine)
  STORAGE.pull(machine, MENRIL_CRYSTAL)
end

local function cookMenrilCrystals(machine)
  STORAGE.push(machine, MENRIL_CRYSTAL)
  FLUIDS.pull(machine)
end

local function makeForcePlanks(machine)
  if STORAGE.count(FORCE_PLANKS) > FORCE_PLANKS_MAX then return end

  STORAGE.push(machine, FORCE_LOG)
  STORAGE.pull(machine, FORCE_PLANKS)
end

local function makeLiquidForce(machine)
  STORAGE.push(machine, FORCE_PLANKS)

  STORAGE.pull(machine, GOLDEN_POWER)
  FLUIDS.pull(machine)
end


local function makeQuicksilver(machine)
  STORAGE.push(machine, CINNABAR)
  FLUIDS.push(machine, MENRIL_RESIN)

  FLUIDS.pull(machine.name)
end

--Done
local function makeRawSilver(machine)
  STORAGE.pushMax(machine, MANA_POWDER, 64)
  FLUIDS.push(machine, QUICKSILVER)

  STORAGE.pull(machine, RAW_SILVER)
end

local YEAST_MACHINE 	  = inv.wrap("pneumaticcraft:thermopneumatic_processing_plant_0")
local ETHANOL_MACHINE 	= inv.wrap("pneumaticcraft:thermopneumatic_processing_plant_1")
local VE_MACHINE 		    = inv.wrap("pneumaticcraft:thermopneumatic_processing_plant_2")
local MUSHROOM_MACHINE 	= inv.wrap("industrialforegoing:spores_recreator_0")
local POTATO_MACHINE	  = inv.wrap("thermal:machine_insolator_0")
local OAK_MACHINE		    = inv.wrap("thermal:machine_insolator_1")
local LATEX_PLACER_MACHINE    = inv.wrap("industrialforegoing:block_placer_0")
local LATEX_EXTRACTOR_MACHINE = inv.wrap("industrialforegoing:fluid_extractor_0")
local GENERATOR 		    = inv.wrap("custommachinery:custom_machine_tile_0")
local IN_BIOD_VO 		    = "functionalstorage:fluid_1_4"
local IN_BIOD_ETHANOL	  = "functionalstorage:fluid_1_6"
local OUT_BIOD			    = "functionalstorage:fluid_1_3"
local OUT_GLYCEROL		  = "functionalstorage:oak_1_4"
local SULFUR_MACHINE	  = inv.wrap("thermal:machine_pulverizer_0")
local HEAT_OBSIDIAN     = inv.wrap("functionalstorage:oak_1_5")
local LAVA_PLACER       = "industrialforegoing:fluid_placer_0"
local ETHYLENE_MACHINE  = inv.wrap("pneumaticcraft:thermopneumatic_processing_plant_4")
local PETHYLENE_MACHINE = inv.wrap("pneumaticcraft:fluid_mixer_0")
local TINY_RUBBER_MACHINE    = inv.wrap("industrialforegoing:latex_processing_unit_0")
local RUBBER_MACHINE    = inv.wrap("thermal:machine_crafter_0")
local PLASTIC_MACHINE   = inv.wrap("thermal:machine_furnace_0")
local LDPE_MACHINE      = inv.wrap("thermal:machine_bottler_2")
local MOLTEN_SILVER_MACHINE = inv.wrap("thermal:machine_crucible_1")
local ACET_MACHINE      = inv.wrap("pneumaticcraft:fluid_mixer_1")
local DUROPLAST_MACHINE = inv.wrap("thermal:machine_bottler_3")
local PHELONIC_RESIN_MACHINE  = inv.wrap("pneumaticcraft:fluid_mixer_2")
local MENRIL_RESIN_MACHINE    = inv.wrap("integrateddynamics:mechanical_squeezer_0")
local MENRIL_LOG_MACHINE      = inv.wrap("thermal:machine_insolator_2")
local FORCE_LOG_MACHINE       = inv.wrap("thermal:machine_insolator_3")
local MENRIL_CRYSTAL_MACHINE  = inv.wrap("thermal:machine_crucible_2")
local FORCE_PLANKS_MACHINE    = inv.wrap("thermal:machine_crafter_1")
local LIQUID_FORCE_MACHINE    = inv.wrap("thermal:machine_pyrolyzer_0")
local QUICKSILVER_MACHINE     = inv.wrap("pneumaticcraft:thermopneumatic_processing_plant_3")
local RAW_SILVER_MACHINE      = inv.wrap("ftbsba:super_cooler_1")



local function runFactory1()  --Must split, otherwise "too many upvalues"
  makeRawSilver(RAW_SILVER_MACHINE)
  makeMoltenSilver(MOLTEN_SILVER_MACHINE)
  makeAcet(ACET_MACHINE)
  makePhelonicResin(PHELONIC_RESIN_MACHINE)
  makeDuroplast(DUROPLAST_MACHINE)

  makeTinyRubber(TINY_RUBBER_MACHINE)
  makeRubber(RUBBER_MACHINE)
  makePlastic(PLASTIC_MACHINE)
  makeLPDE(LDPE_MACHINE)

  heatMachines(HEAT_OBSIDIAN, LAVA_PLACER)
  makeEthylene(ETHYLENE_MACHINE)
  makePolyethylene(PETHYLENE_MACHINE)

  usePulverizer(SULFUR_MACHINE,SULFUR)
	makeYeast(YEAST_MACHINE)
	makeMushrooms(MUSHROOM_MACHINE)
	makeVegetableOil(VE_MACHINE)
	makeEthanol(ETHANOL_MACHINE)
	makeBiodiesel(IN_BIOD_VO, IN_BIOD_ETHANOL, OUT_BIOD, OUT_GLYCEROL)
	makeOak(OAK_MACHINE)
	makePotatoes(POTATO_MACHINE)
	makeLatex(LATEX_PLACER_MACHINE, LATEX_EXTRACTOR_MACHINE)

	FLUIDS.push(GENERATOR.name,BIODIESEL)
end

local function runFactory2()
  makeMenrilLogs(MENRIL_LOG_MACHINE)
  makeForceLogs(FORCE_LOG_MACHINE)
  makeMenrilResin(MENRIL_RESIN_MACHINE)
  cookMenrilCrystals(MENRIL_CRYSTAL_MACHINE)
  makeForcePlanks(FORCE_PLANKS_MACHINE)
  makeLiquidForce(LIQUID_FORCE_MACHINE)
  makeQuicksilver(QUICKSILVER_MACHINE)
end


while true do
  timer.start()
	runFactory1()
  runFactory2()
  term.clear()
  print("Iteration completed in " .. timer.format())
	sleep(0)
end
