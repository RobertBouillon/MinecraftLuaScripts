require "tl/factory/Item"
require "tl/factory/Machine"

global record Recipe
  new: function(thing: Thing, machineType: MachineType, ...: Thing) : Recipe

  thing: Thing
  machineType: MachineType
  itemsIn: {Thing}
  itemsOut: {Thing}
end

function Recipe.new(thing: Thing, machineType: MachineType, ...: Thing) : Recipe
  local self: Recipe = setmetatable({}, { __index = Recipe })
  self.thing = thing
  self.machineType = machineType
  self.itemsIn = {...}
  self.itemsOut = {thing}
  return self
end