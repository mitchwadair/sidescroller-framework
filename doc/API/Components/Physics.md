# Physics Component API
Physics component handles object physics.

# Contents
- [Physics](#physics)
  - [Accessors](#accessors)
  - [GetMass](#physicsgetmass)
  - [SetMass](#physicssetmass)
  - [GetWidth](#physicsgetwidth)
  - [SetWidth](#physicssetwidth)
  - [GetHeight](#physicsgetheight)
  - [SetHeight](#physicssetheight)
  - [GetBounciness](#physicsgetbounciness)
  - [SetBounciness](#physicssetbounciness)
  - [GetVelocity](#physicsgetvelocity)
  - [SetVelocity](#physicssetvelocity)
  - [IsStatic](#physicsisstatic)
  - [SetStatic](#physicssetstatic)
  - [ApplyImpulse](#physicsapplyimpulse)
  
#Physics
 
## Accessors
```lua
Physics.mass
Physics.width
Physics.height
Physics.bounciness
Physics.velocity
Physics.static
```

## Physics:GetMass
Returns the mass of the Physics object
### Example
```lua
local myMass = self.gameObject.physics:GetMass()
```

## Physics:SetMass
Sets the mass of the Physics object to the given value
### Arguments
- `mass` - `number` (required) the mass to set to
### Example
```lua
self.gameObject.physics:SetMass(5)
```

## Physics:GetWidth
Returns the width of the Physics object
### Example
```lua
local myWidth = self.gameObject.physics:GetWidth()
```

## Physics:SetWidth
Sets the width of the Physics object
### Arguments
- `width` - `number` (required) the width to set to
### Example
```lua
self.gameObject.physics:SetWidth(10)
```

## Physics:GetHeight
Returns the height of the Physics object
### Example
```lua
local myHeight = self.gameObject.physics:GetHeight()
```

## Physics:SetHeight
Sets the height of the Physics object
### Arguments
- `height` - `number` (required) the height to set to
### Example
```lua
self.gameObject.physics:SetHeight(10)
```

## Physics:GetBounciness
Returns the bounciness value of the Physics object
### Example
```lua
local myBounciness = self.gameObject.physics:GetBounciness()
```

## Physics:SetBounciness
Sets the bounciness of the Physics object to the given value
### Arguments
- `bounciness` - `number` (required) the bounciness to set to
### Example
```lua
self.gameObject.physics:SetBounciness(.5)
```

## Physics:GetVelocity
Returns the velocity vector of the object
### Example
```lua
local myVelocity = self.gameObject.physics:GetVelocity()
```

## Physics:SetVelocity
Sets the velocity of the Physics object to the given vector
### Arguments
- `velocity` - `Vector3` (required) the velocity to set to
### Example
```lua
self.gameObject.physics:SetVelocity(Vector3:New(2, 1, 0))
```

## Physics:IsStatic
Returns whether or not the Physics object is static
### Example
```lua
local isStatic = self.gameObject.physics:IsStatic()
```

## Physics:SetStatic
Sets whether or not the Physics object is static
### Arguments
- `static` - `bool` (required) true to set to static, false for non-static
### Example
```lua
self.gameObject.physics:SetStatic(false)
```

## Physics:ApplyImpulse
Applies an impulse to the Physics object according to the given vector
### Arguments
- `impulse` - `Vector3` (required) the impulse vector to apply
### Example
```lua
self.gameObject.physics:ApplyImpulse(Vector3:New(0, 1, 0))
```