-- fluids
--pastebin get 0bvF2EWk fluids.lua

local fluids = {}


function fluids.wrap(name)
	local tank = {}
	local wrapper = peripheral.wrap(name)
	tank.name = name

	function tank.list()
		return wrapper.tanks()
	end
	
	function tank.contains(fluid)
		for _,f in pairs(tank.list()) do
			if fluid == f.name then return true, f.amount end
		end
	end
	
	function tank.count(fluid)
		for _,f in pairs(tank.list()) do
			if fluid == f.name then return f.amount end
		end
    return 0
	end

	function tank.find(fluid)
		for slot,cursor in pairs(tank.list()) do
			if cursor.name == fluid then return true, slot, cursor.amount end
		end
		return false
	end

	
	function tank.push(to,fluid,amount)
		if to.name ~= nil then to = to.name end
		local moved = wrapper.pushFluid(to,amount,fluid)
		return moved == amount, moved
	end
	
	function tank.pushMax(to,fluid,amount)
		if to.name ~= nil then to = to.name end
    local amount = amount - fluids.wrap(to).count(fluid)
    if amount <= 0 then return 0,0 end
		local moved = wrapper.pushFluid(to,amount,fluid)
		return moved == amount, moved
	end
	
	function tank.pull(from,fluid,amount)
		if from.name ~= nil then from = from.name end
		local moved = wrapper.pullFluid(from,amount,fluid)
		return moved == amount, moved
	end
	return tank
end

function fluids.isTank(name)
	local types = {peripheral.getType(name)}
	for _,t in pairs(types) do
		if t == "fluid_storage" then return true end
	end
	return false
end

function fluids.list()
	local ret = {}
	for _,peripheral in pairs(peripheral.getNames()) do
		if fluids.isTank(peripheral) then
			ret[peripheral]=fluids.wrap(peripheral)
		end
	end
	return ret
end

return fluids