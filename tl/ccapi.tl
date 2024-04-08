global function sleep(time : number | nil) end

global record peripheral
  getNames: function() : {string}
  getType: function(name: string) : string
  wrap: function(name : string) : peripheral

  record ItemDetail
    name : string
    count : integer
  end

  record fluid_storage
    tanks: function() : { integer : ItemDetail}
    pushFluid: function(toName:string,limit:integer|nil,fluidName:string|nil) : integer
    pullFluid: function(fromName:string,limit:integer|nil,fluidName:string|nil) : integer
  end

  record inventory
    size: function() : integer
    list: function() : any
    getItemDetail: function(slot: integer) : ItemDetail
    getItemLimit: function(slot: integer) : integer
    pushItems: function(toName: string, fromSlot : integer, limit : integer, toSlot: integer) : integer
    pullItems: function(fromName: string, fromSlot : integer, limit : integer, toSlot: integer) : integer
  end
end

global record term
  clear: function()
  nativePaletteColour: function(colour : number) : number,number,number
  nativePaletteColor: function(colour: number) : number,number,number
  write: function(text: string)
  scroll: function(y : integer)
  getCursorPos: function() : integer, integer
  setCursorPos: function(x : integer, y : integer)
  getCursorBlink: function() : boolean
  setCursorBlink: function(blink : boolean)
  getSize: function() : integer, integer
  clearLine: function()
  getTextColour: function()	: number
  getTextColor: function() : number
  setTextColour: function(colour : number) 
  setTextColor: function(colour : number)
  getBackgroundColour: function() : number
  getBackgroundColor: function() : number
  setBackgroundColour: function(colour : number)
  setBackgroundColor: function(colour : number)
  isColour: function() : boolean
  isColor: function() : boolean
  blit: function(text : string, textColour : string, backgroundColour : string)
  setPaletteColour: function(... : number)
  setPaletteColor: function(... : number)
  getPaletteColour: function(colour : number) : number, number, number
  getPaletteColor: function(colour : number) : number, number, number
  redirect: function(target : any)
  current: function() : any
  native: function() : any
end
