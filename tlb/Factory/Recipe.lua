require("tl/factory/Item")

Recipe = {}








function Recipe.new(thing, machineType, ...)
   local self = setmetatable({}, { __index = Recipe })
   self.thing = thing
   self.machineType = machineType
   self.inputs = { ... }
   return self
end
