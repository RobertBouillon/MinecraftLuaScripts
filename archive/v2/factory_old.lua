local inventory   = require("item_storage")
local fluids      = require("fluid_storage")
local key_monitor = require("key_monitor")
local keys        = require("keys")

local ITEM_STORAGE   = inventory.wrap  ("functionalstorage:storage_controller_0")
local FLUID_STORAGE  = fluids.wrap     ("functionalstorage:storage_controller_0")
local FLUID_OVERFLOW = nil

local FLUID = {
	WATER         = "minecraft:water",
}

local ITEM = {
	MUSHROOM      = "minecraft:red_mushroom",
	YEAST         = "pneumaticcraft:yeast_culture",
	POTATO        = "minecraft:potato",
	VEGETABLE_OIL = "pneumaticcraft:vegetable_oil",
	ETHANOL 	    = "pneumaticcraft:ethanol",
	BIODIESEL 	  = "pneumaticcraft:biodiesel",
	GLYCEROL 	    = "pneumaticcraft:glycerol",
	SAPLING		    = "minecraft:oak_sapling",
	OAK			      = "minecraft:oak_log",
	SULFUR        = "thermal:sulfur",
	SULFUR_DUST   = "mekanism:dust_sulfur",
	LAVA          = "minecraft:lava",
	ETHYLENE      = "mekanism:ethene",
	LATEX         = "industrialforegoing:latex",
	TINY_RUBBER   = "industrialforegoing:tinydryrubber",
	DRY_RUBBER    = "industrialforegoing:dryrubber",
	PLASTIC       = "industrialforegoing:plastic",
	LDPE          = "ftbskies:ldpe_sheet",
	POLYETHYLENE  = "ftbskies:polyethylene",
	MOLTEN_SILVER = "ftbskies:molten_silver",
	ACET          = "immersiveengineering:acetaldehyde",
	DUROPLAST     = "immersiveengineering:plate_duroplast",
	SILVER        = "occultism:silver_ingot",
	RAW_SILVER    = "occultism:raw_silver",
	PHELONIC_RESIN= "immersiveengineering:phenolic_resin",
	PAPER         = "minecraft:paper",
	MENRIL_LOG    = "integrateddynamics:menril_log",
	MENRIL_SAPLING= "integrateddynamics:menril_sapling",
	MENRIL_RESIN  = "integrateddynamics:menril_resin",
	FORCE_SAPLING = "forcecraft:force_sapling",
	FORCE_LOG     = "forcecraft:force_log",
	FORCE_PLANKS  = "forcecraft:force_planks",
	LIQUID_FORCE  = "forcecraft:fluid_force_source",
	MENRIL_CRYSTAL= "integrateddynamics:crystalized_menril_chunk",
	CINNABAR      = "thermal:cinnabar",
	GOLDEN_POWER  = "forcecraft:golden_power_source",
	MANA_POWDER   = "botania:mana_powder",
	QUICKSILVER   = "hexerei:quicksilver_fluid"
}

local function useSporesRecreator(machine)
  ITEM_STORAGE.pull(machine)

  FLUID_STORAGE.push(FLUID.WATER)
  ITEM_STORAGE.pushMax(machine, ITEM.MUSHROOM, 64)
  
  --HACK
  -- local _,slot = STORAGE.find(MUSHROOM)
  -- local m = peripheral.wrap(machine.name)
  -- if slot ~= nil then 
  --   m.pullItems(STORAGE.name,slot,3)
  -- end

  -- local _,toSlot = STORAGE.find(MUSHROOM)

  -- for slot,item in pairs(m.list()) do
  --   if slot >= 6 then
	-- 	  m.pushItems(STORAGE.name,slot, nil, toSlot)
	--   end
  -- end
  -- --/HACK
  
  -- FLUIDS.push(machine.name, WATER)
end

local function usePhyto(machine, recipe)
  FLUID_STORAGE.push(FLUID.WATER)

  ITEM_STORAGE.pullRange(machine, 3)
  if recipe.ItemsIn ~= nil then
    ITEM_STORAGE.push(machine,recipe.ItemsIn)
  else
    ITEM_STORAGE.push(machine,recipe.Item)
  end
end

local MACHINE = {
  SPORES_RECREATOR 	    = { ID = "industrialforegoing:spores_recreator",  Worker = useSporesRecreator },
  PHYTOGENIC_INSOLATOR 	= { ID = "thermal:machine_insolator",             Worker = usePhyto }
}

local RECIPE = {
  {
    Item =      ITEM.MUSHROOM,
    Machine =   MACHINE.SPORES_RECREATOR,
  },
  {
    Item =      ITEM.POTATO,
    Machine =   MACHINE.PHYTOGENIC_INSOLATOR,
  },
  {
    Item =      ITEM.OAK,
    Machine =   MACHINE.PHYTOGENIC_INSOLATOR,
    ItemsIn =   ITEM.SAPLING
  },
}


local factory = {
  Recipes = {},
  AvailableMachines = {},
  AllocatedMachines = {},
  Quotas = {}
}

local function parseTypeFromName(name)
  return string.sub(1, string.find(name,"_n+$",1,true))
end

local function clearMachine(machine)
  ITEM_STORAGE.pull(machine)
  FLUID_STORAGE.pull(machine)

  FLUID_OVERFLOW.pull(machine)
end

local function registerMachine(id)
  local type =  parseTypeFromName(id)
  local machines = factory.AvailableMachines[type]
  if machines == nil then
    machines = {}
    factory.AvailableMachines[type] = machines
  end
  table.insert(machines, name)
end

local function allocateMachine(item, type)
  local machines = factory.AvailableMachines[type]
  if machines == nil then return nil end
  for i,id in pairs(machines) do
    table.remove(machines, i)
    factory.AllocatedMachines[item] = id
    return id;
  end
  return nil
end

local function freeMachine(item)
  local id = factory.AllocatedMachines[item]
  table.remove(factory.AllocatedMachines, id)
  table.insert(factory.AvailableMachines, id)
  clearMachine(id)
end

local function registerMachines()
  for _,id in pairs(peripheral.getNames()) do
    registerMachine(id)
  end
end

local function clearMachines()
  for _,machines in pairs(factory.AvailableMachines) do
    for _,machine in pairs(machines) do
      clearMachine(machine)
    end
  end
end

function factory.start()
  registerMachines()
  clearMachines()
end

function factory.make(item,amount)
  table.insert(factory.Quotas,{Item=item,Amount=amount})
end

local function runFactory()

  local runlog = {}

  for _,quota in pairs(factory.Quotas) do
    if ITEM_STORAGE.count(quota.Item) < quota.Amount then
      if factory.AllocatedMachines[quota.Item] == nil then --Start making
        local recipe = factory.Recipes[quota.Item]
        if recipe == nil then runlog[quota.Item] = "Recipe not found" end
        local allocatedMachine = allocateMachine(quota.item, recipe.Machine)
        if allocatedMachine == nil then runlog[quota.Item] = "Machine not available" end
      end
    else
      local machine = factory.AllocatedMachines[quota.Item]
      if machine ~= nil then --Stop making
        freeMachine(machine)
      end
    end
  end

  for item,machine in pairs(factory.AllocatedMachines) do
    local recipe = factory.Recipes[item]
    machine.Worker(machine, recipe)
  end

  local keyPressed, key key_monitor.isKeyPressed()
  if keyPressed then
    if key == keys.Q then return end
  end
end

function factory.run()
  parallel.waitForAny(runFactory, key_monitor.key_monitor)
end

factory.run()