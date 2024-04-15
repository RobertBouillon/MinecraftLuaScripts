## pullSlots

Pulls from a range of slots to the local inventory.

### Parameters

||||
|-|-|-|
| from | ItemStorage &#124; string |The source inventory from which to pull |
| item | Item &#124; string &#124; nil | The item to pull | 
| startingSlot | integer | The minimum slot number of the remote inventory (inclusive) |
| toSlot | integer &#124; nil | The local slot to pull into |

### Returns

| integer | The number of items pulled |

### Usage

* Pull items from every slot >= 4
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")

  local moved = storage.pullRange(machine, nil, 4)
  print(moved .. " items pulled")
  ```

* Pull a single item type from every slot >= 4
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = storage.pullRange(machine, COAL, 4)
  print(moved .. " items pulled")
  ```

* Pull a single item type from every slot >= 4 to local slot #1
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = storage.pullRange(machine, COAL, 4, 1)
  print(moved .. " items pulled")
  ```
