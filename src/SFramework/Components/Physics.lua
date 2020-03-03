--[[PublicProperties
width number 1
height number 1
mass number 1
static boolean False
bounciness number 0
colliderType string "BOX"
/PublicProperties]]
--[[ Made by Mitchell Adair https://github.com/mitchwadair ]]--

function Behavior:Awake()
    -- initialize physics managaer if it is not present
    if CS.FindGameObject("__sf_physics_manager__") == nil then
        local pm = CS.CreateGameObject("__sf_physics_manager__"):CreateScriptedBehavior(CS.FindAsset("SFramework/Engines/SF Physics Manager"))
        SF.physics.manager = pm
    end
    -- add self to physics manager
    SF.physics.manager:AddPhysicsObject(self.gameObject)
    -- set GameObject accessor to self
    self.gameObject.physics = self
    
    self.halfWidth = self.width/2
    self.halfHeight = self.height/2
    self.inverseMass = 0
    if not self.static and self.mass > 0 then self.inverseMass = 1/self.mass end
    
    self.colliderType = string.upper(self.colliderType) --make it more robust
    
    self.velocity = Vector3:New(0, 0, 0)
end

--[[
    Returns the physics object's velocity
    
    @return the velocity of the physics object
]]--
function Behavior:GetVelocity()
    return self.velocity
end

--[[
    Sets the physics object's velocity
    
    @param vel (required) the velocity to set
]]--
function Behavior:SetVelocity(vel)
    if vel == nil then
        error("missing required argument 'vel' in SetVelocity call")
        return
    end
    
    self.velocity = vel
end

--[[
    Applies an impulse to the physics object
    
    @param impulse (required) the impulse to apply
]]--
function Behavior:ApplyImpulse(impulse)
    if impulse == nil then
        error("missing required argument 'impulse' in ApplyImpulse call")
        return
    end

    self.velocity = self.velocity + impulse
end

--[[
    Returns the physics object's mass
    
    @return the mass of the physics object
]]--
function Behavior:GetMass()
    return self.mass
end

--[[
    Sets the physics object's mass
    
    @param mass (required) the mass to set
]]--
function Behavior:SetMass(mass)
    if mass == nil then
        error("missing required argument 'mass' in SetMass call")
        return
    end
    
    self.mass = mass
end

--[[
    Returns the physics object's width
    
    @return the width of the physics object
]]--
function Behavior:GetWidth()
    return self.width
end

--[[
    Sets the physics object's width
    
    @param width (required) the width to set
]]--
function Behavior:SetWidth(width)
    if width == nil then
        error("missing required argument 'width' in SetWidth call")
        return
    end
    
    self.width = width
end

--[[
    Returns the physics object's height
    
    @return the height of the physics object
]]--
function Behavior:GetHeight()
    return self.height
end

--[[
    Sets the physics object's height
    
    @param height (required) the height to set
]]--
function Behavior:SetHeight(height)
    if height == nil then
        error("missing required argument 'height' in SetHeight call")
        return
    end
    
    self.height = height
end

--[[
    Returns the physics object's bounciness
    
    @return the bounciness of the physics object
]]--
function Behavior:GetBounciness()
    return self.bounciness
end

--[[
    Sets the physics object's bounciness
    
    @param bounciness (required) the bounciness to set
]]--
function Behavior:SetBounciness(bounciness)
    if bounciness == nil then
        error("missing required argument 'bounciness' in SetBounciness call")
        return
    end
    
    self.bounciness = bounciness
end

--[[
    Determines if the physics object is static
    
    @return true if static, false if not
]]--
function Behavior:IsStatic()
    return self.static
end

--[[
    Sets whether or not the physics object is static
    
    @param static (required) true or false
]]--
function Behavior:SetStatic(static)
    if static == nil then
        error("missing required argument 'static' in SetStatic call")
        return
    end
    
    self.static = static
end

--[[
    Returns the physics object's collider type
    
    @return the collider type of the physics object
]]--
function Behavior:GetColliderType()
    return self.colliderType
end

--[[
    Sets the physics object's collider type to the one given
    
    @param type (required) BOX, CIRCLE, or TRIANGLE
]]--
function Behavior:SetColliderType(type)
    if type == nil then
        error("missing required argument 'type' in SetColliderType call")
        return
    end
    local upperCase = string.upper(type)
    if upperCase ~= 'CIRCLE' and upperCase ~= 'BOX' and upperCase ~= 'TRIANGLE' then
        error("argument 'type' in SetColliderType must be 'BOX', 'CIRCLE', or 'TRIANGLE'")
        return
    end
    
    self.colliderType = upperCase
end

function Behavior:Update()
    local manager = SF.physics.manager
    if not self.static then
        for i,v in ipairs(manager.physicsObjects) do
            if v ~= self.gameObject then
                local colData = manager:GetCollisionData(self.gameObject, v)
                if colData ~= nil then
                    manager:ResolveCollision(self.gameObject, v, colData)
                end
            end
        end
        
        self.velocity.y = self.velocity.y - (SF.physics.gravity/60)
        self.gameObject.transform:SetPosition(self.gameObject.transform:GetPosition() + self.velocity)
    end
end
