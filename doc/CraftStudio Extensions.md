# CraftStudio Extensions
SFramework extends upon some of the capability built into CraftStudio.

# Content
- [GameObject](#gameobject)
  - [Accessors](#gameobject-accessors)
  - [GetSpriteRenderer](#gameobjectgetspriterenderer)
  - [CreateSpriteRenderer](#gameobjectcreatespriterenderer)

# GameObject
## GameObject accessors
```cs
GameObject.spriteRenderer
```
## GameObject:GetSpriteRenderer
Returns a reference to the SpriteRenderer behavior of the object
### Example:
```cs
local mySpriteRenderer = self.gameObject:GetSpriteRenderer()
```
## GameObject:CreateSpriteRenderer
Creates a new SpriteRenderer.
### Arguments:
- `sprite` (optional) a Font asset to set the default sprite to
### Examples:
#### Creating Empty
```cs
local mySpriteRendererEmpty = self.gameObject:CreateSpriteRenderer()
```
#### Creating with a Default Sprite
```cs
local mySpriteRenderer = self.gameObject:CreateSpriteRenderer(CS.FindAsset("path to Font Asset", "Font"))
```
