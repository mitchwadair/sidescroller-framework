# SF Physics Manager API
The SFramework Physics Manager handles storing references all physics objects in a scene as well as handling collision detection and resolution for Physics objects.

# Contents
- [SF Physics Manager](#sfphysicsmanager)
  - [Accessors](#accessors)
  - [AddPhysicsObject](#sfphysicsmanageraddphysicsobject)
  - [RemovePhysicsObject](#sfphysicsmanagerremovephysicsobject)
  - [GetCollisionData](#sfphysicsmanagergetcollisiondata)
  - [ResolveCollision](#sfphysicsmanagerresolvecollision)

# SF Physics Manager

## Accessors
```lua
SFPhysicsManager.physicsObjects
```

## SFPhysicsManager:AddPhysicsObject
Adds the given GameObject with Physics component to the manager's table of Physics objects
### Arguments
- `obj` - `GameObject` (required) the object to add
### Example
```lua
SF.physics.manager:AddPhysicsObject(self.gameObject)
```

## SFPhysicsManager:RemovePhysicsObject
Removes the given GameObject from the manager's table of Physics objects
### Arguments
- `obj` - `GameObject` (required) the object to remove
### Example
```lua
SF.physics.manager:RemovePhysicsObject(self.gameObject)
```

## SFPhysicsManager:GetCollisionData
Returns a table with collision depth and normal for the two given objects or `nil` if no collision
### Arguments
- `obj1` - `GameObject` (required) the first GameObject to check
- `obj2` - `GameObject` (required) the second GameObject to check
### Example
```lua
local myCollisionData = SF.physics.manager:GetCollisionData(self.gameObject, CS.FindGameObject("other object"))
if myCollisionData ~= nil then
    print("Collision depth: "..myCollisionData.depth)
    print("Collision normal: "..myCollisionData.normal)
end
```

## SFPhysicsManager:ResolveCollision
Resolves the collision between the two given objects with the given collision data
### Arguments
- `obj1` - `GameObject` (required) the first GameObject
- `obj2` - `GameObject` (required) the second GameObject
- `data` - `CollisionData` (required) the collision data
### Example
```lua
local myOtherObject = CS.FindGameObject("other object")
local myCollisionData = SF.physics.manager:GetCollisionData(self.gameObject, myOtherObject)
if myCollisionData ~= nil then
    SF.physics.manager:ResolveCollision(self.gameObject, myOtherObject, myCollisionData)
end
```
