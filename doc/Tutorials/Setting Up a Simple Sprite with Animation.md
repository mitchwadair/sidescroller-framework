# Setting up a Simple Sprite with Animations
In this tutorial, you will learn how to set up your first sprite and how to make it move!

# Contents
- [Set up your Sprite](#set-up-your-sprite)
  - [Folder Setup](#folder-setup)
  - [Create a New Font](#create-a-new-font)
  - [Scene Setup](#scene-setup)
- [Create a New Animation](#create-a-new-animation)
  - [Create the Font](#create-the-font)
  - [Paste your Sheet](#paste-your-sheet)
- [Use the Animation](#use-the-animation)
  - [GameObject Setup](#gameobject-setup)
  - [Write Some Code](#write-some-code)
    - [SpriteRenderer Reference](#spriterenderer-reference)
    - [Set Animation](#set-animation)
    - [Start Animation](#start-animation)
    - [Full Code](#full-code)

# Set up your Sprite
In SFramework, sprites are represented using the CraftStudio Font asset type.  Let's go over how to set your sprites up using Fonts.
## Folder Setup
While there is no specific way to set up your project's directory structure, I find it easiest to keep things organized with folders.  If you have imported the [sample assets](https://github.com/mitchwadair/sidescroller-framework/tree/master/assets/sample_package) into your project, there is already a `Sprites` folder created.  If not, my ideal folder structure under Fonts looks as follows
```
├─ Sprites
|  ├─ My Character
|  |  ├─ My Character.font
|  |  ├─ Animations
|  |  |  └─ Idle.font
```
Again, this is not required but is a good way to make your project organized.

## Create a New Font
Let's create our sprite now.  First, create a new Font asset under your desired directory.

![](https://i.imgur.com/2HKyjRf.png)

Give it a name, and hit "Create"

![](https://i.imgur.com/ICX8JMy.png)

## Add your Image
Now that we have a new Font asset created, open it.  Set up the dimensions of the Font to fit your sprite's image dimensions.  In my case, this meant a "Char cell size" of 45 by 64 pixels.  You can also make your sheet size pretty small.

![](https://i.imgur.com/wO5d0T4.png)

Now, remove the white background from your Font and paste in your sprite image.  Then you can set the image into the first font entry.

![](https://i.imgur.com/1JfIBYO.png)

## Scene Setup
Now that we have our "sprite" asset created, we can put it into a scene.  Open your scene (or create one if you do not have any) and make sure you have a Camera.  Now, create a new GameObject and place it within the camera's viewport.

![](https://i.imgur.com/xXB1gYt.png)
![](https://i.imgur.com/GNWtFXn.png)

Now, add a FontRenderer to your new object.

![](https://i.imgur.com/7Zen7aC.png)

And set the font to your 'sprite' asset Font.  In my case, I named my sprite "SampleSprite"

![](https://i.imgur.com/ruASn9O.png)
![](https://i.imgur.com/rKB73NZ.png)

Now instead of saying "Text", set your FontRenderer object's text to a space (" ") and your sprite will show up!

![](https://i.imgur.com/zqg4jTx.png)

# Create a New Animation
The nice thing about CraftStudio's Font asset is that it can act like a spritesheet for us!  Lets create one of our own.
## Create the Font
Follow the steps from [Create a New Font](#create-a-new-font) to create a new Font asset.
## Paste your Sheet
Now that we have another new Font asset, we can put our spritesheet into it.  Make sure your sheet size and cell sizes are appropriate.  Again, in my case, this meant a "Char cell size" of 45 by 64 pixels.

![](https://i.imgur.com/wO5d0T4.png)

Remove the white from your Font so it has a transparent background, then paste your images from the spritesheet into each cell in order from left to right.

![](https://i.imgur.com/QFswKzN.png)

And you're done!  Our animation is created.

# Use the Animation
Using an animation in SFramework is very similar to setting the animation of a [ModelRenderer](https://bitbucket.org/sparklinlabs/craftstud.io/wiki/Reference/Scripting/ModelRenderer).  In SFramework, it is as easy as 3 lines of code.
## GameObject Setup
Open the scene created previously in this tutorial and select your sprite GameObject.  Now, add a new scripted behavior to it.

![](https://i.imgur.com/qf0nZKP.png)

Now, let's create a new Lua script to play our animation.

![](https://i.imgur.com/DSTPmDY.png)

![](https://i.imgur.com/y1PJs6l.png)

![](https://i.imgur.com/3q42Gpo.png)

![](https://i.imgur.com/MwZYdZf.png)

## Write Some Code
### SpriteRenderer Reference
Open the script we just created.  First thing we need to do is create a SpriteRenderer component on our game object.  This can be done in two ways.  We can either do it in the scene, or do it programmatically.  To do it in the scene, add a new scripted behavior to the game object and set it to SFramework's SpriteRenderer component.

![](https://i.imgur.com/qf0nZKP.png)

![](https://i.imgur.com/DSTPmDY.png)

![](https://i.imgur.com/A7YTeHC.png)

We can now create a reference to this component in the `Awake()` behavior function of our new script by using the GameObject's [SpriteRenderer accessor](https://github.com/mitchwadair/sidescroller-framework/blob/master/doc/API/CraftStudio%20Extensions.md#accessors)
```lua
local mySpriteRenderer = self.gameObject.spriteRenderer
```
or, alternatively using GameObject's [CreateSpriteRenderer](https://github.com/mitchwadair/sidescroller-framework/blob/master/doc/API/CraftStudio%20Extensions.md#gameobjectcreatespriterenderer) function
```lua
local mySpriteRenderer = self.gameObject:GetSpriteRenderer()
```
If we want to create our SpriteRenderer programmatically, it is a simple line of code
```lua
local mySpriteRenderer = self.gameObject:CreateSpriteRenderer()
```
### Set Animation
Now that we have a reference to our SpriteRenderer, we need to set our animation.  We can do this using the SpriteRenderer's [SetAnimation](https://github.com/mitchwadair/sidescroller-framework/blob/master/doc/API/Components/SpriteRenderer.md#spriterenderersetanimation) function.  Remember the animation Font we just created?  We'll reference that asset as the first argument to our function call.  We also need to keep in mind the number of frames our animation consists of.  In my case, it is 6.  This will be our second function argument.
```lua
mySpriteRenderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle"), 6)
```
### Start Animation
The last step is to start playing the animation.  This is done using SpriteRenderer's [StartAnimationPlayback](https://github.com/mitchwadair/sidescroller-framework/blob/master/doc/API/Components/SpriteRenderer.md#spriterendererstartanimationplayback) function.  This function has an optional argument, `loop`.  If we want our animation to loop we can pass in `true` or omit it.  If not, we can pass `false`.  In my case, I added an idle animation so I will let it loop.
```lua
mySpriteRenderer:StartAnimationPlayback()
```
### Full Code
And were done!  If you start the game using your scene, you will see your sprite moving!

![](https://i.imgur.com/ANeU4ur.gif)

The full code that we've written in our new script should look like this:
```lua
function Behavior:Awake()
    local mySpriteRenderer = self.gameObject:CreateSpriteRenderer()
    mySpriteRenderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle"), 6)
    mySpriteRenderer:StartAnimationPlayback()
end
```
