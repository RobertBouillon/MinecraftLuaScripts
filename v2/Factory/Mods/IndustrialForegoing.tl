require "v2/Factory/Machine"

return {
  machines = {
    SporesRecreator      = MachineType.new("industrialforegoing:spores_recreator",       "Spores Recreator"),
    LatexProcessingUnit  = MachineType.new("industrialforegoing:latex_processing_unit",  "Latex Processing Unit")
  },
  things = {
    Latex         = { __type = "Fluid", id = "industrialforegoing:latex",           name="Latex" } as Fluid,
    TinyRubber    = { __type = "Item", id = "industrialforegoing:tinydryrubber",    name = "Tiny Dry Rubber" } as Item,
    DryRubber     = { __type = "Item", id = "industrialforegoing:dryrubber",        name = "Dry Rubber" } as Item,
    Plastic       = { __type = "Item", id = "industrialforegoing:plastic",          name = "Plastic" } as Item,
  }
}