-- Copyright (c) 2020 Mitchell Adair
-- 
-- (https://github.com/mitchwadair)
--  
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

function Behavior:Awake()
    --set defaults
    self.gameObject.spriteRenderer = self
    self.sprite = nil
    self.currentAnimation = nil
    self.currentAnimFrame = 0
    self.numFrames = 0
    self.animSpeed = 5
    self.loopAnimation = true
    self.isAnimationPlaying = false
    
    --functional vars
    self.animCounter = 0
    
    --construct
    if self.gameObject.textRenderer == nil then
        self.gameObject:CreateComponent("TextRenderer")
    else
        self.sprite = self.gameObject.textRenderer:GetFont()
    end
end

--[[
    Gets the current sprite of the SpriteRenderer
    
    @return the sprite Asset
]]--
function Behavior:GetSprite()
    return self.sprite
end

--[[
    Sets the sprite of the SpriteRenderer to the given sprite Asset (Font)
    
    @param sprite the Asset to assign
]]--
function Behavior:SetSprite(sprite)
    self.gameObject.textRenderer:SetFont(sprite)
    self.gameObject.textRenderer:SetText(" ")
    self.sprite = sprite
end

--[[
    Sets the animation of the SpriteRenderer to the given animation Asset (Font)
    
    @param animationAsset the Asset to assign
    @param numFrames the number of frames in the animation
]]--
function Behavior:SetAnimation(animationAsset, numFrames)
    if numFrames == nil then
        error("missing required argument 'numFrames' in SetAnimation call")
        return
    elseif type(numFrames) ~= "number" then
        error("argument 'numFrames' in SetAnimation call should be a number")
        return
    end
    self.gameObject.textRenderer:SetFont(animationAsset)
    self.currentAnimation = animationAsset
    self.currentAnimFrame = 0
    self.numFrames = numFrames
    self.animCounter = 0
end

--[[
    Gets the current animation of the SpriteRenderer
    
    @return the animation Asset
]]--
function Behavior:GetAnimation()
    return self.currentAnimation
end

--[[
    Sets the animation's frame duration of the SpriteRenderer to the given number of ticks
    
    @param ticks the number of game ticks for the frame to last
]]--
function Behavior:SetAnimationFrameDuration(ticks)
    if type(ticks) ~= "number" then
        error("argument 'ticks' in SetAnimationFrameDuration call should be a number")
        return
    end
    self.animSpeed = ticks
end

--[[
    Gets the duration of the current animation in seconds
    
    @return animation duration
]]--
function Behavior:GetAnimationDuration()
    return (self.numFrames * self.animSpeed) / 60
end

--[[
    Starts playback of the current animation
]]--
function Behavior:StartAnimationPlayback(loop)
    if loop == nil then
        self.loopAnimation = true
    else
        self.loopAnimation = loop
    end
    if self.currentAnimation == nil then
        error("no animation set for SpriteRenderer in GameObject "..self.gameObject:GetName())
        return
    else
        self.gameObject.textRenderer:SetFont(self.currentAnimation)
        self.gameObject.textRenderer:SetText(" ")
        self.isAnimationPlaying = true
    end
end

--[[
    Stops playback of the current animation
]]--
function Behavior:StopAnimationPlayback()
    self.isAnimationPlaying = false
    self.currentAnimFrame = 0
    self.gameObject.textRenderer:SetFont(self.sprite)
    self.gameObject.textRenderer:SetText(" ")
end

--[[
    Returns whether or not an animation is currently playing
    
    @return isAnimationPlaying
]]--
function Behavior:IsAnimationPlaying()
    return self.isAnimationPlaying
end

--[[
    Sets the opacity of the SpriteRenderer to the given value clamping between 0 and 1
    
    @param opacity the opacity value to set
]]--
function Behavior:SetOpacity(opacity)
    self.gameObject.textRenderer:SetOpacity(math.clamp(opacity, 0, 1))
end

--[[
    Returns the current SpriteRenderer opacity
    
    @return opacity of SpriteRenderer
]]--
function Behavior:GetOpacity()
    return self.gameObject.textRenderer:GetOpacity()
end

function Behavior:Update()
    if self.isAnimationPlaying then
        local newFrame = false
        if ((self.animSpeed-1) / self.animCounter == 1) or self.animSpeed == 1 then
            newFrame = true
            self.currentAnimFrame = self.currentAnimFrame + 1
            if self.currentAnimFrame >= self.numFrames then
                self.currentAnimFrame = 0
                if not self.loopAnimation then
                    self.gameObject.textRenderer:SetFont(self.sprite)
                    self:StopAnimationPlayback()
                end
            end
        end
        if newFrame then
            self.gameObject.textRenderer:SetText(string.char(self.currentAnimFrame + 32))
            self.animCounter = 0
        else
            self.animCounter = self.animCounter + 1
        end
    end
end