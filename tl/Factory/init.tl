require "tl/Common"

require "tl/Factory/Recipe"
require "tl/Factory/Machine"

global record Factory
  recipes: { Thing : Recipe }
  quotas: { Thing : integer}
  storage: Storage
  runlog : { Thing : string }

  machinePool: { string : {Machine} }
  dedicatedMachines: { Thing : Machine }

  assignedMachines: { Thing : Machine }
end

function Factory.new(
    storage: Storage
  ): Factory
  local self: Factory = setmetatable({}, { __index = Factory })
  self.recipes = {}
  self.quotas = {}
  self.storage = storage
  self.runlog = {}

  self.machinePool = {}
  self.dedicatedMachines = {}
  self.assignedMachines = {}
  return self
end

function Factory:addToPool(machine: Machine)
  local machines = self.machinePool[machine.type.id]
  if machines == nil then
    machines = {}
    self.machinePool[machine.type.id] = machines
  end
  table.insert(machines, machine)
end

function Factory:assign(thing: Thing, machineType : string) : Machine
  local machines = self.machinePool[machineType]
  if machines == nil then return nil end
  if #machines == 0 then return nil end
  local i = #machines
  local machine = machines[i]
  self.assignedMachines[thing] = machine
  table.remove(machines, i)
  return machine;
end

function Factory:detectMachines(machineTypes : {MachineType})
  local index : { string : MachineType } = {}
  for _,t in ipairs(machineTypes) do
    index[t.id] = t
  end

  for _,id in ipairs(peripheral.getNames()) do
    local machineType = index[MachineType.parse(id)]
    if machineType is MachineType then
      self:addToPool(PeripheralMachine.new(id,machineType) as Machine)
    end
  end
end

function Factory:clearMachines()
  for _,machines in pairs(self.machinePool) do
    for _,machine in ipairs(machines) do
      print("Clearing " .. machine.type.name)
      machine:clear(self.storage)
    end
  end
  for _,machine in pairs(self.dedicatedMachines) do
    print("Clearing " .. machine.type.name)
    machine:clear(self.storage)
  end
end

function Factory:canMake(recipe: Recipe) : boolean, string
  for _,thing in ipairs(recipe.inputs) do
    if not self.storage:contains(thing) then
      return false, "Missing " .. thing.name
    end
  end
  return true
end

function Factory:addRecipes(recipes: {Recipe})
  for _,recipe in ipairs(recipes) do
    self.recipes[recipe.thing] = recipe
  end
end

function Factory:make(amount: integer, thing: Thing)
  self.quotas[thing] = amount
end

function Factory:renderUI()
  term.clear()
  print("CC Factory v1.0")
  print()

  local lines = 0
  for item,message in pairs(self.runlog) do
    print(string.format("%-20s", item.name) .. message)
    lines = lines + 1
  end
  if lines == 0 then
    print("Idle")
  end

  -- local keyPressed, key key_monitor.isKeyPressed()
  -- if keyPressed then
  --   if key == keys.Q then return end
  -- end
end

function Factory:startMaking(thing : Thing) : boolean
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
      if machineType is string then
        local assignedMachine = self:assign(thing, machineType)
        if assignedMachine == nil then
          self.runlog[thing] = "No " .. machineType .. " available"  --TODO: This should be a formatted name.
          return false
        end
      elseif machineType is function(...:string) then
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

function Factory:stopMaking(thing : Thing)
  local machine = self.assignedMachines[thing]
  self.assignedMachines[thing] = nil
  machine:clear(self.storage)
  self.runlog[thing] = nil

  --Not a dedicated machine. Add it back to the pool
  if self.dedicatedMachines[thing] == nil then
    self:addToPool(machine)
  end
end

function Factory:isMaking(thing : Thing) : boolean
  return self.assignedMachines[thing] ~= nil
end

function Factory:checkQuotas()
  for thing,amount in pairs(self.quotas) do
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
  for thing,machine in pairs(self.assignedMachines) do
    machine:work(self.storage, self.recipes[thing])
  end
end

function Factory:addDedicatedMachine(thing : Thing, ... : string)
  local recipe = self.recipes[thing]
  local machineType = recipe.machineType
  if machineType is string then 
    error("'" .. thing.name .. "' is not configured for a dedicated machine") 
  elseif machineType is function(...:string) : Machine then
    self.dedicatedMachines[thing] = machineType(...)
  end
end

function Factory:run()
  --self:clearMachines()

  while true do
    self:checkQuotas()
    self:runMachines()
    self:renderUI()

    sleep(0)
  end
end