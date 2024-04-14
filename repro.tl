global record Foo
  bar : string
end

global function repro(x:Foo|string|integer|nil) : integer
  local y = x
  if y is integer then
  elseif y is string or y is Foo then
    return 1
  elseif y is nil then
    return 2
  end
  return 3 -- string falls through here!
end

print(repro({} as Foo)) --1
print(repro("1"))       --3
print(repro(nil))       --2
