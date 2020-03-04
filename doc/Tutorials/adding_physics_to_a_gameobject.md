# Adding Physics to a Game Object
In this tutorial, we will be adding the Physics component to a game object.

# Contents
- [Adding the Component](#adding-the-component)
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
The default values for the Physics component are good, but in some cases, you might need to change the values to fit your game object.  Most commonly you'll need to change the collider's width and height, and possibly the collider shape too.

![](https://i.imgur.com/c1xwtvZ.png)

# Visualizing the Collider
It is not very apparent when adding Physics to your object what your collider will look like.  To visualize it, you can use SFramework's sample box, triangle, and circle sprites.  Just add a child game object and center it on your game object.  Then, add a TextRenderer using the correct collider sprite (make sure the text value is ' '!) and adjust the child object's scale to fit your sprite.  These stretch values are what you will use as the width and height of your Physics component.

![](https://i.imgur.com/4DMW0tm.png)
