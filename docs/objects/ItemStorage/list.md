## list

Returns basic information about the contents of an inventory

### Parameters

||||
|-|-|-|
|filter|Item &#124; string &#124; nil|Limit the results to this item|

### Returns

|||
|-|-|
| { integer : slotContents } | The contents of the inventory |

### Usage

#### Lua:

* Return all items in an inventory
  ```lua
  local storage = ItemStorage.new("left")

  local list = storage.list()

  for slot,contents in pairs(list) do
    print(slot, contents.name)
  end
  ```

* Show a list of all slots that contain a single item
  ```lua
  local storage = ItemStorage.new("left")
  local COAL = "minecraft:coal"

  local list = storage.list(COAL)

  for slot,contents in pairs(list) do
    print(slot, contents.count)
  end
  ```
