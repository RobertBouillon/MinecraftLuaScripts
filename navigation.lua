--cc:Tweaked Turtle Navigation
--pastebin get DBMuZyEc navigation.lua
--nav = require("navigation")
--


local sides = require("sides")
local coord = require("coord")


local navOffset --Actual XYZ, not Minecraft (width,length,height)
local navFacing = sides.front

local navigation = {}

function navigation.setHome()
	navOffset = coord()
end
navigation.setHome()

function navigation.getPosition()
	return navOffset.copy()
end

function navigation.getDirection()
	return navFacing
end

function navigation.up()
	while true do
		local blocked,item = turtle.detectUp()
		
		if blocked then
			turtle.digUp()
		else
			local moved, result = turtle.up()
			if moved then
				navOffset.z = navOffset.z + 1
				return true
			else
				turtle.digUp() 
			end
		end
	end
end
 
function navigation.down()
	while true do
		local blocked,item = turtle.detectDown()
		
		if blocked then
			turtle.digDown()
		else
			local moved, result = turtle.down()
			if moved then
				navOffset.z = navOffset.z - 1
				return true
			else
				turtle.digDown() 
			end
		end
	end
end
 
function navigation.forward()
	while true do
		local blocked,item = turtle.detect()
		
		if blocked then
			turtle.dig()
		end
		local moved, result = turtle.forward()
		if moved then
			if navFacing == sides.front then
				navOffset.y = navOffset.y + 1
			elseif navFacing == sides.right then
				navOffset.x = navOffset.x + 1
			elseif navFacing == sides.back then
				navOffset.y = navOffset.y - 1
			elseif navFacing == sides.left then
				navOffset.x = navOffset.x - 1
			end
			return true
		else
			turtle.dig() 
		end
	end
end
 
function navigation.back()	
	while not turtle.back() do end
	
	if navFacing == sides.front then
		navOffset.y = navOffset.y - 1
	elseif navFacing == sides.right then
		navOffset.x = navOffset.x - 1
	elseif navFacing == sides.back then
		navOffset.y = navOffset.y + 1
	elseif navFacing == sides.left then
		navOffset.x = navOffset.x + 1
	end
end
 
function navigation.left()
	turtle.turnLeft()
	
	if navFacing == sides.front then
		navFacing = sides.left
	elseif navFacing == sides.right then
		navFacing = sides.front
	elseif navFacing == sides.back then
		navFacing = sides.right
	elseif navFacing == sides.left then
		navFacing = sides.back
	end
end
 
function navigation.right()
	turtle.turnRight()
	
	if navFacing == sides.front then
		navFacing = sides.right
	elseif navFacing == sides.right then
		navFacing = sides.back
	elseif navFacing == sides.back then
		navFacing = sides.left
	elseif navFacing == sides.left then
		navFacing = sides.front
	end
end

function navigation.turnTo(side)
	if navFacing == sides.front then
		if side == sides.front then
		elseif side == sides.right then
			navigation.right()
		elseif side == sides.back then
			navigation.right()
			navigation.right()
		elseif side == sides.left then
			navigation.left()
		end
	elseif navFacing == sides.right then
		if side == sides.front then
			navigation.left()
		elseif side == sides.right then
		elseif side == sides.back then
			navigation.right()
		elseif side == sides.left then
			navigation.right()
			navigation.right()
		end
	elseif navFacing == sides.back then
		if side == sides.front then
			navigation.right()
			navigation.right()
		elseif side == sides.right then
			navigation.left()
		elseif side == sides.back then
		elseif side == sides.left then
			navigation.right()
		end
	elseif navFacing == sides.left then
		if side == sides.front then
			navigation.right()
		elseif side == sides.right then
			navigation.right()
			navigation.right()
		elseif side == sides.back then
			navigation.left()
		elseif side == sides.left then
		end
	end
	navFacing = side
end

function navigation.moveTo(position)
	position = navOffset.union(position)
	local delta = position.subtract(navOffset)
	
	if delta.z > 0 then
		for i=1,delta.z do navigation.up() end
	elseif delta.z < 0 then
		for i=1,-delta.z do navigation.down() end
	end

	if delta.x > 0 then
		navigation.turnTo(sides.right)
		for i=1,delta.x do navigation.forward() end
	elseif delta.x < 0 then
		navigation.turnTo(sides.left)
		for i=1,-delta.x do navigation.forward() end
	end
	
	if delta.y > 0 then
		navigation.turnTo(sides.front)
		for i=1,delta.y do navigation.forward() end
	elseif delta.y <0 then
		navigation.turnTo(sides.back)
		for i=1,-delta.y do navigation.forward() end
	end
end


function navigation.moveHome()
	navigation.moveTo({y=0})
	navigation.moveTo({x=0})
	navigation.moveTo({z=0})
end

return navigation
