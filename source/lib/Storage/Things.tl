global enum ItemType
  "Item"
  "Fluid"
  --"Gas"
end

global record Thing
  --Private
  __type: ItemType

  --Will be Inherited
  is: function(self: Thing, _type: ItemType) : boolean

  --Public Fields (must be copied)
  id: string
  name: string | nil

  --Public methods (can be overriden)
  getName: function(thing: Thing | string) : string
end

local Thing_mt: metatable<Thing>
Thing_mt = {
   __tostring = function(self : Thing) : string
    return self.name or self.id
   end,
   __index = Thing,
   __len = function(self : Thing) : string
    return self.id
   end
}

function Thing.new(_type: ItemType, id: string, name: string | nil) : Thing
  local self: Thing = setmetatable({}, Thing_mt)
  self.id = id
  self.name = name
  self.__type = _type
  return self
end

function Thing:is(_type: ItemType) : boolean
  return self.__type == _type
end

function Thing.getName(item: Thing | string) : string
  if item is string then
    return item
  elseif item is Thing then
    return item.id
  end
end

global record Item
  id: string
  name: string | nil

  getName: function(item: Item | string) : string
end
setmetatable(Item, {__index = Thing})

function Item.new(id : string , name: string|nil) : Item
  local self: Item = setmetatable(Thing.new("Item", id, name) as Item, { __index = Item })
  return self
end

global record Fluid
  id: string
  name: string | nil

  getName: function(fluid: Fluid | string) : string
end
setmetatable(Fluid, {__index = Thing})

function Fluid.new(id : string , name: string|nil) : Item
  local self: Item = setmetatable(Thing.new("Fluid", id, name) as Item, { __index = Item })
  return self
end
