require("tl/Storage/FluidStorage")
require("tl/Storage/ItemStorage")

Storage = {}








function Storage.new(peripheralName)
   local self = setmetatable({}, { __index = Storage })
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

function Storage:count(thing)
   if thing:is("Item") then
      local item = self.item
      if type(item) == "table" then
         return item:count(thing)
      else
         return 0
      end
   elseif thing:is("Fluid") then
      local fluid = self.fluid
      if type(fluid) == "table" then
         return fluid:count(thing)
      else
         return 0
      end
   end
end

function Storage:contains(thing)
   return self:count(thing) > 0
end


HardStorage = {}
