## pullAll

Pull *all* items from a connected inventory into this one.

The main differences between this method and the `pull` method:
1. `item` is not a required argument. All items will be pulled if `item` is nil.
2. This method retrieves items from multiple slots.

### Parameters

||||
|-|-|-|
| from | ItemStorage &#124; string | The source inventory from which to pull |
| item | Item &#124; integer &#124; string &#124; nil | The source item or slot |
| count | integer &#124; nil | Maximum number of items to pull this operation |
| toSlot | integer &#124; nil | The target slot in the local inventory |

#### Limitations
The `item` argument must be a slot number if the remote inventory does not implement the inventory generic peripheral API.

### Returns

| integer | The number of items pulled |

### Usage

* Pull all items from the remote storage
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  --Pulls A SINGLE coal from the first slot which contains coal
  --Returns 0 if the slot is empty
  local moved = machine.pullAll(storage)
  print(moved .. " items pulled")
  ```

* Pull all slots of a single item from a remote inventory
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"
  
  --Pulls all coal from the first slot which contains coal
  --Returns 0 if the storage does not contain coal
  local moved = machine.pullAll(storage, COAL)
  print(moved .. " items pulled")
  ```

* Fill a local slot with as many items as the remote storage can provide
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  --Pulls all coal from the first slot which contains coal
  --into local slot #1
  --Returns 0 if the slot is empty or the local slot is full
  local moved = machine.pullAll(storage, COAL, nil, 1)
  print(moved .. " items pulled")
  ```
