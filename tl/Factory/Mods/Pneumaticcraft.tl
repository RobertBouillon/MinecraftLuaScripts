require "v2/Factory/Machine"

return {
  machines = {
    Thermo       = MachineType.new("pneumaticcraft:thermopneumatic_processing_plant",  "Spores Recreator"),
    Mixer        = MachineType.new("pneumaticraft:fluid_mixerc",                       "Latex Processing Unit")
  },
  things = {
    Yeast         = { __type = "Fluid", id = "pneumaticcraft:yeast_culture",        name="Yeast Culture" } as Fluid,
    VegetableOil  = { __type = "Fluid", id = "pneumaticcraft:vegetable_oil",        name="Vegetable Oil" } as Fluid,
    Ethanol 	    = { __type = "Fluid", id = "pneumaticcraft:ethanol",              name="Ethanol" } as Fluid,
    Biodiesel 	  = { __type = "Fluid", id = "pneumaticcraft:biodiesel",            name="Biodiesel" } as Fluid,

    Glycerol 	    = { __type = "Item", id = "pneumaticcraft:glycerol",              name = "Glycerol" } as Item,
  }
}