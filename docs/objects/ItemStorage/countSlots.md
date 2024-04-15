## countSlots

Counts the number slots in an inventory

### Parameters

||||
|-|-|-|
|item|Item &#124; Item &#124; string|The item to count|

### Returns

|||
|-|-|
| integer | The number of slots |

### Usage

Multiple slots in an inventory can contain the same item type. Use this method when you want an aggregate count of items in all slots of an inventory. 

* Count the number of slots occupied by a given item

  ```lua
  local left = ItemStorage.new("left")
  local COAL = "minecraft:coal"

  local coalCount = left:countSlots(COAL)
  ```

* Count the total number of slots in an inventory
  ```lua
  local left = ItemStorage.new("left")

  local inventorySize = left:countSlots()
  ```
