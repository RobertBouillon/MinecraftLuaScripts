$root = pwd
$tl = "$root\tl"
$tlb = "$root\tlb"


#mkdir $tlb\Storage
#mkdir $tlb\Factory

tl gen $tl\Storage\Common.tl -o $tlb\Storage\Common.lua
tl gen $tl\Storage\FluidStorage.tl -o $tlb\Storage\FluidStorage.lua
tl gen $tl\Storage\init.tl -o $tlb\Storage\init.lua
tl gen $tl\Storage\ItemStorage.tl -o $tlb\Storage\ItemStorage.lua

tl gen $tl\Factory\init.tl -o $tlb\Factory\init.lua
tl gen $tl\Factory\Item.tl -o $tlb\Factory\Item.lua
tl gen $tl\Factory\Machine.tl -o $tlb\Factory\Machine.lua
tl gen $tl\Factory\Recipe.tl -o $tlb\Factory\Recipe.lua

tl gen $tl\Factory\Packs\SkiesExpert.tl -o $tlb\Factory\Packs\SkiesExpert.lua

tl gen $tl\Common.tl -o $tlb\Common.lua
tl gen $tl\debugger.tl -o $tlb\debugger.lua
tl gen $tl\ps.tl -o $tlb\ps.lua


$test = "C:\Users\Robert\AppData\Local\.ftba\instances\7a26f83e-7353-4fb4-bc5d-637896dc4bbb\saves\Test\computercraft\computer\9\tl"

Copy-Item $tlb\Factory $test -Recurse -Force
Copy-Item $tlb\Storage $test -Recurse -Force
Copy-Item $tlb\Common.lua $test -Force
Copy-Item $tlb\Debugger.lua $test -Force
Copy-Item $tlb\ps.lua $test -Force
