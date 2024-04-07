require "v2/Factory/Machine"

return {
  things = {
    Water         = { __type = "Fluid", id = "minecraft:water",                     name="Water" } as Fluid,
    Lava          = { __type = "Fluid", id = "minecraft:lava",                      name="Lava" } as Fluid,

    Mushroom      = { __type = "Item", id = "minecraft:red_mushroom",               name = "Red_mushroom" } as Item,
    Potato        = { __type = "Item", id = "minecraft:potato",                     name = "Potato" } as Item,
    OakSapling		= { __type = "Item", id = "minecraft:oak_sapling",                name = "Oak_sapling" } as Item,
    OakLog			  = { __type = "Item", id = "minecraft:oak_log",                    name = "Oak_log" } as Item,
    Paper         = { __type = "Item", id = "minecraft:paper",                      name = "Paper" } as Item,
  }
}