ItemType = {}





Thing = {}














local Thing_mt
Thing_mt = {
   __tostring = function(self)
      return self.name or self.id
   end,
   __index = Thing,
   __len = function(self)
      return self.id
   end,
}

function Thing.new(_type, id, name)
   local self = setmetatable({}, Thing_mt)
   self.id = id
   self.name = name
   self.__type = _type
   return self
end

function Thing:is(_type)
   return self.__type == _type
end

function Thing.getName(item)
   if type(item) == "string" then
      return item
   elseif type(item) == "table" then
      return item.id
   end
end

Item = {}





setmetatable(Item, { __index = Thing })

function Item.new(id, name)
   local self = setmetatable(Thing.new("Item", id, name), { __index = Item })
   return self
end

Fluid = {}





setmetatable(Fluid, { __index = Thing })

function Fluid.new(id, name)
   local self = setmetatable(Thing.new("Fluid", id, name), { __index = Item })
   return self
end
