## count

Counts the number of items in an inventory

### Parameters

||||
|-|-|-|
|item|Item &#124; string &#124; integer &#124; nil|The item to count|

### Returns

|||
|-|-|
|integer|The number of items in the inventory|


### Usage

* Count all items in an inventory

  ```lua
  local left = ItemStorage.new("left")

  local count = left:count()
  ```

* Count the number of a specific item in an inventory

  ```lua
  local left = ItemStorage.new("left")
  local COAL = "minecraft:coal"

  local count = left:count(COAL)
  ```