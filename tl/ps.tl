require "tl/ccapi"

-- Peripheral Search
-- usage: ps <search string>

for _,x in ipairs(peripheral.getNames()) do
  if string.find(x,arg[1]) then
    print(x)
  end
end