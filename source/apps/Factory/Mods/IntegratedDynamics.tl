require "v2/Factory/Machine"

return {
  machines = {
    MechanicalSqueezer      = MachineType.new("integrateddynamics:mechanical_squeezer",       "Mechanical Squeezer")
  },
  things = {
    MenrilResin   = { __type = "Fluid", id = "integrateddynamics:menril_resin",     name="Menril Resin" } as Fluid,

    MenrilLog     = { __type = "Item", id = "integrateddynamics:menril_log",        name = "Menril Log" } as Item,
    MenrilSapling = { __type = "Item", id = "integrateddynamics:menril_sapling",    name = "Menril Sapling" } as Item,
    MenrilCrystal = { __type = "Item", id = "integrateddynamics:crystalized_menril_chunk", name = "Crystalized Menril Chunk" } as Item,
  }
}