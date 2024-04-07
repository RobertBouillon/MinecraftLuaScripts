require "v2/Storage/FluidStorage"
require "v2/Storage/ItemStorage"

global record Storage
  item : ItemStorage
  fluid : FluidStorage

  count: function(self: Storage, thing : Thing) : integer
  contains: function(self: Storage, thing : Thing) : boolean
end

function Storage:count(thing: Thing) : integer
  if thing:is("Item") then
    return self.item:count(thing as Item)
  elseif thing:is("Fluid") then
    return self.fluid:count(thing as Fluid)
  end
end

function Storage:contains(thing: Thing) : boolean
  return self:count(thing) > 0
end