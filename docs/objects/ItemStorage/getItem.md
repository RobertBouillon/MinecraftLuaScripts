## getItem

Returns basic information about the item stored in the given slot, or `nil` if the slot is invalid or empty.

### Parameters

||||
|-|-|-|
|slot|integer|The slot number to inspect|

### Returns

|||
|-|-|
| SlotContents &#124; nil | Contents of the slot |

### Usage

```lua
local left = ItemStorage.new("left")

local slotContents = left:getItem(1)
if slotContents ~= nil then
  print(slotContents.name, slotContents.count)
else
  print("No item in slot #1")
end
```

