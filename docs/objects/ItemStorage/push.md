## push

Push items from this storage into a connected storage.

### Parameters

||||
|-|-|-|
| to | ItemStorage &#124; string | The destination inventory |
| item | Item &#124; integer &#124; string | The source item or slot |
| count | integer &#124; nil | Maximum number of items to push this operation |
| toSlot | integer &#124; nil | The target slot in the local inventory |

### Returns

| integer | The number of items pushed |

### Usage

This method is analogous to the pushItems function provided by the generic inventory API, except the name of an item can be supplied as the second argument. This makes the method useful for interacting with generic storages (like a chest) where the item may not be in the same slot every time.

This method is intentionally designed to only perform a single push action. If you'd like to push items from multiple slots, use the pushAll method, instead.

Note also that the `count` argument is the maximum number of items that can be pushed from a **single slot**. That means `push` can return less than the `count`, even if the remote inventory contains more of an item in different slots. If you want to push from multiple slots in a single call, use the `pushAll` method, instead.


* Push an item to a remote inventory
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"
  
  --Pushed all coal from the first slot which contains coal
  local moved = storage.push(machine, COAL)
  print(moved .. " items pushed")
  ```

* Push any item from a specific slot
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")

  --Pushes all items from the first slot 
  local moved = storage.push(machine, 1)
  print(moved .. " items pushed")
  ```

* Push an item to a specific remote slot
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  --Pushes all coal from the first slot which contains coal
  --into remote slot #1
  local moved = storage.push(machine, COAL, nil, 1)
  print(moved .. " items pushed")
  ```

* Push a maximum number of items
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  --Pushes A SINGLE coal from the first slot which contains coal
  local moved = storage.push(machine, COAL, 1)
  print(moved .. " items pushed")
  ```
