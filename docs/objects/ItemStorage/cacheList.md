## cacheList

Calls the list method and caches the results internally. All subsequent calls to the list method will use these results until cacheList or clearListCache is called.

### Usage

Use this method when list is called repeatedly and the contents of the storage are not expected to change. The list method can be expensive, especially on big inventories. Caching list will reduce the overhead of calling list on the peripheral. Note that many other methods, for example count and find, depend on the list method internally. 

**WARNING** - Pull and Push methods DO NOT update the internal cache. Using this method can cause bugs in your application if your code changes the storage using any of the pull or push methods, as the internal cache will no longer represent the contents of the peripheral's storage.


```lua
local left = ItemStorage.new("left")

left:cacheList()
-- Perform many read operations, such as :list and :find
-- NOTE: Using push and pull methods here WILL NOT update the cache!
left:clearCache()
```
