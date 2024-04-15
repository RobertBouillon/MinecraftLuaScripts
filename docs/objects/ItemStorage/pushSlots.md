## pushSlots

Pushes from a range of slots to a remote inventory.

### Parameters

||||
|-|-|-|
| to | ItemStorage &#124; string |The destination inventory |
| item | Item &#124; string &#124; nil | The item to push | 
| startingSlot | integer | The minimum slot number of the local inventory (inclusive) |
| toSlot | integer &#124; nil | The remote slot to push into |

### Returns

| integer | The number of items pushed |

### Usage

* Push items from every slot >= 4
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")

  local moved = machine.pushRange(storage, nil, 4)
  print(moved .. " items pushed")
  ```

* Push a single item type from every slot >= 4
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = machine.pushRange(storage, COAL, 4)
  print(moved .. " items pushed")
  ```

* Push a single item type from every slot >= 4 to local slot #1
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = machine.pushRange(storage, COAL, 4, 1)
  print(moved .. " items pushed")
  ```
