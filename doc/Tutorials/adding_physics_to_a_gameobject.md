# Adding Physics to a Game Object
In this tutorial, we will be adding the Physics component to a game object.

# Contents
- [Adding the Component](#adding-the-component)\
  - [Add the Behavior](#add-the-behavior)
  - [Setting Values](#setting-values)
- [Visualizing the Collider](#visualizing-the-collider)

# Adding the Component
To use Physics components and colliders in SFramework, you must add the behavior to your GameObject
## Add the Behavior
First, select your game object, and add a new scripted behavior

![](https://i.imgur.com/DFDxfWb.png)

![](https://i.imgur.com/DSTPmDY.png)

![](https://i.imgur.com/Iuqo0ti.png)

## Setting Values
The default values for the Physics component are good, but in some cases, you might need to change the values to fit your game object.

**NOTE: If you are using a circle collider, the `height` value will not be considered** 

![](https://i.imgur.com/Q4IzV4j.png)

# Visualizing the Collider
It is not very apparent when adding Physics to your object what your collider will look like.  To visualize it, you can use SFramework's sample box, triangle, and circle sprites.  Just add a child game object and center it on your game object.  Then, add a TextRenderer using the correct collider sprite and adjust the child object's scale to fit your sprite.  These stretch values are what you will use as the width and height of your Physics component.  Make sure you are using a space (' ') as your TextRenderer's text value to display the collider visualizer correctly.

![](https://i.imgur.com/4DMW0tm.png)
