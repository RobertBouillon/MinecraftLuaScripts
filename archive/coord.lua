--cc:Tweaked: Coordinates
--pastebin get FDfbWryd coord.lua


local function coord(x,y,z)
  
  local self = {x=x or 0,y=y or 0,z=z or 0}
 
  function self.union (a) --A = complete, b = partial
    return coord(a.x or self.x,a.y or self.y,a.z or self.z)
  end
 
  function self.copy()
    return coord(self.x,self.y,self.z)
  end
 
  function self.isZero()
    return self.x==0 and self.y==0 and self.z == 0
  end
 
  function self.add(a)
    return coord(self.x + a.x, self.y + a.y, self.z + a.z)
  end
 
  function self.subtract(a)
    return coord(self.x - a.x, self.y - a.y, self.z - a.z)
  end
 
  function self.breakout()
    return self.x, self.y, self.z
  end
  
  function self.equals(a)
    return 
      self.x == a.x and
      self.y == a.y and
      self.z == a.z 
  end
 
  return self
 
end
 
return coord
