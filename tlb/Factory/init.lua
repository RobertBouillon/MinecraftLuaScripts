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
   self.activeMachines = {}
   return self
end

function Factory:addToPool(machine)
   local machines = self.machinePool[machine.type]
   if machines == nil then
      machines = {}
      self.machinePool[machine.type] = machines
   end
   table.insert(machines, machine)
end

function Factory:assign(thing, machineType)

   local dedicatedMachine = self.dedicatedMachines[thing]
   if dedicatedMachine ~= nil then
      self.activeMachines[thing] = dedicatedMachine
      return true
   end


   local machines = self.machinePool[machineType]
   if machines == nil then return false end
   if #machines == 0 then return false end

   local i = #machines
   local machine = machines[i]
   table.remove(machines, i)

   self.activeMachines[thing] = machine
   return true
end

function Factory:detectMachines(machineTypes)
   local index = {}
   for _, t in ipairs(machineTypes) do
      index[t.id] = t
   end

   for _, id in ipairs(peripheral.getNames()) do
      local machineType = index[MachineType.parse(id)]
      if type(machineType) == "table" then
         self:addToPool(Machine.new(machineType, id))
      end
   end
end

function Factory:clearMachines()
   for _, machines in pairs(self.machinePool) do
      for _, machine in ipairs(machines) do
         machine:clear(self.storage)
      end
   end
   for _, machine in pairs(self.dedicatedMachines) do
      machine:clear(self.storage)
   end
end

function Factory:canMake(recipe)
   for _, thing in ipairs(recipe.itemsIn) do
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
   local function comp(t1, t2) return t1.name < t2.name end
   for item, message in pairsByKeys(self.runlog, comp) do
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
         if not self:assign(thing, machineType) then
            self.runlog[thing] = "No " .. machineType.name
            return false
         end
      end
   end
   return true
end

function Factory:stopMaking(thing)
   local machine = self.activeMachines[thing]
   self.activeMachines[thing] = nil
   machine:clear(self.storage)
   self.runlog[thing] = nil


   if self.dedicatedMachines[thing] == nil then
      self:addToPool(machine)
   end
end

function Factory:isMaking(thing)
   return self.activeMachines[thing] ~= nil
end

function Factory:checkQuotas()
   for thing, amount in pairs(self.quotas) do
      local count = self.storage:count(thing)

      if count < amount then
         self.runlog[thing] = count .. "/" .. amount
         if not self:isMaking(thing) then
            self:startMaking(thing)
         end
      else
         if self:isMaking(thing) then
            self:stopMaking(thing)
         end
         self.runlog[thing] = nil
      end
   end
end

function Factory:runMachines()
   for thing, machine in pairs(self.activeMachines) do
      local recipe = self.recipes[thing]
      machine:work(self.storage, recipe.itemsIn, recipe.itemsOut)
   end
end

function Factory:addDedicatedMachine(thing, ...)
   local recipe = self.recipes[thing]
   self.dedicatedMachines[thing] = Machine.new(recipe.machineType, ...)
end

function Factory:addCompositeMachine(machineType, ...)
   self:addToPool(Machine.new(machineType, ...))
end

function Factory:run()
   self:clearMachines()

   while true do
      self:checkQuotas()
      self:runMachines()
      self:renderUI()

      sleep(0)
   end
end
