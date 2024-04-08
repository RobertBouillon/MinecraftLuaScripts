local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local string = _tl_compat and _tl_compat.string or string; require("tl/Factory/Item")
require("tl/Factory/Recipe")
require("tl/Storage")

MachineType = {}













function MachineType.parse(name)
   local lastIndex = name:match(".*()%_")
   if lastIndex then
      return name:sub(1, lastIndex - 1)
   else
      return name
   end
end

Machine = {}








function Machine.new(machineType)
   local self = setmetatable({}, { __index = Machine })
   self.type = machineType

   if type(machineType) == "table" then
      self.work = machineType.worker
   end
   if type(machineType) == "table" then
      self.clear = machineType.clearer
   end
   return self
end

local function defaultWorker(machine, storage, recipe)

   local item = storage.item
   local fluid = storage.fluid

   if recipe.thing:is("Item") then
      item:pullAll(machine.storage.item, recipe.thing)
   elseif recipe.thing:is("Fluid") then
      fluid:pullAll(machine.storage.fluid, recipe.thing)
   end

   for _, thing in ipairs(recipe.inputs) do
      if thing:is("Item") then
         item:pushMax(machine.storage.item, thing, 32, nil, 16)
      elseif thing:is("Fluid") then
         fluid:pushMax(machine.storage.fluid, thing, 4000, 2000)
      end
   end
end

local function defaultClearer(machine, storage)

   local item = storage.item
   local fluid = storage.fluid


   if type(machine.storage.item) ~= "string" then
      item:pullAll(machine.storage.item)
   end
   if type(machine.storage.fluid) ~= "string" then
      fluid:pullAll(machine.storage.fluid)
   end
end

function MachineType.new(id, name, worker, clearer)
   local self = setmetatable({}, { __index = MachineType })
   self.id = id
   self.name = name
   self.worker = worker or defaultWorker
   self.clearer = clearer or defaultClearer
   return self
end




PeripheralMachine = {}








setmetatable(PeripheralMachine, { __index = Machine })

function PeripheralMachine.new(peripheralID, machineType)
   local self = setmetatable(Machine.new(machineType), { __index = PeripheralMachine })
   self.storage = Storage.new(peripheralID)

   if MachineType.parse(peripheralID) ~= machineType.id then
      error("'" .. MachineType.parse(peripheralID) .. "' is not a '" .. machineType.name .. "'")
   end

   return self
end
