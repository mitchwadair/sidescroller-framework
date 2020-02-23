# GameObject
SFramework extends upon some of the capability built into CraftStudio.  The GameObject has gained a few new functions.

# Contents
- [GameObject](#gameobject)
  - [Accessors](#accessors)
  - [GetSpriteRenderer](#gameobjectgetspriterenderer)
  - [CreateSpriteRenderer](#gameobjectcreatespriterenderer)
  - [AddPhysics](#gameobjectaddphysics)
  - [GetPhysics](#gameobjectgetphysics)

# GameObject

## Accessors
```lua
GameObject.spriteRenderer
```

## GameObject:GetSpriteRenderer
Returns a reference to the SpriteRenderer behavior of the object
### Example
```lua
local mySpriteRenderer = self.gameObject:GetSpriteRenderer()
```

## GameObject:CreateSpriteRenderer
Creates a new SpriteRenderer
### Arguments
- `sprite` - `CS Asset` (optional) a Font asset to set the default sprite to
### Examples
#### Creating Empty
```lua
local mySpriteRendererEmpty = self.gameObject:CreateSpriteRenderer()
```
#### Creating with a Default Sprite
```lua
local mySpriteRenderer = self.gameObject:CreateSpriteRenderer(CS.FindAsset("Sprites/Sample/SampleSprite", "Font"))
```

## GameObject:GetPhysics
Returns a reference to the Physics component of the object
### Example
```lua
local myPhysics = self.gameObject:GetPhysics()
```

## GameObject:AddPhysics
Adds a Physics component with default values to the object and returns a reference
### Arguments
- `width` - `number` (optional) the width of the collider - defaults to `1`
- `height` - `number` (optional) the height of the collider - defaults to `1`
- `mass` - `number` (optional) the mass of the object - defaults to `1`
- `static` - `bool` (optional) whether or not the object is static - defaults to `false`
- `bounciness` - `number` (optional) the bounciness of the object - defaults to `0`
### Examples
#### Adding with Default Values
```lua
local myDefaultPhysics = self.gameObject:AddPhysics()
```
### Adding with Custom Values
```lua
local myCustomPhysics self.gameObject:AddPhysics(1, 10, 1, false, .5)
```
