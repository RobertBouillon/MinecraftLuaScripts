local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local pairs = _tl_compat and _tl_compat.pairs or pairs; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table; require("tl/Common")

require("tl/Factory/Recipe")
require("tl/Factory/Machine")

Factory = {}











function Factory.new(
   storage)

   local self = setmetatable({}, { __index = Factory })
   self.recipes = {}
   self.quotas = {}
   self.storage = storage
   self.runlog = {}

   self.machinePool = {}
   self.dedicatedMachines = {}
   self.assignedMachines = {}
   return self
end

function Factory:addToPool(machine)
   local machines = self.machinePool[machine.type.id]
   if machines == nil then
      machines = {}
      self.machinePool[machine.type.id] = machines
   end
   table.insert(machines, machine)
end

function Factory:assign(thing, machineType)
   local machines = self.machinePool[machineType]
   if machines == nil then return nil end
   if #machines == 0 then return nil end
   local i = #machines
   local machine = machines[i]
   self.assignedMachines[thing] = machine
   table.remove(machines, i)
   return machine
end

function Factory:detectMachines(machineTypes)
   local index = {}
   for _, t in ipairs(machineTypes) do
      index[t.id] = t
   end

   for _, id in ipairs(peripheral.getNames()) do
      local machineType = index[MachineType.parse(id)]
      if type(machineType) == "table" then
         self:addToPool(PeripheralMachine.new(id, machineType))
      end
   end
end

function Factory:clearMachines()
   for _, machines in pairs(self.machinePool) do
      for _, machine in ipairs(machines) do
         print("Clearing " .. machine.type.name)
         machine:clear(self.storage)
      end
   end
   for _, machine in pairs(self.dedicatedMachines) do
      print("Clearing " .. machine.type.name)
      machine:clear(self.storage)
   end
end

function Factory:canMake(recipe)
   for _, thing in ipairs(recipe.inputs) do
      if not self.storage:contains(thing) then
         return false, "Missing " .. thing.name
      end
   end
   return true
end

function Factory:addRecipes(recipes)
   for _, recipe in ipairs(recipes) do
      self.recipes[recipe.thing] = recipe
   end
end

function Factory:make(amount, thing)
   self.quotas[thing] = amount
end

function Factory:renderUI()
   term.clear()
   print("CC Factory v1.0")
   print()

   local lines = 0
   for item, message in pairs(self.runlog) do
      print(string.format("%-20s", item.name) .. message)
      lines = lines + 1
   end
   if lines == 0 then
      print("Idle")
   end





end

function Factory:startMaking(thing)
   local recipe = self.recipes[thing]
   if recipe == nil then
      self.runlog[thing] = "Recipe not found"
      return false
   else
      local canMake, message = self:canMake(recipe)
      if not canMake then
         self.runlog[thing] = message
         return false
      else
         local machineType = recipe.machineType
         if type(machineType) == "string" then
            local assignedMachine = self:assign(thing, machineType)
            if assignedMachine == nil then
               self.runlog[thing] = "No " .. machineType .. " available"
               return false
            end
         elseif type(machineType) == "function" then
            local dedicatedMachine = self.dedicatedMachines[thing]
            if dedicatedMachine == nil then
               self.runlog[thing] = "'" .. thing.name .. "'s' requires a dedicated machine"
               return false
            else
               self.assignedMachines[thing] = dedicatedMachine
            end
         end
      end
   end
   return true
end

function Factory:stopMaking(thing)
   local machine = self.assignedMachines[thing]
   self.assignedMachines[thing] = nil
   machine:clear(self.storage)
   self.runlog[thing] = nil


   if self.dedicatedMachines[thing] == nil then
      self:addToPool(machine)
   end
end

function Factory:isMaking(thing)
   return self.assignedMachines[thing] ~= nil
end

function Factory:checkQuotas()
   for thing, amount in pairs(self.quotas) do
      local count = self.storage:count(thing)
      self.runlog[thing] = count .. "/" .. amount

      if count < amount then
         if not self:isMaking(thing) then
            self:startMaking(thing)
         end
      else
         if self:isMaking(thing) then
            self:stopMaking(thing)
         end
      end
   end
end

function Factory:runMachines()
   for thing, machine in pairs(self.assignedMachines) do
      machine:work(self.storage, self.recipes[thing])
   end
end

function Factory:addDedicatedMachine(thing, ...)
   local recipe = self.recipes[thing]
   local machineType = recipe.machineType
   if type(machineType) == "string" then
      error("'" .. thing.name .. "' is not configured for a dedicated machine")
   elseif type(machineType) == "function" then
      self.dedicatedMachines[thing] = machineType(...)
   end
end

function Factory:run()


   while true do
      self:checkQuotas()
      self:runMachines()
      self:renderUI()

      sleep(0)
   end
end
