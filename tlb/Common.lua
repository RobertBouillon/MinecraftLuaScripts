local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local debug = _tl_compat and _tl_compat.debug or debug; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; function tableContains(source, element)
   for _, value in ipairs(source) do
      if value == element then
         return true
      end
   end
   return false
end

function repack(source)
   if type(source) == "table" then return { source }
   elseif type(source) == "table" then return source
   end
end

function traceStack()
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
