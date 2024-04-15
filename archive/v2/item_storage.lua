--cc:Tweaked: Item Storage API
--pastebin get 8JaJH3g2 item_storage.lua
--Usage:
--  item_storage=require("item_storage")
--  local ITEM_STORAGE = item_storage.wrap("left")

local item_storage = {
  __TYPE = "ItemStorage",
}

function item_storage.is(o)
  return o.__type == item_storage.__TYPE
end

function StacksEqual(a,b)
	if a==nil or b==nil then return false end

	if type(a) == "string" then a = {name=a} end
	if type(b) == "string" then b = {name=b} end

	if a.damage == nil then a["damage"] = 0 end
	if b.damage == nil then b["damage"] = 0 end
 
	return a.damage == b.damage and a.name == b.name
end

local function extend(_count, _size, _detail, _list)
	local base = {}

  function base.list()
    return _list()
	end
	
	function base.size()
		return _size()
	end
	
	function base.item(slot)
		return _list()[slot]
	end
	
	function base.itemDetail(slot)
		return _detail(slot)
	end
	
	function base.counts()
		local counts = {}
		for _,item in pairs(_list()) do
			if item ~= nil then
				local count = counts[item.name]
				if count == nil then
					counts[item.name] = item.count
				else
					counts[item.name] = item.count + count
				end
			end
		end
		return counts
	end
	
	--item == nil: # of slots which contain items
	--item == number: count of items in slot
	--item == string: total count of items
	--item == {item}: total count of items
	function base.find(item)
		for slot,cursor in pairs(_list()) do
			if StacksEqual(item, cursor) then return true, slot, cursor.count end
		end
		return false
	end

	function base.isFull()
		return base.count() == _size()
	end
	
  --If item is nil, return the number of slots used
  --If item is number, count items in slot
  --If item is string, count items which match item ID
	function base.count(item)
		local count = 0

		if item == nil then
			for _ in pairs(_list()) do
				count = count + 1
			end
			return count
		elseif
			type(item) == "number" then return _count(item)
		else
			for _,cursor in pairs(_list()) do
				if StacksEqual(cursor, item) then
					count = count + cursor.count
				end
			end
			return count
		end
	end
	
	return base
end

function item_storage.wrap(side)

	local __wrapper = peripheral.wrap(side)
	if __wrapper == nil then return nil end

	local itemStorage = extend(
		function(slot) local items = __wrapper.list() if items[slot] == nil then return 0 else return items[slot].count end end,
		function() return __wrapper.size() end,
		function(slot) return __wrapper.getItemDetail(slot) end,
		function() return __wrapper.list() end
	)
	
	itemStorage.name = side
  itemStorage.peripheral = __wrapper
  itemStorage.__type = "ItemStorage"

  function itemStorage.pushMax(to, item, max, toSlot)
    local count
    if type(to) == "string" then
      if not item_storage.isItemStorage() then error("'" .. to .."' is not an inventory") end
      count = max - item_storage.wrap(to).count(item)
    else
      count = max - to.count(item)
    end
    itemStorage.push(to,item,count,toSlot)
  end

	--Moves an item from this inventory to another.
  -- @param to [string | ItemStorage] The destination storage
  -- @param item [string | number | string[] | number[]] The source slot(s) or item(s) ID of the item to moved
  -- @param count [number] The maximum number of items to moved
  -- @param toSlot [number] The slot to place the items in the destination storage
	--[item | slot] = item can be item name or slot
	--returns: 
	--  Boolean - Entire stack moved and slot is now empty
	--  Number  - Number of items in stack moved
	function itemStorage.push(to, item, count, toSlot, allowOverflow)
    --Build to
    if type(to) == "string" then
      to = {
        ID = to
      }
      if item_storage.isItemStorage(to.ID) then to.ItemStorage = item_storage.wrap(to.ID) end
    elseif item_storage.is(to) then
      to = {
        ID = to.name,
        ItemStorage = to
      }
    else 
      error("'"..to.."' is not a valid destination")
    end

    --Build source item list
    local fromItemSlots = {}
    local itemType = type(item)
    if itemType == "table" then
      for _,t in pairs(item) do
        if type(t) == "string" then
          local _,slot = itemStorage.find(t)
          table.insert(fromItemSlots, slot)
        elseif type(t) == "number" then
          table.insert(fromItemSlots, t)
        else
          error("'"..t.."' is not a valid item")
        end
      end
    elseif item == nil then 
      for _,t in pairs(itemStorage.list()) do
        table.insert(fromItemSlots, t.slot)
      end
    elseif itemType == "string" then
      local _,slot = itemStorage.find(item)
      table.insert(fromItemSlots, slot)
    elseif itemType == "number" then
      table.insert(fromItemSlots, item)
    end

    -- Try to find the destination slot
    if item ~= nil and toSlot == nil and itemStorage.isItemStorage(to) then
      local found,slot = to.ItemStorage.find(item)
      if found then toSlot = slot end
    end

		local total = 0
    for _,slot in pairs(fromItemSlots) do
      local moved = __wrapper.pushItems(to.ID,slot,count,toSlot)
      total = total + moved
      if count ~= nil then
        count = count - moved
        if count <= 0 then break end
      end
    end
    return total
	end
	
  local function wrapStorage(block)
    --Build to
    if type(block) == "string" then
      block = {
        ID = block
      }
      if item_storage.isItemStorage(block.ID) then to.ItemStorage = item_storage.wrap(block.ID) end
    elseif item_storage.is(block) then
      block = {
        ID = block.name,
        ItemStorage = block
      }
    else 
      error("'"..block.."' is not a valid source item storage")
    end
    return block
  end

  function itemStorage.pullRange(from, min, max)
    from = wrapStorage(from)
    if from.ItemStorage == nil then error("'"..from.ID.."' does not expose the storage API") end
    local machine = from.ItemStorage

    if min == nil then min = 1 end
    if max == nil then max = 100000 end

    for slot,_ in pairs(machine.list()) do
      if slot > 1 then
        itemStorage.pull(machine.name, slot)
      end
    end
  end

	function itemStorage.pull(from,item,count,toSlot)
    --Build to
    from = wrapStorage(from)

    --Get item slots
    local fromItemSlots
    if item ~= nil then
      fromItemSlots = {}
      local itemType = type(item)
      if itemType == "table" then
        for _,t in pairs(item) do
          if type(t) == "string" then
            if from.ItemStorage == nil then error("'"..from.ID.."' lacks the item API - Cannot filter by item") end
            local _,slot = itemStorage.find(t)
            table.insert(fromItemSlots, slot)
          elseif type(t) == "number" then
            table.insert(fromItemSlots, t)
          else
            error("'"..t.."' is not a valid item")
          end
        end
      elseif item == nil then 
        for _,t in pairs(itemStorage.list()) do
          table.insert(fromItemSlots, t.slot)
        end
      elseif itemType == "string" then
        if from.ItemStorage == nil then error("'"..from.ID.."' lacks the item API - Cannot filter by item") end
        local _,slot = itemStorage.find(item)
        table.insert(fromItemSlots, slot)
      elseif itemType == "number" then
        table.insert(fromItemSlots, item)
      end
    end

    -- Try to find the destination slot
    if toSlot == nil then
      local found,slot = itemStorage.find(item)
      if found then toSlot = slot end
    end

    --Pull all items
		local total = 0
    if fromItemSlots == nil then
      local moved = 0
      repeat
        moved = moved + __wrapper.pullItems(from.ID,nil,count,toSlot)
        if count ~= nil and count >= moved then break end
      until moved == 0
      return moved
    end

    for _,slot in pairs(fromItemSlots) do
      local moved = __wrapper.pushItems(to.ID,slot,count,toSlot)
      total = total + moved
      if count ~= nil then
        count = count - moved
        if count <= 0 then break end
      end
    end
    return total


	end


  function itemStorage.isItemStorage(name)
    local types = {peripheral.getType(name)}
    for _,t in pairs(types) do
      if t == "inventory" then return true end
    end
    return false
  end
  
	return itemStorage
end

if turtle == nil then return item_storage end

local function tlist()
	local list={}
	for s=1,16 do
		local count = turtle.getItemCount(s)
		if count > 0 then 
			list[s] = turtle.getItemDetail(s, false)
		end
	end
	return list
end

turtle.items = extend(
	turtle.getItemCount,
	function () return 16 end,
	turtle.getItemDetail,
	tlist
)

function turtle.items.compact()
	local source = turtle.items.size()
	local dest = 1
	local count = turtle.items.count()
	
	for s=turtle.items.size(),2,-1 do
		local source = turtle.getItemDetail(s)
		if turtle.getItemCount(s) > 0 then 
			for d=1,s-1 do
				if turtle.getItemSpace(d) > 0 then 
					local dest = turtle.getItemDetail(d)
					if dest == nil or StacksEqual(source,dest) then
						turtle.select(s)
						if turtle.transferTo(d) then
							if turtle.getItemCount() == 0 then break end
						end
					end
				end
			end
		end
	end
	
	return turtle.items.count() ~= count
end

function turtle.items.selected()
	return turtle.getItemDetail()
end

function turtle.items.select(item)
	local found,slot,count = turtle.items.find(item)
	if found then turtle.select(slot) end
	return found,slot,count
end

function turtle.items.depositAll(side)
	local dropCount = 0
	
	local chest = item_storage.wrap(side)
	if chest == nil then return 0 end	
	
	for n=1,turtle.items.size() do
		if turtle.items.count(n) > 0 then
			turtle.select(n)
			if not turtle.drop() then 
				return false
			end
		end
	end
	
	return true
end

return item_storage
