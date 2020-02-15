--[[ Sidescroller Framework V0.2.1 ]]--
--[[ Made by Mitchell Adair ]]--

SF = {}

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
    local asset = CS.FindAsset('SFramework/Scripts/Engines/SpriteRenderer', 'Script')
    local renderer = self:CreateScriptedBehavior(asset)
    if sprite ~= nil then
        renderer:SetSprite(sprite)
    end
    return renderer
end

--[[ Sidescroller Framework V0.2.1 ]]--
--[[ Made by Mitchell Adair ]]--