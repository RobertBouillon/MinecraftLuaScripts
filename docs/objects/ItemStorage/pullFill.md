## pullFill

Pulls a limited number of items to the local inventory.

This method regulates the number of items in a given slot:
* Operation is only performed when the inventory drops below the `min` amount
* Operation will only fill the inventory to the quantity specified by the `max` argument

Pull operations yield and can therefore slow a program down if performed too frequently.
This operation reduces the number of pull operations required by waiting until the local inventory
drops below the `min` amount before pulling more items in. `max` limits the number of items pulled
into the local inventory.

### Parameters

||||
|-|-|-|
| from | ItemStorage &#124; string |The source inventory from which to pull |
| item | Item &#124; string | The source item or slot |
| toSlot | integer &#124; nil |The target slot in the local inventory |
| min | integer &#124; nil |The minimum number of items to keep in the inventory|
| max | integer &#124; nil |The minimum number of items to keep in the inventory|

#### Limitations
The remote inventory must implement the inventory generic peripheral API.

### Returns

| integer | The number of items pulled |

### Usage

* Fill a local slot with up to 32 items
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = machine.pullFill(storage, COAL, nil, 32)
  print(moved .. " items pulled")
  ```

* Fill a local slot when the number of items drops below 16
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = machine.pullFill(storage, COAL, 16)
  print(moved .. " items pulled")
  ```

* Fill a local slot with up to 32 items when the number of items drops below 16
  ```lua
  local storage = ItemStorage.new("left")
  local machine = ItemStorage.new("right")
  local COAL = "minecraft:coal"

  local moved = machine.pullAll(storage, COAL, 16, 32)
  print(moved .. " items pulled")
  ```
