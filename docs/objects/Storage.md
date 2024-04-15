Detect and provide storage APIs as they are supported by the peripheral

|Function|Returns|Parameters|
|--|--|--|
|new|Storage|peripheralName: string|

|Property|Type|Description|
|--|--|--|
| item | ItemStorage &#124; string | Item Storage API, if available |
| fluid | FluidStorage &#124; string | Fluid storage API, if available |

|Method|Returns|Parameters|
|--|--|--|
| count | integer | thing: Thing |
| contains | boolean | thing: Thing |


## Example

#### Lua
```lua
local storage = Storage.new("left")
local machine = Storage.new("right")
local COAL = "minecraft:coal"

while true do
  storage.fluid.pushAll(machine)
  storage.item.pushAll(machine, COAL)
  sleep(2)
end
```
