## new

Constructs a new instance of an ItemStorage object

### Parameters

||||
|-|-|-|
|peripheralName|string|Name of the target Peripheral|

### Returns

|||
|-|-|
| ItemStorage | A new ItemStorage object |

### Usage

#### Lua:

```lua
local storage = ItemStorage.new("left")

local list = storage.list()

for slot,contents in pairs(list) do
  print(slot, contents.name)
end
```
