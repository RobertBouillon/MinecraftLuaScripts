-- sort
--pastebin get T1p86Kg3 storage.lua

--Passthru: find, store, get, containers, etc
--shell.run("storage "..arg[0].." "..table.concat(arg," "))


local inventory = require("inventory")
local sides = require("sides")

STORAGE = { 
	--inventory.wrap("left"),
	--inventory.wrap("right")
}

DROP = inventory.wrap("metalbarrels:silver_tile_6")

function isStorage(name)
	local types = {peripheral.getType(name)}
	for _,t in pairs(types) do
		if t == "inventory" then return true end
	end
	return false
end

function containers()
	for _,v in pairs(STORAGE) do
		print(v.name)
	end
end

function findStorage()
	for _,storage in pairs(peripheral.getNames()) do
		if storage ~= DROP.name then
			if isStorage(storage) and not isSide(storage) then
				table.insert(STORAGE,inventory.wrap(storage))
			end
		end
	end
end

function store()
	storeAll()
	local size = 0
	local count = 0
	for _,storage in pairs(STORAGE) do
		size = size + storage.size()
		count = count + storage.count()
	end
	print(count.."/"..size.." slots full ("..string.format("%.2f", (count/size) * 100).. "%)")
end

function storeAll()
	local existing = {}
	for _,storage in pairs(STORAGE) do
		for item,_ in pairs(storage.counts()) do
			if existing[item] == nil then
				existing[item] = { storage }
			else
				table.insert(existing[item],storage)
			end
		end
	end
	
	for slot, item in pairs(DROP.list()) do
		if not storeItem(item, slot, existing) then return false end
	end
	return true
end

function storeItem(item, slot, existing)

	local preferredStorage = existing[item]
	if preferredStorage ~= nil then
		for _,storage in pairs(preferredStorage) do
			if DROP.push(storage, slot) then return true end
		end
	end

	for _,storage in pairs(STORAGE) do
		if not storage.isFull() then
			if DROP.push(storage, slot) then return true end
		end
	end
	return false
end

function findItem(search)
	for _,storage in pairs(STORAGE) do
		for item, count in pairs(storage.counts()) do
			if string.find(item,search) then
				--print(count .. " " .. item .. " in " .. storage.name)
				print(count .. " " .. item)
			end
		end
	end
end

function getItems(search, count)
	for _,storage in pairs(STORAGE) do
		for item, _ in pairs(storage.counts()) do
			if string.find(item,search) then
				local _, moved = storage.push(DROP,item,count)
				count = count - moved
				if count == 0 then return true, 0 end
			end
		end
	end
	return false, count
end


findStorage()

local tArgs = { ... }

if #tArgs == 1 then
	if(tArgs[1] == "store") then store() end
	if(tArgs[1] == "containers") then containers() end
end

if #tArgs == 2 then
	if(tArgs[1] == "find")  then findItem(tArgs[2]) end
	if(tArgs[1] == "get") then getItems(tArgs[2], 64) end
end

if #tArgs == 3 then
	if(tArgs[1] == "get") then getItems(tArgs[3], tonumber(tArgs[2])) end
end
