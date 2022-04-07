# Vector2
SFramework provides a more 2D-intuitive way of using the native `Vector3` class.  Everything you can do with a `Vector3` in CraftStudio, you can also do with a `Vector2`, as it is simply an alias for `Vector3`.  `Vector2` provides just a couple of overrides that make sense in a 2D context, which you can find information on here.  For documentation on `Vector3` functions, you can find it on the CraftStudio wiki [here](https://elisee.github.io/craftstudio-wiki/Reference/Scripting/Math/Vector3.html).

# Contents
- [Vector2](#Vector2)
  - [New](#vector2new)
  - [Forward](#vector2forward)
  - [UnitZ](#vector2unitz)

# Vector2

## Vector2:New
Syntactic sugar for the `Vector3:New()` function.  Returns a Vector3 with Z value 0
### Arguments
- `x` - `number` the X value of the vector (also the Y value if it is the only argument)
- `y` - `number` (optional) the Y value of the vector
### Example
```lua
local myTwoArgVector2 = Vector2:New(1, 2)
print(myTwoArgVector2) -- prints {x=1, y=2, z=0}

local myOneArgVector2 = Vector2:New(1)
print(myOneArgVector2) -- prints {x=1, y=1, z=0}
```

## Vector2:Forward
Overrides `Vector3:Forward()` to error every time.  This is because we don't want to worry about anyting on the Z axis when using a Vector2
### Example
```lua
-- this will spit an error out in the game log
local myVector2 = Vector2:Forward()
```

## Vector2:UnitZ
Overrides `Vector3:UnitZ()` to error every time.  This is because we don't want to worry about anyting on the Z axis when using a Vector2
### Example
```lua
-- this will spit an error out in the game log
local myVector2 = Vector2:UnitZ()
```