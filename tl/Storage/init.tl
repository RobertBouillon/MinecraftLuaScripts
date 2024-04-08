require "tl/Storage/FluidStorage"
require "tl/Storage/ItemStorage"

global record Storage
  new: function(peripheralName : string) : Storage
  item : ItemStorage | string     --Storage API may not be supported for remote calls, but we can still use peripheral name
  fluid : FluidStorage | string   --Storage API may not be supported for remote calls, but we can still use peripheral name

  count: function(self: Storage, thing : Thing) : integer
  contains: function(self: Storage, thing : Thing) : boolean
end

function Storage.new(peripheralName : string) : Storage
  local self: Storage = setmetatable({}, { __index = Storage })
  if ItemStorage.isItemStorage(peripheralName) then
    self.item = ItemStorage.new(peripheralName)
  else
    self.item = peripheralName
  end
  if FluidStorage.isFluidStorage(peripheralName) then
    self.fluid = FluidStorage.new(peripheralName)
  else
    self.fluid = peripheralName
  end
  return self
end

function Storage:count(thing: Thing) : integer
  if thing:is("Item") then
    local item = self.item
    if item is ItemStorage then
      return item:count(thing as Item)
    else
      return 0
    end
  elseif thing:is("Fluid") then
    local fluid = self.fluid
    if fluid is FluidStorage then
      return fluid:count(thing as Fluid)
    else
      return 0
    end
  end
end

function Storage:contains(thing: Thing) : boolean
  return self:count(thing) > 0
end

--We know we have item and fluid support
global record HardStorage
  new: function(peripheralName : string) : Storage
  item : ItemStorage
  fluid : FluidStorage

  count: function(self: Storage, thing : Thing) : integer
  contains: function(self: Storage, thing : Thing) : boolean
end

