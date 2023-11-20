# Usage
Run the following script on any CC:tweaked turtle to install these scripts
`pastebin run JmhPbamn`

## Programs

### Refuel
Refuels the turtle using coal, charcoal, or blocks of coal.
`refuel`

### Quarry
Mines a given area and periodically deposits valuable ores. Includes a blacklist for junk ores.

> Usage: `quarry <depth> <distance> <width>`

### Passage
Creates a secure passage through dangerous areas using cobblestone and glass

> Usage: `passage <distance>`


### Inscriber
Automation for the AE2 inscriber. Place a chest to the left of an advanced computer and a powered inscriber to the right.

> Usage: `inscriber`

### Farmer
Will repeatedly plant, fertilize, and harvest a crop on a single block in front of the turtle.

Place the seed in slot #1 and the fertilizer in slot #2. A fully-grown plant is required in front of the turtle to start the process.
The turtle will use items in the entire inventory.

> Usage: `farm`


## Libraries

### Sides
A simple enumeration for sides

### Timer
Diagnostic Timing functions

### Inventory
Inventory manipulation. Use `inventory.wrap(side)` for an external inventory or `turtle.items` for the local inventory.

### Nagigation
Intelligent turtle navigation

### Coord
Common tuple (x,y,z) used for navigation
