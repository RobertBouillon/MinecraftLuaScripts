local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local pairs = _tl_compat and _tl_compat.pairs or pairs; local table = _tl_compat and _tl_compat.table or table; require("tl/Factory/Item")
require("tl/Storage/Common")
require("tl/ccapi")
require("tl/common")



FluidStorage = {TankContents = {}, }





































































function FluidStorage.new(peripheralName)
   local self = setmetatable({}, { __index = FluidStorage })
   self.peripheralName = peripheralName
   if not FluidStorage.isFluidStorage(peripheralName) then error("'" .. peripheralName .. "' does not implement the fluid_storage API") end
   self.peripheral = peripheral.wrap(peripheralName)
   return self
end

function FluidStorage.getPeripheralName(storage)
   if type(storage) == "string" then
      return storage
   elseif type(storage) == "table" then
      return storage.peripheralName
   end
end

local FluidStorageWrapper = {}




function FluidStorage:getFluid(slot)
   return self:list()[slot]
end

function FluidStorage:list(filter)
   local list = self.peripheral.tanks()
   if filter == nil then return list end
   local id
   if type(filter) == "string" then id = filter
   elseif type(filter) == "table" then id = filter.id
   elseif filter == nil then return list end
   local filtered = {}
   for _, contents in pairs(list) do
      if contents.name == id then
         table.insert(filtered, contents)
      end
   end
   return filtered
end



function FluidStorage:counts()
   local counts
   for _, fluid in ipairs(self:list()) do
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

function FluidStorageWrapper:getFluidStorage()
   local fluidStorage = self.FluidStorage
   if type(fluidStorage) == "table" then return fluidStorage end
   error("'" .. self.peripheralName .. "' does not support the fluid_storage API")
end

function FluidStorage.isFluidStorage(name)
   local types = { peripheral.getType(name) }
   for _, t in ipairs(types) do
      if t == "fluid_storage" then return true end
   end
   return false
end

function FluidStorageWrapper.new(block)
   local self = setmetatable({}, { __index = FluidStorageWrapper })
   if type(block) == "string" then
      self.peripheralName = block
      if FluidStorage.isFluidStorage(block) then
         self.FluidStorage = FluidStorage.new(block)
      end
   elseif type(block) == "table" then
      self.peripheralName = block.peripheralName
      self.FluidStorage = block
   end
   return self
end

function FluidStorage:count(fluid)
   local count = 0

   if fluid == nil then
      for _, x in ipairs(self:list()) do
         count = count + x.amount
      end
      return count

   elseif type(fluid) == "string" or type(fluid) == "table" then
      for _, cursor in ipairs(self:list(fluid)) do
         count = count + cursor.amount
      end
      return count
   end
end

function FluidStorage:find(fluid)
   for _, details in ipairs(self:list(fluid)) do
      return true, details.amount
   end
   return false
end



function FluidStorage:push(   to,
   fluid,
   count)

   local fluidName = Fluid.getName(fluid)
   local peripheralName = FluidStorage.getPeripheralName(to)

   local found = self:find(fluid)
   if found then
      return self.peripheral.pushFluid(peripheralName, count, fluidName)
   else
      return 0
   end
end

function FluidStorage:pushAll(   to,
   fluid,
   count)

   local total = 0
   local peripheralName = FluidStorage.getPeripheralName(to)

   local toMove

   if fluid == nil then
      toMove = self:list()

   elseif type(fluid) == "string" or type(fluid) == "table" then
      toMove = self:list(fluid)
   end

   for _, slot in pairs(toMove) do
      local moved = self.peripheral.pushFluid(peripheralName, count, slot.name)
      if moved == 0 then break end
      if math.type(count) == "integer" then
         count = count - moved
         if count == 0 then break end
      end
      total = total + moved
   end

   return total
end

function FluidStorage:pushFill(   to,
   fluid,
   min,
   max)


   local _to = FluidStorageWrapper.new(to)

   local count = _to:getFluidStorage():count(fluid)

   if math.type(min) == "integer" then
      if count > min then return 0 end
   end

   if math.type(max) == "integer" then
      count = max - count
      if count == 0 then return 0 end
   else
      count = nil
   end

   return self:push(to, fluid, count)
end


function FluidStorage:pushWhen(   to,
   fluid,
   threshhold)

   local count
   count = self:count(fluid)

   if count < threshhold then return 0 end

   return self:push(to, fluid, count)
end

function FluidStorage:pull(   from,
   fluid,
   count)

   local _from = FluidStorageWrapper.new(from)
   local fluidName = Fluid.getName(fluid)

   if _from.FluidStorage == nil then
      return self.peripheral.pullFluid(_from.peripheralName, count, fluidName)
   else
      local found = _from:getFluidStorage():find(fluid)
      if found then
         return self.peripheral.pullFluid(_from.peripheralName, count, fluidName)
      else
         return 0
      end
   end
end

function FluidStorage:pullAll(   from,
   fluid,
   count)

   local _from = FluidStorageWrapper.new(from)

   local total = 0

   local toMove


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

   if fluid == nil then
      toMove = _from:getFluidStorage():list()

   elseif type(fluid) == "string" or type(fluid) == "table" then
      toMove = _from:getFluidStorage():list(fluid)
   end

   for _, slot in pairs(toMove) do
      local moved = 0
      while moved < slot.amount do
         local m = self.peripheral.pullFluid(_from.peripheralName, count, slot.name)
         if m == 0 then break end
         moved = moved + m
         total = total + moved
         if math.type(count) == "integer" then
            count = count - moved
            if count <= 0 then break end
         end
      end
   end
   return total
end

function FluidStorage:pullFill(   from,
   fluid,
   min,
   max)


   local peripheralName = FluidStorage.getPeripheralName(from)

   local count
   count = self:count(fluid)

   if math.type(min) == "integer" then
      if count > min then return 0 end
   end

   if math.type(max) == "integer" then
      count = max - count
      if count == 0 then return 0 end
   else
      count = nil
   end


   return self:pull(peripheralName, fluid, count)
end
