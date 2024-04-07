require "v2/Factory/Item"
require "v2/Storage/Common"
require "ccapi"

global record ItemStorage
  getPeripheralName : function(storage: ItemStorage | string) : string

  peripheralName: string
  peripheral: peripheral.inventory
  --find: function(self: ItemStorage, item: Item) : {boolean,integer,integer} --Found,Slot,Count  
  list: function(self: ItemStorage, filter: Item | string | nil) : {integer : SlotContents}
  count: function (self: ItemStorage, item: Item | string | integer | nil) : integer
  countSlots: function (self: ItemStorage, item: Item | string | nil) : integer
  find: function(self: ItemStorage, item: Item | string) : boolean,integer | nil,integer | nil --Found,Slot,Count
  counts: function(self: ItemStorage) : { string : integer}
  size: function(self: ItemStorage) : integer
  getItem: function(self: ItemStorage, slot : integer) : SlotContents
  getItemDetail: function(self: ItemStorage, slot : integer) : SlotContents

  push: function (
    self: ItemStorage,
    to : ItemStorage | string, 
    item: Item | integer | string, 
    count: integer | nil,
    toSlot: integer | nil
  ) : integer
    
  pushAll: function(
    self: ItemStorage,
    to : ItemStorage | string, 
    item: Item | string | nil, 
    count: integer | nil,
    toSlot: integer | nil
  ) : integer

  pushMax: function(
    self: ItemStorage,
    to : ItemStorage | string, 
    item: Item | string, 
    max: integer,
    toSlot: integer | nil,
    min: integer | nil) : integer

  pull: function (
    self: ItemStorage,
    from : ItemStorage | string, 
    item: Item | integer | string, 
    count: integer | nil,
    toSlot: integer | nil
  ) : integer
    
  pullAll: function(
    self: ItemStorage,
    from : ItemStorage | string, 
    item: Item | string | nil, 
    count: integer | nil,
    toSlot: integer | nil
  ) : integer

end


function ItemStorage.new(peripheralName: string): ItemStorage
local self: ItemStorage = setmetatable({}, { __index = ItemStorage })
  self.peripheralName = peripheralName
  self.peripheral = peripheral.wrap(peripheralName) as peripheral.inventory
return self
end

function ItemStorage.getPeripheralName(storage: ItemStorage | string) : string
  if storage is string then
    return storage
  elseif storage is ItemStorage then
    return storage.peripheralName
  end
end

local record ItemStorageWrapper
  peripheralName: string
  itemStorage: ItemStorage | nil
end

function ItemStorage:size() : integer
  return self.peripheral.size()
end

function ItemStorage:getItem(slot: integer) : SlotContents
  return self:list()[slot]
end

function ItemStorage:getItemDetail(slot: integer) : SlotContents
  return self.peripheral.getItemDetail(slot) as SlotContents
end

function ItemStorage:counts() : { string : integer}
  local counts : { string : integer }
  for _,item in pairs(self:list()) do
    if item ~= nil then
      local count = counts[item.name]
      if count == nil then
        counts[item.name] = item.count
      else
        counts[item.name] = item.count + count
      end
    end
  end
  return counts
end

function ItemStorageWrapper:getItemStorage() : ItemStorage
  local itemStorage = self.itemStorage
  if itemStorage is ItemStorage then return itemStorage end
  error("'".. self.peripheralName .."' does not support the inventory API")
end

function ItemStorage.isItemStorage(name: string) : boolean
  local types = {peripheral.getType(name)}
  for _,t in ipairs(types) do
    if t == "inventory" then return true end
  end
  return false
end

function ItemStorageWrapper.new(block : ItemStorage | string): ItemStorageWrapper
  local self: ItemStorageWrapper = setmetatable({}, { __index = ItemStorageWrapper })
  if block is string then
    self.peripheralName = block
    if ItemStorage.isItemStorage(block) then 
      self.itemStorage = ItemStorage.new(block) 
    end
  elseif block is ItemStorage then
    self.peripheralName = ItemStorage.peripheralName
    self.itemStorage = block
  end
  return self
end

function ItemStorage:count(item: Item | string | integer | nil) : integer
  local count = 0

  if item is nil then
    for _,x in pairs(self:list()) do
      count = count + x.count
    end
    return count
  elseif item is integer then
    return self:getItem(item).count
  elseif item is Item | string then
    for _,cursor in pairs(self:list(item)) do
      count = count + cursor.count
    end
    return count
  end
end

function ItemStorage:countSlots(item: Item | string | nil) : integer
  local count = 0

  if item is nil then
    for _ in pairs(self:list()) do
      count = count + 1
    end
    return count
  elseif item is Item | string then
    for _ in pairs(self:list(item)) do
      count = count + 1
    end
    return count
  end
end

function ItemStorage:find(item: Item | string) : boolean,integer | nil,integer | nil --Found,Slot,Count
  for slot,details in pairs(self:list(item)) do
    return true, slot, details.count
  end
  return false
end

-- Push a single item to the designated storage. 
-- Use pushAll to push more than one item
function ItemStorage:push(
  to : ItemStorage | string, 
  item: Item | integer | string, 
  count: integer | nil,
  toSlot: integer | nil) : integer

  local peripheralName = ItemStorage.getPeripheralName(to)

  if item is Item | string then
    local found,slot = self:find(item)
    if found then
      return self.peripheral.pushItems(peripheralName,slot,count,toSlot)
    else
      return 0
    end
  elseif item is integer then
    return self.peripheral.pushItems(peripheralName,item,count,toSlot)
  end
end

function ItemStorage:pushAll(
  to : ItemStorage | string, 
  item: Item | string | nil, 
  count: integer | nil,
  toSlot: integer | nil) : integer

  local peripheralName = ItemStorage.getPeripheralName(to)

  local toMove : { integer : SlotContents }

  if item is nil then
    toMove = self:list()
  elseif item is Item | string then
    toMove = self:list(item)
  end

  local total = 0
  for slot in pairs(toMove) do
    local moved = total + self.peripheral.pushItems(peripheralName,slot,count,toSlot)
    count = count - moved
    if count == 0 then break end
    total = total + moved
  end
  return total
end

function ItemStorage:pushMax(
  to : ItemStorage | string, 
  item: Item | string, 
  max: integer,
  toSlot: integer | nil,
  min: integer | nil) : integer

  local _to = ItemStorageWrapper.new(to)

  local count : integer
  if toSlot is nil then
    count = max - _to:getItemStorage():count(item)
  elseif toSlot is integer then
    count = max - _to:getItemStorage():count(toSlot)
  else
    error(type(toSlot))
  end

  if min is integer then
    if count > min then return 0 end
  end

  return self:pushAll(to, item, count, toSlot)
end

function ItemStorage:pull(
  from : ItemStorage | string, 
  item: Item | integer | string, 
  count: integer | nil,
  toSlot: integer | nil) : integer

  local _from = ItemStorageWrapper.new(from)

  if item is Item | string then
    local found,slot = _from:getItemStorage():find(item)
    if found then
      return self.peripheral.pullItems(_from.peripheralName,slot,count,toSlot)
    else
      return 0
    end
  elseif item is integer then
    return self.peripheral.pullItems(_from.peripheralName,item,count,toSlot)
  end
end

function ItemStorage:pullAll(
  from : ItemStorage | string, 
  item: Item | string | nil, 
  count: integer | nil,
  toSlot: integer | nil) : integer

  local _from = ItemStorageWrapper.new(from)

  local toMove : { integer : SlotContents }

  if item is nil then
    toMove = _from:getItemStorage():list()
  elseif item is Item | string then
    toMove = _from:getItemStorage():list(item)
  end

  local total = 0
  for slot in pairs(self:list(item)) do
    local moved = total + self.peripheral.pullItems(_from.peripheralName,slot,count,toSlot)
    count = count - moved
    if count == 0 then break end
    total = total + moved
  end
  return total
end

