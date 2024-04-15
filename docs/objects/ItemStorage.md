Extended API for inventory peripherals

|Function|Returns|Parameters|
|--|--|--|
|new|ItemStorage|peripheralName: string|
|getPeripheralName|string|storage: ItemStorage &#124; string
|isItemStorage|boolean|peripheralName: string|

|Property|Type|Description|
|--|--|--|
| peripheralName | string | The name of the peripheral |
| peripheral | peripheral.inventory | Peripheral wrapper |

|Method|Returns|Parameters|
|--|--|--|
| list | {integer : SlotContents}|filter: Item &#124; string &#124; nil|
| count | integer | item: Item &#124; string &#124; integer &#124; nil |
| countSlots | integer | item: Item &#124; string &#124; nil 
| find | boolean,integer &#124; nil,integer &#124; nil | item: Item &#124; string
| counts | { string : integer} |  |
| size | integer | |
| getItem | SlotContents | slot : integer |
| getItemDetail | SlotContents &#124; nil | slot : integer |
| cacheList | | |
| clearListCache | | |
| push | integer | to : ItemStorage &#124; string |
| | | item: Item &#124; integer &#124; string |
| | | count: integer &#124; nil |
| | | toSlot: integer &#124; nil |
| pushAll | integer | to : ItemStorage &#124; string |
| | | item: Item &#124; string &#124; nil |
| | | count: integer &#124; nil |
| | | toSlot: integer &#124; nil |
| pushFill | integer | to : ItemStorage &#124; string |
| | | item: Item &#124; string |
| | | toSlot: integer &#124; nil |
| | | min: integer &#124; nil |
| | | max: integer &#124; nil |
| pushSlots | integer | to : ItemStorage &#124; string |
| | | item: Item &#124; string &#124; nil |
| | | startingSlot: integer | 
| | | toSlot: integer &#124; nil |
| pull | from : ItemStorage &#124; string |
| | | item: Item &#124; integer &#124; string | 
| | | count: integer &#124; nil |
| | | toSlot: integer &#124; nil |
| pullAll | integer | from : ItemStorage &#124; string |
| | | item: Item &#124; string &#124; integer &#124; nil |
| | | count: integer &#124; nil | 
| | | toSlot: integer &#124; nil |
| pullFill | integer | from : ItemStorage &#124; string |
| | | item: Item &#124; string |
| | | toSlot: integer &#124; nil |
| | | min: integer &#124; nil |
| | | max: integer &#124; nil |
| pullSlots | integer | from : ItemStorage &#124; string |
| | | item: Item &#124; string &#124; nil |
| | | startingSlot: integer |
| | | toSlot: integer &#124; nil |


## Example

#### Lua
```lua
local storage = ItemStorage.new("minecraft:chest_0")
local furnace = ItemStorage.new("minecraft:furnace_0")
local COAL    = "minecraft:coal"
local LOGS    = "minecraft:logs"

while true do
  storage.push(furnace, LOGS)
  storage.pull(furnace, COAL)
  sleep(2)
end
```
