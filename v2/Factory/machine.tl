require "v2/Factory/Item"
require "v2/Factory/Recipe"
require "v2/Storage"

global record MachineType
  type machineWorker = function(self:Machine, storage : Storage, recipe : Recipe)
  type machineClearer = function(self:Machine, storage : Storage)

  new: function(id : string, name : string, worker : machineWorker | nil, clearer : machineClearer | nil) : MachineType
  parse: function(name : string) : string

  id : string
  name : string

  worker: machineWorker
  clearer: machineWorker
end

global record Machine
  new: function(machineType: MachineType) : Machine

  type: MachineType
  storage : Storage
  work: MachineType.machineWorker
  clear: MachineType.machineWorker
end

function Machine.new(machineType: MachineType) : Machine
  local self: Machine = setmetatable({}, { __index = Machine })
  self.type = machineType
  self.work = machineType.worker
  self.clear = machineType.clearer
  return self
end

local function defaultWorker(machine:Machine, storage : Storage, recipe : Recipe)
  if recipe.thing:is("Item") then
    storage.item:pullAll(machine.storage.item, recipe.thing as Item)
  elseif recipe.thing:is("Fluid") then
    storage.fluid:pullAll(machine.storage.fluid, recipe.thing as Fluid)
  end

  for _,thing in ipairs(recipe.inputs) do
    if thing:is("Item") then
      storage.item:pushMax(machine.storage.item, thing as Item, 32, nil, 16)
    elseif thing:is("Fluid") then
      storage.item:pushMax(machine.storage.item, thing as Item, 4000, nil, 2000)
    end
  end
end

local function defaultClearer(machine:Machine, storage : Storage)
  storage.item:pullAll(machine.storage.item)
  storage.fluid:pullAll(machine.storage.fluid)
end

function MachineType.new(id : string, name : string, worker : MachineType.machineWorker | nil, clearer : MachineType.machineClearer | nil) : MachineType
  local self: MachineType = setmetatable({}, { __index = MachineType })
  self.id = id
  self.name = name
  self.worker = worker or defaultWorker
  self.clearer = clearer or defaultClearer
end




global record PeripheralMachine
  new: function(peripheralID : string, machineType: MachineType) : PeripheralMachine

  peripheral: peripheral

  --Inherited
  type: MachineType
  work: MachineType.machineWorker
  clear: MachineType.machineClearer
end
setmetatable(PeripheralMachine, {__index = Machine})

function PeripheralMachine.new(peripheralID : string, machineType: MachineType) : PeripheralMachine
  local self: PeripheralMachine = setmetatable(Machine.new(machineType) as PeripheralMachine, { __index = Item })
  self.peripheral = peripheral.wrap(peripheralID)
  return self
end


--Push things to a machine from storage
-- function Factory:push(
--   machine: Machine, 
--   thing: Thing, 
--   max: integer | nil, 
--   toSlot: integer | nil, 
--   min: integer | nil
-- ) : integer
--   if thing:is("Item") then
--     local item = thing as Item
--     if max is integer then
--       return self.itemStorage:pushMax(machine.peripheralName, item, max, toSlot, min)
--     else
--       return self.itemStorage:push(machine.peripheralName, item, nil, toSlot)
--     end
--   elseif thing:is("Fluid") then
--     local fluid = thing as Fluid
--     if max is integer then
--       return self.fluidStorage:pushMax(machine.peripheralName, fluid, max, min)
--     else
--       return self.fluidStorage:push(machine.peripheralName, fluid, nil)
--     end
--   end
-- end

-- --Pull things from a machine to storage
-- function Factory:pull(machine: Machine, thing: Thing) : integer
--   if thing:is("Item") then
--     return self.itemStorage:pull(machine.peripheralName, thing as Item)
--   elseif thing:is("Fluid") then
--     return self.fluidStorage:push(machine.peripheralName, thing as Fluid)
--   end
-- end


-- local function parseTypeFromName(name : string) : string
--   local lastIndex = name:match(".*()%_") as integer
--   if lastIndex then
--       return name:sub(1, lastIndex - 1)
--   else
--       return name
--   end
-- end

