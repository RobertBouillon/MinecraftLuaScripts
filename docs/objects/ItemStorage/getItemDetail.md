## getItemDetail

Returns basic information about the item stored in the given slot, or `nil` if the slot is invalid or empty.

_This method is analagous to the getItemMethod in the peripheral API_

### Parameters

||||
|-|-|-|
|slot|integer|The slot number to inspect|

### Returns

|||
|-|-|
| SlotContents &#124; nil | Detailed Contents of the slot |

### Usage

Provides details information an item in a given slot.

It's difficult to use the output of this method with teal because [teal is statically-typed](https://github.com/teal-language/tl/issues/743); mods can add information to objects and thus there's no way to create a record which would represent all information returned by this method. Either create a record type in teal or create a helper-method in Lua if you're traversing a complex table.

#### Lua:

```lua
local left = ItemStorage.new("left")

local slotContents = left:getItemDetail(1)
if slotContents ~= nil then
  print(slotContents.name, slotContents.count, slotContents.damage, slotContents.maxDamage)
else
  print("No item in slot #1")
end
```

#### Teal:

```lua
--lua_interop.lua
function getMana(itemDetail)
  return itemDetail.magicMod.mana
end

--app.tl
require "lua_interop"
local left = ItemStorage.new("left")

local slotContents = left:getItemDetail(1)
local mana = getMana(slotContents)
print(mana)
```
