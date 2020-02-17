--[[ Made by Mitchell Adair https://github.com/mitchwadair ]]--

SF = {}

--
SF.physics = {}
SF.physics.manager = nil
SF.physics.gravity = 9.8 --the gravity in units/second

--[[
    Sets the gravity to the given value (in units/second)
    
    @param the gravity in units per second
]]--
SF.physics.setGravity = function(g)
    SF.physics.gravity = g
end


--[[ EXTEND GAMEOBJECT ]]--
--[[
    Gets the sprite renderer from the calling GameObject
    
    @return the SpriteRenderer behavior
]]--
function GameObject:GetSpriteRenderer()
    return self.spriteRenderer
end

--[[
    Creates a SpriteRenderer on the calling GameObject
    
    @param (optional) sprite a Sprite asset (Font) to apply to the renderer on creation
    
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

--[[ EXTEND TABLE ]]--
function table.indexOf(t, val)
    for i,v in ipairs(t) do
        if v == val then
            return i
        end
    end
    return 0
end