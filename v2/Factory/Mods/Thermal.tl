require "v2/Factory/Machine"

return {
  machines = {
    PhytogenicInsolator  = MachineType.new("thermal:machine_insolator",  "Phytogenic Insolator"),
    Pulverizer           = MachineType.new("thermal:machine_pulverizer", "Pulverizer"),
    Crafter              = MachineType.new("thermal:machine_crafter",    "Crafter"),
    FluidEncapsulator    = MachineType.new("thermal:machine_bottler",    "Fluid Encapsulator"),
    RedstoneFurnace      = MachineType.new("thermal:machine_furnace",    "Redstone Furnace"),
    MagmaCrucible        = MachineType.new("thermal:machine_crucible",   "Magma Crucible"),
    Pyrolyzer            = MachineType.new("thermal:machine_pyrolyzer",  "Pyrolyzer"),
  },
  things = {
    Sulfur        = { __type = "Item", id = "thermal:sulfur",                       name = "Sulfur" } as Item,
    Cinnabar      = { __type = "Item", id = "thermal:cinnabar",                     name = "Cinnabar" } as Item,
  }
}