# SFramework API Documentation
SFramework has some functionality that is useful.  Learn about these functions here.

# Contents
- [SFramework](#sframework)
  - [Accessors](#accessors)
  - [Physics](#physics)
    - [Physics Accessors](#physics-accessors)
    - [getGravity](#sfphysicsgetgravity)
    - [setGravity](#sfphysicsgetgravity)
    - [getPhysicsManager](#sfphysicsgetphysicsmanager)

# SFramework
SFramework's namespace is `SF`.  All SFramework functions will be called with this namespace.
## Accessors
```lua
  SF.physics
```

## Physics
### Physics Accessors
```lua
SF.physics.gravity
SF.physics.manager
```

### SF.physics.getGravity
Gets the current gravity value in SFramework in units per second
#### Example
```lua
local myGravity = SF.physics.GetGravity()
```

### SF.physics.setGravity
Sets the current gravity value in SFramework in units per second. The default value is 1
#### Arguments
- `g` - `number` (required) the gravity value to set
#### Example
```lua
SF.physics.setGravity(2)
```

### SF.physics.getPhysicsManager
Gets the instance of SF Physics Manager currently being used
#### Example
```lua
local myPhysicsManager = SF.physics.getPhysicsManager()
```
