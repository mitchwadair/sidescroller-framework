-- Copyright (c) 2020 Mitchell Adair
-- 
-- (https://github.com/mitchwadair)
--  
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

--[[
    Gets the sprite renderer from the calling GameObject
    
    @return the SpriteRenderer behavior
]]--
function GameObject:GetSpriteRenderer()
    return self.spriteRenderer
end

--[[
    Creates a SpriteRenderer on the calling GameObject
    
    @param sprite (optional) a Sprite asset (Font) to apply to the renderer on creation
    
    @return the SpriteRenderer behavior
]]--
function GameObject:CreateSpriteRenderer(sprite)
    local asset = CS.FindAsset('SFramework/Components/SpriteRenderer', 'Script')
    local renderer = self:CreateScriptedBehavior(asset)
    if sprite ~= nil then
        renderer:SetSprite(sprite)
    end
    return renderer
end

--[[
    Adds a physics component to the game object
    
    @param colliderType (optional) the collider type of the physics object
    @param width (optional) the width of the physics object (or diameter of circle)
    @param height (optional) the height of the physics object (or 0 if circle)
    @param mass (optional) the mass of the physics object
    @param static (optional) whether or not the object is static
    @param bounciness (optional) how much bounciness the object has
    
    @return the PhysicsObject behavior
]]--
function GameObject:AddPhysics(colliderType, width, height, mass, static, bounciness)
    local defaults = {}
    if colliderType ~= nil then defaults.colliderType = colliderType else defaults.colliderType = 'BOX' end
    if width ~= nil then defaults.width = width else defaults.width = 1 end
    if height ~= nil then defaults.height = height else defaults.height = 1 end
    if mass ~= nil then defaults.mass = mass else defaults.mass = 1 end
    if static ~= nil then defaults.static = static else defaults.static = false end
    if bounciness ~= nil then defaults.bounciness = bounciness else defaults.bounciness = 0 end
    
    return self:CreateScriptedBehavior(CS.FindAsset("SFramework/Components/Physics", "Script"), defaults)
end

--[[
    Gets the PhysicsObject from the calling GameObject
    
    @return the PhysicsObject behavior
]]--
function GameObject:GetPhysics()
    return self.physics
end
