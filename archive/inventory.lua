--cc:Tweaked: Turtle Inventory Management
--pastebin get 8JaJH3g2 inventory.lua
--inv=require("inventory")
--chest=inv.wrap("left")
--chest.count()
--require("inventory").wrap("left").find("minecraft:redstone")

local inventory = {}

function stacksEqual(a,b)
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
		for slot,item in pairs(_list()) do
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
			if stacksEqual(item, cursor) then return true, slot, cursor.count end
		end
		return false
	end

	function base.isFull()
		return base.count() == _size()
	end
	
	function base.count(item)
		local count = 0

		if item == nil then
			for slot,cursor in pairs(_list()) do
				count = count + 1
			end
			return count
		elseif 
			type(item) == "number" then return _count(item)
		else
			for _,cursor in pairs(_list()) do
				if stacksEqual(cursor, item) then
					count = count + cursor.count
				end
			end
			return count
		end
	end
	
	return base
end

function inventory.wrap(side)

	local __wrapper = peripheral.wrap(side)
	if __wrapper == nil then return nil end

	local chest = extend(
		function(slot) local items = __wrapper.list() if items[slot] == nil then return 0 else return items[slot].count end end,
		function() return __wrapper.size() end,
		function(slot) return __wrapper.getItemDetail(slot) end,
		function() return __wrapper.list() end
	)
	
	chest.name = side
  chest.peripheral = __wrapper

  function chest.pushMax(to, item, max, toSlot)
    local count
    if type(to) == "string" then
      if not inventory.isInventory() then error("'" .. to .."' is not an inventory") end
      count = max - inventory.wrap(to).count(item)
    else
      count = max - to.count(item)
    end
    chest.push(to,item,count,toSlot)
  end

	--Moves an item from this inventory to another.
	--[item | slot] = item can be item name or slot
	--returns: 
	--  Boolean - Entire stack moved and slot is now empty
	--  Number  - Number of items in stack moved
	function chest.push(to, item, count, toSlot)
		if type(to) ~= "string" and type(to.name) == "string" then to = to.name end

		if type(item) == "number" then
			--push to slot
			if(count == nil) then count = chest.count(item) end
			local moved = __wrapper.pushItems(to,item,count,toSlot)
			return count == moved,moved
		end

    if item ~= nil and toSlot == nil and chest.isInventory(to) then
      local found,slot = inventory.wrap(to).find(item)
      if found then toSlot = slot end
    end

    if item == nil then
			--push all
      for slot,item in pairs(chest.list()) do
        __wrapper.pushItems(to,slot,item.count,toSlot)
      end
		end

		local counted =  chest.count(item)
		if count == nil then count = counted end

		local total = 0
		repeat
			local found, slot, stack = chest.find(item)
			if not found then return total > 0, total end
			if stack > count - total then stack = count - total end
      local moved = __wrapper.pushItems(to,slot,stack,toSlot)
      if moved > 0 then
			  total = total + moved
      else
        break
      end
		until count == total
		return true, total
	end
	
	function chest.pull(from,item,count,toSlot)
		return from.push(chest,item,count,toSlot)
	end
	
	--Turtle can't interact directly with chests in this way in CC:Tweaked. Modem required.
	--https://github.com/cc-tweaked/CC-Tweaked/discussions/601
	function chest.put(item, count, toSlot)
		error("Not Supported")
	end

	function chest.get(item, count)
		error("Not implemented")
	end

  function chest.isInventory(name)
    local types = {peripheral.getType(name)}
    for _,t in pairs(types) do
      if t == "inventory" then return true end
    end
    return false
  end
  
	
	return chest
end

if turtle == nil then return inventory end

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
					if dest == nil or stacksEqual(source,dest) then
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
	
	local chest = inventory.wrap(side)
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

return inventory
