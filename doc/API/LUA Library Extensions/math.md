# LUA Math Library Extensions
SFramework expands upon some of the built-in LUA math library functionality.  Here, you can find reference for these additions.

# Contents
- [math](#math)
  - [sign](#mathsign)
  
# math

## math.sign
Returns the sign of the given value, either 1 if positive or -1 if negative.
This could be useful if needing to do some numerical logic based on whether or not the given value is above or below zero
### Arguments
- `value` - `number` (required) the value to check
### Example
```lua
local mySign = math.sign(5) --should return 1
```
