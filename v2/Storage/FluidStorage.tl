require "v2/Factory/Item"
require "v2/Storage/Common"
require "ccapi"

--Comments left in to illustrate differences with ItemStorage API
--Big difference between this and ItemStorage is no concept of slot numbers in push/pull
--HOWEVER you can still get slot numbers from list() for some reason
global record FluidStorage
  getPeripheralName : function(storage: FluidStorage | string) : string

  peripheralName: string
  peripheral: peripheral.fluid_storage
  list: function(self: FluidStorage, filter: Fluid | string | nil) : {integer : SlotContents}
  count: function (self: FluidStorage, Fluid: Fluid | string | nil) : integer
  find: function(self: FluidStorage, Fluid: Fluid | string) : boolean,integer | nil --Found,Count
  counts: function(self: FluidStorage) : { string : integer }

  push: function (
    self: FluidStorage,
    to : FluidStorage | string, 
    Fluid: Fluid | string,   --Fluid: Fluid | integer | string, 
    count: integer | nil
    --toSlot: integer | nil
  ) : integer
    
  pushAll: function(
    self: FluidStorage,
    to : FluidStorage | string, 
    Fluid: Fluid | string | nil, 
    count: integer | nil
    --toSlot: integer | nil
  ) : integer

  pushMax: function(
    self: FluidStorage,
    to : FluidStorage | string, 
    fluid: Fluid | string, 
    max: integer,
    --toSlot: integer | nil,
    min: integer | nil) : integer

  pull: function (
    self: FluidStorage,
    from : FluidStorage | string, 
    fluid: Fluid | string,   --fluid: Fluid | integer | string,   --No concept of a "slot" with push / pull fluids
    count: integer | nil
    --toSlot: integer | nil
  ) : integer
    
  pullAll: function(
    self: FluidStorage,
    from : FluidStorage | string, 
    fluid: Fluid | string | nil, 
    count: integer | nil
    --toSlot: integer | nil
  ) : integer

end

function FluidStorage.new(peripheralName: string): FluidStorage
local self: FluidStorage = setmetatable({}, { __index = FluidStorage })
  self.peripheralName = peripheralName
  self.peripheral = peripheral.wrap(peripheralName) as peripheral.fluid_storage
return self
end

function FluidStorage.getPeripheralName(storage: FluidStorage | string) : string
  if storage is string then
    return storage
  elseif storage is FluidStorage then
    return storage.peripheralName
  end
end

local record FluidStorageWrapper
  peripheralName: string
  FluidStorage: FluidStorage | nil
end

function FluidStorage:getFluid(slot: integer) : SlotContents
  return self:list()[slot]
end

function FluidStorage:counts() : { string : integer}
  local counts : { string : integer }
  for _,fluid in pairs(self:list()) do
    if fluid ~= nil then
      local count = counts[Fluid.name]
      if count == nil then
        counts[Fluid.name] = fluid.count
      else
        counts[Fluid.name] = fluid.count + count
      end
    end
  end
  return counts
end

function FluidStorageWrapper:getFluidStorage() : FluidStorage
  local fluidStorage = self.FluidStorage
  if fluidStorage is FluidStorage then return fluidStorage end
  error("'".. self.peripheralName .."' does not support the fluid_storage API")
end

function FluidStorage.isFluidStorage(name: string) : boolean
  local types = {peripheral.getType(name)}
  for _,t in ipairs(types) do
    if t == "fluid_storage" then return true end
  end
  return false
end

function FluidStorageWrapper.new(block : FluidStorage | string): FluidStorageWrapper
  local self: FluidStorageWrapper = setmetatable({}, { __index = FluidStorageWrapper })
  if block is string then
    self.peripheralName = block
    if FluidStorage.isFluidStorage(block) then 
      self.FluidStorage = FluidStorage.new(block) 
    end
  elseif block is FluidStorage then
    self.peripheralName = FluidStorage.peripheralName
    self.FluidStorage = block
  end
  return self
end

function FluidStorage:count(fluid: Fluid | string | nil) : integer
  local count = 0

  if fluid is nil then
    for _,x in pairs(self:list()) do
      count = count + x.count
    end
    return count
  elseif fluid is Fluid | string then
    for _,cursor in pairs(self:list(fluid)) do
      count = count + cursor.count
    end
    return count
  end
end

function FluidStorage:find(fluid: Fluid | string) : boolean,integer | nil --Found,Count
  for _,details in pairs(self:list(fluid)) do
    return true, details.count
  end
  return false
end

-- Push a single Fluid to the designated storage. 
-- Use pushAll to push more than one Fluid
function FluidStorage:push(
  to : FluidStorage | string, 
  fluid: Fluid | string, 
  count: integer | nil) : integer

  local fluidName = Fluid.getName(fluid)
  local peripheralName = FluidStorage.getPeripheralName(to)

  local found = self:find(Fluid)
  if found then
    return self.peripheral.pushFluid(peripheralName,count,fluidName)
  else
    return 0
  end
end

function FluidStorage:pushAll(
  to : FluidStorage | string, 
  fluid: Fluid | string | nil, 
  count: integer | nil) : integer

  local total = 0
  local peripheralName = FluidStorage.getPeripheralName(to)

  local toMove : { integer : SlotContents }

  if fluid is nil then
    toMove = self:list()
  elseif fluid is Fluid | string then
    toMove = self:list(fluid)
  end

  for _,slot in pairs(toMove) do
    local moved = self.peripheral.pushFluid(peripheralName,count,slot.name)
    if moved == 0 then break end
    count = count - moved
    if count == 0 then break end
    total = total + moved
  end

  return total
end

function FluidStorage:pushMax(
  to : FluidStorage | string, 
  fluid: Fluid | string, 
  max: integer,
  min: integer | nil) : integer

  local _to = FluidStorageWrapper.new(to)

  local count : integer
  count = max - _to:getFluidStorage():count(fluid)

  if min is integer then
    if count > min then return 0 end
  end

  return self:pushAll(to, fluid, count)
end

function FluidStorage:pull(
  from : FluidStorage | string, 
  fluid: Fluid | string, 
  count: integer | nil) : integer

  local _from = FluidStorageWrapper.new(from)
  local fluidName = Fluid.getName(fluid)

  if _from.FluidStorage == nil then
    return self.peripheral.pullFluid(_from.peripheralName,count,fluidName)
  else
    local found = _from:getFluidStorage():find(Fluid)
    if found then
      return self.peripheral.pullFluid(_from.peripheralName,count,fluidName)
    else
      return 0
    end
  end
end

function FluidStorage:pullAll(
  from : FluidStorage | string, 
  fluid: Fluid | string | nil, 
  count: integer | nil) : integer

  local _from = FluidStorageWrapper.new(from)

  local total = 0

  local toMove : { integer : SlotContents }

  --If the remote storage doesn't have the Fluid API, just brute-force it
  if _from.FluidStorage == nil then
    repeat
    local moved = self.peripheral.pullFluid(_from.peripheralName, count)
    if moved == 0 then break end
    count = count - moved
    total = total + moved
    until count <= 0
    return total
  end

  if fluid is nil then
    toMove = _from:getFluidStorage():list()
  elseif fluid is Fluid | string then
    toMove = _from:getFluidStorage():list(fluid)
  end

  for _,slot in pairs(toMove) do
    local moved = total + self.peripheral.pullFluid(_from.peripheralName,count,slot.name)
    count = count - moved
    if count <= 0 then break end
    total = total + moved
  end
  return total
end

