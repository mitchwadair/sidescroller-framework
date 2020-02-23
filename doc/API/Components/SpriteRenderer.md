# SpriteRenderer Component API
The SpriteRenderer object handles display and animation of sprites.  In SFramework, sprites are represented in Fonts.  Information on setting up a Font asset to act like a spritesheet can be found LINK_TODO.

# Contents
- [SpriteRenderer](#spriterenderer)
  - [GetSprite](#spriterenderergetsprite)
  - [SetSprite](#spriterenderersetsprite)
  - [GetAnimation](#spriterenderergetanimation)
  - [SetAnimation](#spriterenderersetanimation)
  - [SetAnimationFrameDuration](#spriterenderersetanimationframeduration)
  - [GetAnimationDuration](#spriterenderergetanimationduration)
  - [StartAnimationPlayback](#spriterendererstartanimationplayback)
  - [StopAnimationPlayback](#spriterendererstopanimationplayback)
  - [IsAnimationPlaying](#spriterendererinanimationplaying)
  - [GetOpacity](#spriterenderergetopacity)
  - [SetOpacity](#spriterenderersetopacity)

# SpriteRenderer

## SpriteRenderer:GetSprite
Returns a reference to the sprite asset being used.  Remember, a "Sprite" is actually a Font
### Example
```lua
local sprite = self.gameObject.spriteRenderer:GetSprite()
```
## SpriteRenderer:SetSprite
Sets the SpriteRenderer's sprite to the given "Sprite" (Font) asset
### Arguments
- `sprite` - `CS Asset` (required) the Font asset for the desired sprite
### Example
```lua
self.gameObject.spriteRenderer:SetSprite(CS.FindAsset("Sprites/Sample/SampleSprite", "Font"))
```

## SpriteRenderer:GetAnimation
Returns the current animation of the SpriteRenderer
### Example
```lua
local currentAnimation = self.gameObject.spriteRenderer:GetAnimation()
```

## SpriteRenderer:SetAnimation
Sets the animation of the SpriteRenderer to the given spritesheet Font asset
### Arguments
- `animationAsset` - `CS Asset` (required) the spritesheet to assign
- `numFrames` - `number` (required) the number of frames in the animation
### Example
```lua
self.gameObject.spriteRenderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle", "Font"))
```

## SpriteRenderer:SetAnimatinFrameDuration
Sets the animation's frame duration of the SpriteRenderer to the given number of game ticks.  Keep in mind that there are 60 ticks per second in CraftStudio.  So for instance, if you want to play an animation at 5 frames per second then you would divide 60 by 5 to get the number of ticks.  The default frame duration is 5 ticks.
### Arguments
- `ticks` - `number` (required) the number of game ticks per frame of the animation
### Example
```lua
self.gameObject.spriteRenderer:SetAnimationFrameDuration(30)
```

## SpriteRenderer:GetAnimationDuration
Gets the duration of the current animation in seconds
### Example
```lua
local animationLength = self.gameObject.spriteRenderer:GetAnimationDuration()
```

## SpriteRenderer:StartAnimationPlayback
Starts playback of the current animation
### Arguments
- `loop` - `bool` (optional) whether or not to loop the animation.  Default: `true`
### Example
```lua
self.gameObject.spriteRenderer:StartAnimationPlayback(true)
```

## SpriteRenderer:StopAnimationPlayback
Stops playback of current animation
### Example
```lua
self.gameObject.spriteRenderer:StopAnimationPlayback()
```

## SpriteRenderer:IsAnimationPlaying
Returns whether or not an animation is currently playing
### Example
```lua
local isAnimationPlaying = self.gameObject.spriteRenderer:IsAnimationPlaying()
```

## SpriteRenderer:GetOpacity
Returns the current opacity of the SpriteRenderer
### Example
```lua
local spriteOpacity = self.gameObject.spriteRenderer:GetOpacity()
```

## SpriteRenderer:SetOpacity
Sets the opacity of the SpriteRenderer to the given value, clamping between 0 and 1
### Arguments
- `opacity` - `number` (required) a number between 0 and 1 to apply to the opacity
### Example
```lua
self.gameObject.spriteRenderer:SetOpacity(.5)
```
