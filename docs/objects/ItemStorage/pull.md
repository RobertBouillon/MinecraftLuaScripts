## pull

Pull items from a connected inventory into this one.

### Parameters

||||
|-|-|-|
| from | ItemStorage &#124; string | The source inventory from which to pull |
| item | Item &#124; integer &#124; string | The source item or slot |
| count | integer &#124; nil | Maximum number of items to pull this operation |
| toSlot | integer &#124; nil | The target slot in the local inventory |

### Returns

| integer | The number of items pulled |

### Usage

This method is analogous to the pullItems function provided by the generic inventory API, except the name of an item can be supplied as the second argument. This makes the method useful for interacting with generic storages (like a chest) where the item may not be in the same slot every time.

This method is intentionally designed to only perform a single pull action. If you'd like to pull items from multiple slots, use the pullAll method, instead.

Note also that the `count` argument is the maximum number of items that can be pulled from a **single slot**. That means `pull` can return less than the `count`, even if the remote inventory contains more of an item in different slots. If you want to pull from multiple slots in a single call, use the `pullAll` method, instead.


* Pull an item from a remote inventory
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"
  
  --Pulls all coal from the first slot which contains coal
  --Returns 0 if the storage does not contain coal
  local moved = machine.pull(storage, COAL)
  print(moved .. " items pulled")
  ```

* Pull any item from a specific slot
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")

  --Pulls all items from the first slot 
  --Returns 0 if the slot is empty
  local moved = machine.pull(storage, 1)
  print(moved .. " items pulled")
  ```

* Pull an item to a specific local slot
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  --Pulls all coal from the first slot which contains coal
  --into local slot #1
  --Returns 0 if the slot is empty or the local slot is full
  local moved = machine.pull(storage, COAL, nil, 1)
  print(moved .. " items pulled")
  ```

* Pull a maximum number of items
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  --Pulls A SINGLE coal from the first slot which contains coal
  --Returns 0 if the slot is empty
  local moved = machine.pull(storage, COAL, 1)
  print(moved .. " items pulled")
  ```
