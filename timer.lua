--cc:Tweaked: Timer
--pastebin get mJKJ9hYq timer.lua



local timer = {}
local started = nil
local stopped = nil

function timer.start()
	stopped = nil
	started = os.clock()
end

function timer.stop()
	stopped = os.clock()
end

function timer.elapsed()
	if stopped == nil then
		return os.clock() - started
	else
		return stopped - started
	end
end

function timer.format(seconds)
	if seconds == nil then seconds = timer.elapsed() end
	
	local hours = math.floor(seconds / 3600)
	seconds = seconds % 3600
	local minutes = math.floor(seconds / 60)
	seconds = seconds % 60
	
	local stime = math.floor(seconds) .. "s"
	if(minutes > 0) then stime = minutes .. "m " .. stime end
	if(hours > 0) then stime = hours .. "h " .. stime end
	return stime
end

return timer
