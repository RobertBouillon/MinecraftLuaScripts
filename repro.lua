Foo = {}

























function repro(x)
   local y = x
   if type(y) == "string" or type(y) == "table" then
      return 1
   elseif y == nil then
      return 2
   end
   return 3
end


print(repro({}))
print(repro("1"))
print(repro(nil))
