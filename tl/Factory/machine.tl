require "tl/Factory/Item"
require "tl/Storage"
require "tl/Common"

global record Delay
  new: function(interval : number) : Delay
  interval : number
  last : number | nil

  canRun: function(self:Delay) : boolean
end
function Delay.new(interval : number) : Delay
  local self: Delay = setmetatable({},{__index = Delay})
  self.interval = interval
  return self
end

function Delay:canRun() : boolean
  local last = self.last
  if last is number then
    if os.clock() < last + self.interval then return false end
  end
  self.last = os.clock()
  return true
end

global record MachineType
  type machineWorker = function(machine : Machine, storage : Storage, itemsIn : {Thing}, itemsOut: {Thing})
  type machineClearer = function(machine : Machine, storage : Storage)

  new: function(name : string, id : string) : MachineType
  newComposite: function(name : string, ...:MachineType) : MachineType
  parse: function(name : string) : string
  is: function(self: MachineType, peripheralName : string) : boolean

  id : string
  name : string
  types : {MachineType}
  
  worker: machineWorker
  clearer: machineWorker
end

function MachineType:is(peripheralName : string) : boolean
  return self.parse(peripheralName) == self.id
end

function MachineType.parse(name : string) : string
  local lastIndex = name:match(".*()%_") as integer
  if lastIndex then
      return name:sub(1, lastIndex - 1)
  else
      return name
  end
end

global record Machine
  new: function(machineType: MachineType, ...:string|integer) : Machine

  type: MachineType
  peripherals : {string}
  storage : {Storage}
  delay : Delay | nil
  work: function(self:Machine, storage : Storage, itemsIn : {Thing}, itemsOut: {Thing})
  clear: function(self:Machine, storage : Storage)
end

function Machine.new(machineType: MachineType, ... : string | integer) : Machine
  local self: Machine = setmetatable({}, { __index = Machine })
  self.type = machineType
  self.storage = {}
  self.peripherals = {}
  for i,x in ipairs({...}) do
    if x is integer then 
      table.insert(self.peripherals, machineType.types[i].id .. "_" .. x)
    elseif x is string then
      table.insert(self.peripherals, x)
    end
  end

  local expected = #self.type.types
  local specified = #self.peripherals
  if specified ~= expected then
    traceStack()
    error(expected .. " peripherals expected for " .. self.type.name)
  end

  for i,p in ipairs(self.peripherals) do
    if MachineType.parse(p) ~= self.type.types[i].id then
      error("Machine "..i.." is not a "..self.type.types[i].name)
    end
    table.insert(self.storage, Storage.new(p))
  end

  return self
end

function Machine:work(storage : Storage, itemsIn : {Thing}, itemsOut: {Thing})
  self.type.worker(self,storage,itemsIn,itemsOut)
end

function Machine:clear(storage : Storage)
  self.type.clearer(self,storage)
end

local function defaultWorker(machine:Machine, storage : Storage, itemsIn:{Thing}, itemsOut:{Thing})
  --Local storage should always have the APIs
  local item = storage.item as ItemStorage
  local fluid = storage.fluid as FluidStorage

  for _,thing in ipairs(itemsOut) do
    if thing:is("Item") then
      item:pullAll(machine.storage[1].item, thing as Item)
    elseif thing:is("Fluid") then
      fluid:pullAll(machine.storage[1].fluid, thing as Fluid)
    end
  end

  for _,thing in ipairs(itemsIn) do
    if thing:is("Item") then
      item:pushFill(machine.storage[1].item, thing as Item, nil, 16, 32)
    elseif thing:is("Fluid") then
      fluid:pushFill(machine.storage[1].fluid, thing as Fluid, 2000, 4000)
    end
  end
end

local function defaultClearer(machine:Machine, storage : Storage)
  --Local storage should always have the APIs
  local item = storage.item as ItemStorage
  local fluid = storage.fluid as FluidStorage

  --Pull can error if the API doesn't exist. Depends on the machine's implementation
  if type(machine.storage[1].item) ~= "string" then
    item:pullAll(machine.storage[1].item)
  end
  if type(machine.storage[1].fluid) ~= "string" then
    fluid:pullAll(machine.storage[1].fluid)
  end
end

function MachineType.new(name : string, id : string) : MachineType
  local self: MachineType = setmetatable({}, { __index = MachineType })
  self.id = id
  self.name = name
  self.types = {self}
  self.worker = defaultWorker
  self.clearer = defaultClearer
  return self
end

function MachineType.newComposite(name : string, ... : MachineType) : MachineType
  local self: MachineType = setmetatable({}, { __index = MachineType })
  self.name = name
  self.types = {...}
  self.worker = defaultWorker
  self.clearer = defaultClearer
  return self
end
