## pushFill

Pushes a limited number of items to the remote inventory.

This method regulates the number of items in a given slot:
* Operation is only performed when the remote inventory drops below the `min` amount
* Operation will only fill the remote inventory to the quantity specified by the `max` argument

Pull operations yield and can therefore slow a program down if performed too frequently.
This operation reduces the number of push operations required by waiting until the remote inventory
drops below the `min` amount before pushing more items in. `max` limits the number of items pushed
into the remote inventory.


### Parameters

||||
|-|-|-|
| to | ItemStorage &#124; string |The destination inventory |
| item | Item &#124; string |The item to push | 
| toSlot | integer &#124; nil |The remote slot to push into |
| min | integer &#124; nil |
| max | integer &#124; nil |

#### Limitations
The remote inventory must implement the inventory generic peripheral API.

### Returns

| integer | The number of items pushed |

### Usage

* Fill a remote slot with up to 32 items
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = storage.pushFill(machine, COAL, nil, 32)
  print(moved .. " items pushed")
  ```

* Fill a remote slot when the number of items drops below 16
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = storage.pushFill(machine, COAL, 16)
  print(moved .. " items pushed")
  ```

* Fill a remote slot with up to 32 items when the number of items drops below 16
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = storage.pushAll(machine, COAL, 16, 32)
  print(moved .. " items pushed")
  ```
