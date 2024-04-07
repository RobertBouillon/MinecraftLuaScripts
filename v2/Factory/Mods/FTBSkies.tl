require "v2/Factory/Machine"

return {
  machines = {
    SuperCooler      = MachineType.new("rftoolsutility:ftbsba:super_cooler",       "Super Cooler")
  },
  things = {
    Polyethylene  = { __type = "Fluid", id = "ftbskies:polyethylene",               name="Polyethylene" } as Fluid,
    MoltenSilver  = { __type = "Fluid", id = "ftbskies:molten_silver",              name="Molten Silver" } as Fluid,

    LDPE          = { __type = "Item", id = "ftbskies:ldpe_sheet",                  name = "LDPE Sheet" } as Item,
  }
}