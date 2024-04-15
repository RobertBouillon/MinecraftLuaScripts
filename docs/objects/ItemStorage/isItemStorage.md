## isItemStorage

Returns true if the peripheral supports the inventory generic peripheral API.

### Parameters

||||
|-|-|-|
|peripheralName|string|The name of the connected peripheral|

### Returns

|||
|-|-|
| boolean | `true` if the peripheral supports the inventory generic peripheral API |

### Usage

#### Lua:

```lua
if not ItemStorage.isItemStorage("left") then
  error("Block to the left of the computer does not have an accessible inventory")
end
```