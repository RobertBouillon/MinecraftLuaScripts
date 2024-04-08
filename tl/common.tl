global function tableContains<T>(source : {T}, element : T) : boolean
  for _, value in ipairs(source) do
    if value == element then
      return true
    end
  end
  return false
end

global function repack<T>(source : {T} | T) : {T}
  if source is T then return {source} 
  elseif source is {T} then return source
  end
end

global function traceStack()
  local i = 2
  while true do
    local frame = debug.getinfo(i)
    if frame == nil then break end
    if frame.name == nil then break end
    print(frame.name)
    i = i + 1
  end
  print("---")
end

global record Range
  min : integer | nil
  max : integer | nil

  within : function(self : Range, value : integer) : boolean
end

function Range:within(value : integer) : boolean
  local min = self.min
  local max = self.max

  if min is integer then
    if value < min then return false end
  end
  if max is integer then
    if value > max then return false end
  end
  return true
end
