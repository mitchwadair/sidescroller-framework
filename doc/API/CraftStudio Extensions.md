# CraftStudio Extensions
SFramework extends upon some of the capability built into CraftStudio.

# Contents
- [GameObject](#gameobject)
  - [Accessors](#accessors)
  - [GetSpriteRenderer](#gameobjectgetspriterenderer)
  - [CreateSpriteRenderer](#gameobjectcreatespriterenderer)

# GameObject
## Accessors
```lua
GameObject.spriteRenderer
```
## GameObject:GetSpriteRenderer
Returns a reference to the SpriteRenderer behavior of the object
### Example:
```lua
local mySpriteRenderer = self.gameObject:GetSpriteRenderer()
```
## GameObject:CreateSpriteRenderer
Creates a new SpriteRenderer.
### Arguments:
- `sprite` - `CS Asset` (optional) a Font asset to set the default sprite to
### Examples:
#### Creating Empty
```lua
local mySpriteRendererEmpty = self.gameObject:CreateSpriteRenderer()
```
#### Creating with a Default Sprite
```lua
local mySpriteRenderer = self.gameObject:CreateSpriteRenderer(CS.FindAsset("Sprites/Sample/SampleSprite", "Font"))
```
