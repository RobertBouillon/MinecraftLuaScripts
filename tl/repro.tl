global record Foo
  bar : string
end

-- global function repro(x:Foo|string|nil) : integer
--   local y = x
--   if y is string | Foo then
--     return 1
--   elseif y is nil then
--     return 2
--   end
--   return 3 -- string falls through here!
-- end

-- global function repro(x:Foo|string|nil) : integer
--   local y = x
--   if y is nil then
--     local z : nil = y 
--     return 2
--   elseif type(y) == "table" or type(y) == "string" then
--     local z : Foo | string = y
--     return 1
--   end
--   return 3 --No fall through
-- end

global function repro(x:Foo|string|nil) : integer
  local y = x
  if y is string or y is Foo then
    return 1
  elseif y is nil then
    return 2
  end
  return 3 -- string falls through here!
end


print(repro({} as Foo)) --1
print(repro("1"))       --3
print(repro(nil))       --2
