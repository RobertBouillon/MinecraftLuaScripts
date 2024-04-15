require("tl/factory/Item")
require("tl/factory/Machine")

Recipe = {}








function Recipe.new(thing, machineType, ...)
   local self = setmetatable({}, { __index = Recipe })
   self.thing = thing
   self.machineType = machineType
   self.itemsIn = { ... }
   self.itemsOut = { thing }
   return self
end
