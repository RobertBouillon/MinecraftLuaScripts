## pushAll

Push *all* items from this inventory to a connected inventory.

The main differences between this method and the `push` method:
1. `item` is not a required argument. All items will be pushed if `item` is nil.
2. This method pushes items from multiple slots.

### Parameters

||||
|-|-|-|
| to | ItemStorage &#124; string | The destination inventory |
| item | Item &#124; integer &#124; string &#124; nil | The source item or slot |
| count | integer &#124; nil | Maximum number of items to push this operation |
| toSlot | integer &#124; nil | The target slot in the local inventory |

#### Limitations
The `item` argument must be a slot number if the remote inventory does not implement the inventory generic peripheral API.

### Returns

| integer | The number of items pushed |

### Usage

* Push all items from the remote storage
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  --Pushes all items from the machine into storage
  local moved = storage.pushAll(stormachineage)
  print(moved .. " items pushed")
  ```

* Push all slots of a single item from a remote inventory
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"
  
  local moved = storage.pushAll(machine, COAL)
  print(moved .. " items pushed")
  ```

* Fill a remote slot with as many items as possible
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = storage.pushAll(machine, COAL, nil, 1)
  print(moved .. " items pushed")
  ```
