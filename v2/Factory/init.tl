require "Common"

require "v2/Factory/Recipe"
require "v2/Factory/Machine"

local record Factory
  items:  { string : Item }
  machines: { Machine }
  recipes: { Thing : Recipe }
  quotas: { Thing : integer}
  storage: Storage
  runlog : { Thing : string }

  machinePool: { string : {Machine} }
  dedicatedMachines: { Thing : Machine }

  assignedMachines: { Thing : Machine }
end

function Factory.new(
    items: { string : Item},
    machines: { Machine },
    recipes: { Thing : Recipe },
    quotas: { Thing : integer },
    storage: Storage
  ): Factory
  local self: Factory = setmetatable({}, { __index = Factory })
  self.items = items
  self.machines = machines
  self.recipes = recipes
  self.quotas = quotas
  self.storage = storage
  self.runlog = {}
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
  local index : { string : MachineType }
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
      machine:clear(self.storage)
    end
  end
  for _,machine in pairs(self.dedicatedMachines) do
    machine:clear(self.storage)
  end
end

function Factory:canMake(recipe: Recipe) : boolean, string
  for _,thing in ipairs(repack(recipe.inputs)) do
    if not self.storage:contains(thing) then
      return false, "Missing " .. tostring(thing)
    end
  end
  return true
end

function Factory:addMachine(machine: Machine)
  table.insert(self.machines, machine)
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
    print(string.format("%-20s", tostring(item)) .. message)
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
      local assignedMachine = self:assign(thing, recipe.machineType)
      if assignedMachine == nil then
        self.runlog[thing] = "No " .. recipe.machineType .. " available"
        return false
      end
    end
  end
  return true
end

function Factory:stopMaking(thing : Thing)
  local machine = self.assignedMachines[thing]
  self.assignedMachines[thing] = nil
  machine:clear(self.storage)
  self:addToPool(machine)
end

function Factory:isMaking(thing : Thing) : boolean
  return self.assignedMachines[thing] ~= nil
end

function Factory:checkQuotas()
  for thing,amount in pairs(self.quotas) do
    local count = self.storage:count(thing)
    self.runlog[thing] = count .. "/" .. amount
    
    if count < amount then
      if self:isMaking(thing) then   
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

function Factory:run()

  self:detectMachines()
  self:clearMachines()

  while true do
    self:checkQuotas()
    self:runMachines()
    self:renderUI()

    sleep(0)
  end
end