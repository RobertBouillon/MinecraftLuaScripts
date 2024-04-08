local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table; require("tl/Factory/Item")
require("tl/Storage")
require("tl/Common")

MachineType = {}
















function MachineType:is(peripheralName)
   return self.parse(peripheralName) == self.id
end

function MachineType.parse(name)
   local lastIndex = name:match(".*()%_")
   if lastIndex then
      return name:sub(1, lastIndex - 1)
   else
      return name
   end
end

Machine = {}









function Machine.new(machineType, ...)
   local self = setmetatable({}, { __index = Machine })
   self.type = machineType
   self.storage = {}
   self.peripherals = {}
   for i, x in ipairs({ ... }) do
      if math.type(x) == "integer" then
         table.insert(self.peripherals, machineType.types[i].id .. "_" .. x)
      elseif type(x) == "string" then
         table.insert(self.peripherals, x)
      end
   end

   local expected = #self.type.types
   local specified = #self.peripherals
   if specified ~= expected then
      traceStack()
      error(expected .. " peripherals expected for " .. self.type.name)
   end

   for i, p in ipairs(self.peripherals) do
      if MachineType.parse(p) ~= self.type.types[i].id then
         error("Machine " .. i .. " is not a " .. self.type.types[i].name)
      end
      table.insert(self.storage, Storage.new(p))
   end

   return self
end

function Machine:work(storage, itemsIn, itemsOut)
   self.type.worker(self, storage, itemsIn, itemsOut)
end

function Machine:clear(storage)
   self.type.clearer(self, storage)
end

local function defaultWorker(machine, storage, itemsIn, itemsOut)

   local item = storage.item
   local fluid = storage.fluid

   for _, thing in ipairs(itemsOut) do
      if thing:is("Item") then
         item:pullAll(machine.storage[1].item, thing)
      elseif thing:is("Fluid") then
         fluid:pullAll(machine.storage[1].fluid, thing)
      end
   end

   for _, thing in ipairs(itemsIn) do
      if thing:is("Item") then
         item:pushMax(machine.storage[1].item, thing, 32, nil, 16)
      elseif thing:is("Fluid") then
         fluid:pushMax(machine.storage[1].fluid, thing, 4000, 2000)
      end
   end
end

local function defaultClearer(machine, storage)

   local item = storage.item
   local fluid = storage.fluid


   if type(machine.storage[1].item) ~= "string" then
      item:pullAll(machine.storage[1].item)
   end
   if type(machine.storage[1].fluid) ~= "string" then
      fluid:pullAll(machine.storage[1].fluid)
   end
end

function MachineType.new(name, id)
   local self = setmetatable({}, { __index = MachineType })
   self.id = id
   self.name = name
   self.types = { self }
   self.worker = defaultWorker
   self.clearer = defaultClearer
   return self
end

function MachineType.newComposite(name, ...)
   local self = setmetatable({}, { __index = MachineType })
   self.name = name
   self.types = { ... }
   self.worker = defaultWorker
   self.clearer = defaultClearer
   return self
end
