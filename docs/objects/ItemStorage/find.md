## find

Returns data about the first item found in the inventory matching the argument, or `nil` if the item was not found.

This method will only return one result. If you want multiple retuls, use list instead.

### Parameters

||||
|-|-|-|
|item|Item &#124; Item &#124; string|The item to count|

### Returns

|||
|-|-|
| boolean | True if the item was found in the inventory |
| integer &#124; nil | Slot number of the found item |
| integer &#124; nil | Count of items in the found slot |

### Usage

Use this method to find the first occurance of an item in an inventory.

```lua
local left = ItemStorage.new("left")
local COAL = "minecraft:coal"

local found,slot,count = left:find(COAL)
if found then
  print(slot, count)
else
  print("No coal found")
end
```

