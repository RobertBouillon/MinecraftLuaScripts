local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local pairs = _tl_compat and _tl_compat.pairs or pairs; require("tl/Factory/Item")
require("tl/Storage/Common")
require("tl/ccapi")
require("tl/common")

ItemStorage = {SlotContents = {}, }























































































function ItemStorage.new(peripheralName)
   local self = setmetatable({}, { __index = ItemStorage })
   self.peripheralName = peripheralName
   if not ItemStorage.isItemStorage(peripheralName) then error("'" .. peripheralName .. "' does not implement the inventory API") end
   self.peripheral = peripheral.wrap(peripheralName)
   return self
end

function ItemStorage.getPeripheralName(storage)
   if type(storage) == "string" then
      return storage
   elseif type(storage) == "table" then
      return storage.peripheralName
   end
end

local ItemStorageWrapper = {}




function ItemStorage:list(filter)
   local list = self.peripheral.list()
   if filter == nil then return list end
   local id
   if type(filter) == "string" then id = filter
   elseif type(filter) == "table" then id = filter.id
   elseif filter == nil then return list end
   local filtered = {}
   for slot, contents in pairs(list) do
      if contents.name == id then
         filtered[slot] = contents
      end
   end
   return filtered
end

function ItemStorage:size()
   return self.peripheral.size()
end

function ItemStorage:getItem(slot)
   return self:list()[slot]
end

function ItemStorage:getItemDetail(slot)
   return self.peripheral.getItemDetail(slot)
end

function ItemStorage:counts()
   local counts
   for _, item in pairs(self:list()) do
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

function ItemStorageWrapper:getItemStorage()
   local itemStorage = self.itemStorage
   if type(itemStorage) == "table" then return itemStorage end
   traceStack()
   error("'" .. self.peripheralName .. "' does not support the inventory API")
end

function ItemStorage.isItemStorage(name)
   local types = { peripheral.getType(name) }
   for _, t in ipairs(types) do
      if t == "inventory" then return true end
   end
   return false
end

function ItemStorageWrapper.new(block)
   local self = setmetatable({}, { __index = ItemStorageWrapper })
   if type(block) == "string" then
      self.peripheralName = block
      if ItemStorage.isItemStorage(block) then
         self.itemStorage = ItemStorage.new(block)
      end
   elseif type(block) == "table" then
      self.peripheralName = block.peripheralName
      self.itemStorage = block
   end
   return self
end

function ItemStorage:count(item)
   local count = 0

   if item == nil then
      for _, x in pairs(self:list()) do
         count = count + x.count
      end
      return count
   elseif math.type(item) == "integer" then
      local contents = self:getItem(item)
      if contents == nil then return 0 else return contents.count end
   elseif type(item) == "table" then
      for _, cursor in pairs(self:list(item)) do
         count = count + cursor.count
      end
      return count
   end
end

function ItemStorage:countSlots(item)
   local count = 0

   if item == nil then
      for _ in pairs(self:list()) do
         count = count + 1
      end
      return count
   elseif type(item) == "table" then
      for _ in pairs(self:list(item)) do
         count = count + 1
      end
      return count
   end
end

function ItemStorage:find(item)
   for slot, details in pairs(self:list(item)) do
      return true, slot, details.count
   end
   return false
end



function ItemStorage:push(   to,
   item,
   count,
   toSlot)

   local peripheralName = ItemStorage.getPeripheralName(to)

   if type(item) == "table" then
      local found, slot = self:find(item)
      if found then
         return self.peripheral.pushItems(peripheralName, slot, count, toSlot)
      else
         return 0
      end
   elseif math.type(item) == "integer" then
      return self.peripheral.pushItems(peripheralName, item, count, toSlot)
   end
end

function ItemStorage:pushAll(   to,
   item,
   count,
   toSlot)

   local peripheralName = ItemStorage.getPeripheralName(to)

   local toMove

   if item == nil then
      toMove = self:list()
   elseif type(item) == "table" then
      toMove = self:list(item)
   end

   local total = 0
   for slot in pairs(toMove) do
      local moved = total + self.peripheral.pushItems(peripheralName, slot, count, toSlot)
      if math.type(count) == "integer" then
         count = count - moved
         if count == 0 then break end
      end
      total = total + moved
   end
   return total
end


function ItemStorage:pushMax(   to,
   item,
   max,
   toSlot,
   min)

   local _to = ItemStorageWrapper.new(to)

   local count
   if toSlot == nil then
      count = _to:getItemStorage():count(item)
   elseif math.type(toSlot) == "integer" then
      count = _to:getItemStorage():count(toSlot)
   else
      error(type(toSlot))
   end

   if math.type(min) == "integer" then
      if count < min then return 0 end
   end

   if math.type(max) == "integer" then
      count = max - count
   else
      count = nil
   end

   return self:pushAll(to, item, count, toSlot)
end

function ItemStorage:pushSlots(   to,
   item,
   startingSlot,
   toSlot)

   local peripheralName = ItemStorage.getPeripheralName(to)

   local toMove
   if item == nil then
      toMove = self:list()
   elseif type(item) == "table" then
      toMove = self:list(item)
   end

   local total = 0

   for slot in pairs(toMove) do
      if slot >= startingSlot then
         local moved = total + self.peripheral.pushItems(peripheralName, slot, nil, toSlot)
         total = total + moved
      end
   end
   return total
end

function ItemStorage:pull(   from,
   item,
   count,
   toSlot)

   local _from = ItemStorageWrapper.new(from)

   if type(item) == "table" then
      local found, slot = _from:getItemStorage():find(item)
      if found then
         return self.peripheral.pullItems(_from.peripheralName, slot, count, toSlot)
      else
         return 0
      end
   elseif math.type(item) == "integer" then
      return self.peripheral.pullItems(_from.peripheralName, item, count, toSlot)
   end
end

function ItemStorage:pullAll(   from,
   item,
   count,
   toSlot)

   local _from = ItemStorageWrapper.new(from)

   local toMove

   local total = 0

   if _from.itemStorage == nil then
      if math.type(item) == "integer" then
         count = count or 1000000
         repeat
            local moved = self.peripheral.pullItems(_from.peripheralName, item, count)
            if moved == 0 then break end
            count = count - moved
            total = total + moved
         until count <= 0
         return total
      else
         error(_from.peripheralName .. " does not support the inventory API. Slot number is required")
      end
   end

   if item == nil then
      toMove = _from:getItemStorage():list()
   elseif type(item) == "table" then
      toMove = _from:getItemStorage():list(item)
   end

   for slot in pairs(toMove) do
      local moved = total + self.peripheral.pullItems(_from.peripheralName, slot, count, toSlot)
      if math.type(count) == "integer" then
         count = count - moved
         if count <= 0 then break end
      end
      total = total + moved
   end
   return total
end

function ItemStorage:pullMax(   from,
   item,
   max,
   toSlot,
   min)

   local peripheralName = ItemStorage.getPeripheralName(from)

   local count
   if toSlot == nil then
      count = self:count(item)
   elseif math.type(toSlot) == "integer" then
      count = self:count(toSlot)
   else
      error(type(toSlot))
   end

   if math.type(min) == "integer" then
      if count < min then return 0 end
   end

   if math.type(max) == "integer" then
      count = max - count
   else
      count = nil
   end

   return self:pull(peripheralName, item, count, toSlot)
end

function ItemStorage:pullSlots(   from,
   item,
   startingSlot,
   toSlot)

   local _from = ItemStorageWrapper.new(from)

   local toMove

   if item == nil then
      toMove = _from:getItemStorage():list()
   elseif type(item) == "table" then
      toMove = _from:getItemStorage():list(item)
   end

   local total = 0

   for slot in pairs(toMove) do
      if slot >= startingSlot then
         local moved = total + self.peripheral.pullItems(_from.peripheralName, slot, nil, toSlot)
         total = total + moved
      end
   end
   return total
end
