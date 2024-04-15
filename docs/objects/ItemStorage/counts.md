## counts

Counts the number of items in all slots an inventory.

### Parameters

_None_

### Returns

|||
|-|-|
|{ string : integer }| Counts keyed by the item ID |

### Usage

Multiple slots in an inventory can contain the same item type. Use this method when you want an aggregate count of items in all slots of an inventory. 

```lua
local left = ItemStorage.new("left")

local counts = left:counts()

for item,count in pairs(counts) do
  print(item, count)
end
```
