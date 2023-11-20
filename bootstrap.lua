--CC: Tweaked - Bootstrap for Create Above and Beyond
--pastebin run JmhPbamn

-- shell.run("delete coord.lua")
-- shell.run("delete sides.lua")
-- shell.run("delete inventory.lua")
-- shell.run("delete navigation.lua")
-- shell.run("delete timer.lua")

-- shell.run("delete refuel.lua")
-- shell.run("delete quarry.lua")
-- shell.run("delete passage.lua")

-- shell.run("pastebin get FDfbWryd coord.lua")
-- shell.run("pastebin get WJZ2YpA6 sides.lua")
-- shell.run("pastebin get 8JaJH3g2 inventory.lua")
-- shell.run("pastebin get DBMuZyEc navigation.lua")
-- shell.run("pastebin get mJKJ9hYq timer.lua")

-- shell.run("pastebin get SB98ccny refuel.lua")
-- shell.run("pastebin get UfndbHaX quarry.lua")
-- shell.run("pastebin get xzvapSjN passage.lua")
-- shell.run("pastebin get mseF1Kbc farm.lua")
-- shell.run("pastebin get T1p86Kg3 storage.lua")


local function delete(file)

end

local function download(id, file)
	delete(file)
	shell.run("pastebin get " .. id .. " " .. file .. ".lua")
end

local function makePassthru(name)
	local file = fs.open(name .. ".lua","a") -- This opens the file with the users name in the folder "saves" for appending.
	local passthru = "shell.run(\"storage \"..arg[0]..\" \"..table.concat(arg,\" \"))"
	file.writeLine(passthru) -- Put the real name in the file.
	file.close() -- Allows the file to be opened again by something else, and stops any corruption.
end

download("FDfbWryd", "coord")
download("WJZ2YpA6", "sides")
download("8JaJH3g2", "inventory")
download("DBMuZyEc", "navigation")
download("mJKJ9hYq", "timer")

download("SB98ccny", "refuel")
download("UfndbHaX", "quarry")
download("xzvapSjN", "passage")
download("mseF1Kbc", "farm")
download("T1p86Kg3", "storage")

makePassthru("get")
makePassthru("containers")
makePassthru("store")
makePassthru("find")
