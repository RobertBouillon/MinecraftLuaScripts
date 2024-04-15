## getPeripheralName

Helper method which resolves a `ItemStorage|string` to a `string` containing the peripheral name.

### Parameters

||||
|-|-|-|
|storage|ItemStorage &#124; string|Periphal object or name|

### Returns

|||
|-|-|
| string | Peripheral name |

### Usage

Some peripherals can be pushed to or pulled from even though they do not implement the generic inventory peripheral. In these cases, the storage is represented by the peripheral name (`string`) rather than an `ItemStorage` object. 

This method is used internally to provide the peripheral name to the `inventory` API when either a peripheral name or `ItemStorage` object is supplied.

#### Lua:

```lua
local function pullItems(storage : ItemStorage | string, slot : integer)
  local storage = ItemStorage.new("left")

  local peripheralName = ItemStorage.getPeripheralName(storage)
  storage.peripheral.pullItems(peripheralName, slot)
end
```