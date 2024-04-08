require "tl/Factory/Item"
require "tl/Storage/Common"
require "tl/ccapi"

--Comments left in to illustrate differences with ItemStorage API
--Big difference between this and ItemStorage is no concept of slot numbers in push/pull
--HOWEVER you can still get slot numbers from list() for some reason
global record FluidStorage
  record TankContents
    name: string
    amount: integer
  end

  getPeripheralName : function(storage: FluidStorage | string) : string
  isFluidStorage: function (name: string) : boolean

  peripheralName: string
  peripheral: peripheral.fluid_storage
  list: function(self: FluidStorage, filter: Fluid | string | nil) : {TankContents}
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
    max: integer | nil,
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
  if not FluidStorage.isFluidStorage(peripheralName) then error ("'" .. peripheralName .. "' does not implement the fluid_storage API") end
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

function FluidStorage:getFluid(slot: integer) : FluidStorage.TankContents
  return self:list()[slot]
end

function FluidStorage:list(filter: Fluid | string | nil) : {FluidStorage.TankContents}
  local list = self.peripheral.tanks() as { integer : FluidStorage.TankContents }  -- Sometimes comes with slot numbers for some reason *shrug*
  if filter is nil then return list end
  local id : string
  if filter is string then id = filter
  elseif filter is Fluid then id = filter.id
  elseif filter is nil then return list end
  local filtered : { FluidStorage.TankContents } = {}
  for _,contents in pairs(list) do
    if contents.name == id then
      table.insert(filtered, contents)
    end
  end
  return filtered
end



function FluidStorage:counts() : { string : integer}
  local counts : { string : integer }
  for _,fluid in ipairs(self:list()) do
    if fluid ~= nil then
      local count = counts[Fluid.name]
      if count == nil then
        counts[Fluid.name] = fluid.amount
      else
        counts[Fluid.name] = fluid.amount + count
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
    self.peripheralName = block.peripheralName
    self.FluidStorage = block
  end
  return self
end

function FluidStorage:count(fluid: Fluid | string | nil) : integer
  local count = 0

  if fluid is nil then
    for _,x in ipairs(self:list()) do
      count = count + x.amount
    end
    return count
  elseif fluid is Fluid | string then
    for _,cursor in ipairs(self:list(fluid)) do
      count = count + cursor.amount
    end
    return count
  end
end

function FluidStorage:find(fluid: Fluid | string) : boolean,integer | nil --Found,Count
  for _,details in ipairs(self:list(fluid)) do
    return true, details.amount
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

  local toMove : { integer : FluidStorage.TankContents }

  if fluid is nil then
    toMove = self:list()
  elseif fluid is Fluid | string then
    toMove = self:list(fluid)
  end

  for _,slot in pairs(toMove) do
    local moved = self.peripheral.pushFluid(peripheralName,count,slot.name)
    if moved == 0 then break end
    if count is integer then
      count = count - moved
      if count == 0 then break end
    end
    total = total + moved
  end

  return total
end

function FluidStorage:pushMax(
  to : FluidStorage | string, 
  fluid: Fluid | string, 
  max: integer | nil,
  min: integer | nil) : integer

  local _to = FluidStorageWrapper.new(to)

  local count : integer
  count = _to:getFluidStorage():count(fluid)

  if min is integer then
    if count > min then return 0 end
  end

  if max is integer then
    count = max - count
  else
    count = nil
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

  local toMove : { integer : FluidStorage.TankContents }

  --If the remote storage doesn't have the Fluid API, just brute-force it
  if _from.FluidStorage == nil then
    count = count or 1000000
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
    if count is integer then
      count = count - moved
      if count <= 0 then break end
    end
    total = total + moved
  end
  return total
end

