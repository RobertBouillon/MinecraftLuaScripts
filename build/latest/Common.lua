local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local debug = _tl_compat and _tl_compat.debug or debug; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local pairs = _tl_compat and _tl_compat.pairs or pairs; local table = _tl_compat and _tl_compat.table or table; function tableContains(source, element)
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

Range = {}






function Range:within(value)
   local min = self.min
   local max = self.max

   if math.type(min) == "integer" then
      if value < min then return false end
   end
   if math.type(max) == "integer" then
      if value > max then return false end
   end
   return true
end

function pairsByKeys(t, compare)
   local a = {}
   for n in pairs(t) do table.insert(a, n) end
   table.sort(a, compare)
   local i = 0
   local iter = function()
      i = i + 1



      return a[i], t[a[i]]
   end
   return iter
end
