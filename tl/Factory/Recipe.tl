require "tl/factory/Item"

global record Recipe
  new: function(thing: Thing, machineType: string | function(...:string), ...: Thing) : Recipe

  thing: Thing
  machineType: string | function(...:string)
  inputs: {Thing}
  itemsOut: {integer} | nil
end

function Recipe.new(thing: Thing, machineType: string | function(...:string), ...: Thing) : Recipe
  local self: Recipe = setmetatable({}, { __index = Recipe })
  self.thing = thing
  self.machineType = machineType
  self.inputs = {...}
  return self
end