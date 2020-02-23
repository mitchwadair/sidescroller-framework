--[[PublicProperties
width number 1
height number 1
mass number 1
static boolean False
bounciness number 0
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
    
    self.gameObject.halfWidth = self.width/2
    self.gameObject.halfHeight = self.height/2
    self.gameObject.bounciness = self.bounciness
    self.gameObject.static = self.static
    self.gameObject.inverseMass = 0
    if not self.static and self.mass > 0 then self.gameObject.inverseMass = 1/self.mass end
    
    self.gameObject.colliderType = 'BOX'
    if self.height == 0 then self.gameObject.colliderType = 'CIRCLE' end
    
    self.pos = self.gameObject.transform:GetPosition()
    self.gameObject.transform.velocity = Vector3:New(0, 0, 0)
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
        
        self.pos = self.gameObject.transform:GetPosition()
        self.gameObject.transform.velocity.y = self.gameObject.transform.velocity.y - (SF.physics.gravity/60)
        self.gameObject.transform:SetPosition(self.pos + self.gameObject.transform.velocity)
    end
end
