--cc:Tweaked: Sides enumeration
--pastebin get WJZ2YpA6 sides.lua


local sides = {}

sides.left = "left"
sides.front = "front"
sides.right = "right"
sides.back = "back"


local function listContainsValue(list,value)
	for _,v in pairs(list) do
		if v == value then return true end
	end
	return false
end

function isSide(value)
	return listContainsValue(sides,value)
end



return sides