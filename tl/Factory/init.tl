require "tl/Common"

require "tl/Factory/Recipe"
require "tl/Factory/Machine"

global record Factory
  recipes: { Thing : Recipe }
  quotas: { Thing : integer}
  storage: Storage
  runlog : { Thing : string }

  machinePool: { MachineType : {Machine} }
  dedicatedMachines: { Thing : Machine }

  activeMachines: { Thing : Machine }
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
  self.activeMachines = {}
  return self
end

function Factory:addToPool(machine : Machine)
  local machines = self.machinePool[machine.type]
  if machines == nil then
    machines = {}
    self.machinePool[machine.type] = machines
  end
  table.insert(machines, machine)
end

function Factory:assign(thing: Thing, machineType : MachineType) : boolean
  --Check for dedicated machine
  local dedicatedMachine = self.dedicatedMachines[thing]
  if dedicatedMachine ~= nil then
    self.activeMachines[thing] = dedicatedMachine
    return true
  end

  --Try to pull a machine from the pool
  local machines = self.machinePool[machineType]
  if machines == nil then return false end
  if #machines == 0 then return false end

  local i = #machines
  local machine = machines[i]
  table.remove(machines, i)

  self.activeMachines[thing] = machine
  return true;
end

function Factory:detectMachines(machineTypes : {MachineType})
  local index : { string : MachineType } = {}
  for _,t in ipairs(machineTypes) do
    index[t.id] = t
  end

  for _,id in ipairs(peripheral.getNames()) do
    local machineType = index[MachineType.parse(id)]
    if machineType is MachineType then
      self:addToPool(Machine.new(machineType,id) as Machine)
    end
  end
end

function Factory:clearMachines()
  for _,machines in pairs(self.machinePool) do
    for _,machine in ipairs(machines) do
       machine:clear(self.storage)
    end
  end
  for _,machine in pairs(self.dedicatedMachines) do
    machine:clear(self.storage)
  end
end

function Factory:canMake(recipe: Recipe) : boolean, string
  for _,thing in ipairs(recipe.itemsIn) do
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
  local function comp (t1:Thing, t2:Thing) : boolean return t1.name < t2.name end
  for item,message in pairsByKeys(self.runlog,comp) do
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
      if not self:assign(thing, machineType) then
        self.runlog[thing] = "No " .. machineType.name
        return false
      end
    end
  end
  return true
end

function Factory:stopMaking(thing : Thing)
  local machine = self.activeMachines[thing]
  self.activeMachines[thing] = nil
  machine:clear(self.storage)
  self.runlog[thing] = nil

  --Not a dedicated machine. Add it back to the pool
  if self.dedicatedMachines[thing] == nil then
    self:addToPool(machine)
  end
end

function Factory:isMaking(thing : Thing) : boolean
  return self.activeMachines[thing] ~= nil
end

function Factory:checkQuotas()
  for thing,amount in pairs(self.quotas) do
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
  for thing,machine in pairs(self.activeMachines) do
    local recipe = self.recipes[thing]
    machine:work(self.storage, recipe.itemsIn, recipe.itemsOut)
  end
end

function Factory:addDedicatedMachine(thing : Thing, ... : string | integer)
  local recipe = self.recipes[thing]
  self.dedicatedMachines[thing] = Machine.new(recipe.machineType, ...)
end

function Factory:addCompositeMachine(machineType : MachineType, ... : string | integer)
  self:addToPool(Machine.new(machineType,...))
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