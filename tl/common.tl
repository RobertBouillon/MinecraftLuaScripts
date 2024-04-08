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
  print(debug.getinfo(3).name)
  print(debug.getinfo(2).name)
  print(debug.getinfo(1).name)
  print("---")
end