Extended API for fluid_storage peripherals

|Function|Returns|Parameters|
|--|--|--|
|new|FluidStorage|peripheralName: string|
|getPeripheralName|string|storage: FluidStorage &#124; string
|isFluidStorage|boolean|peripheralName: string|

|Property|Type|Description|
|--|--|--|
| peripheralName | string | The name of the peripheral |
| peripheral | peripheral.inventory | Peripheral wrapper |

|Method|Returns|Parameters|
|--|--|--|
| list | {integer : TankContents}|filter: Fluid &#124; string &#124; nil|
| count | integer | Fluid: Fluid &#124; string &#124; integer &#124; nil |
| find | boolean,integer | Fluid: Fluid &#124; string
| counts | { string : integer} |  |
| push | integer | to : FluidStorage &#124; string |
| | | Fluid: Fluid &#124; string |
| | | count: integer &#124; nil |
| | | toSlot: integer &#124; nil |
| pushAll | integer | to : FluidStorage &#124; string |
| | | Fluid: Fluid &#124; string |
| | | count: integer &#124; nil |
| pushFill | integer | to : FluidStorage &#124; string |
| | | Fluid: Fluid &#124; string |
| | | min: integer &#124; nil |
| | | max: integer &#124; nil |
| pushWhen | integer | to : FluidStorage &#124; string |
| | | Fluid: Fluid &#124; string |
| | | threshold: integer &#124; nil |
| pull | from : FluidStorage &#124; string |
| | | Fluid: Fluid &#124; string | 
| | | count: integer &#124; nil |
| pullAll | integer | from : FluidStorage &#124; string |
| | | Fluid: Fluid &#124; string &#124; nil |
| | | count: integer &#124; nil | 
| pullFill | integer | from : FluidStorage &#124; string |
| | | Fluid: Fluid &#124; string |
| | | min: integer &#124; nil |
| | | max: integer &#124; nil |


## Example

#### Lua
```lua
local storage = FluidStorage.new("left")
local machine = FluidStorage.new("right")

while true do
  storage.pushAll(machine)
  sleep(2)
end
```
