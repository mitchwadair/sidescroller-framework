--[[PublicProperties
width number 1
height number 1
mass number 1
static boolean False
bounciness number 0.5
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
    
    self.gameObject.halfWidth = self.width/2
    self.gameObject.halfHeight = self.height/2
    self.gameObject.bounciness = self.bounciness
    
    self.pos = self.gameObject.transform:GetPosition()
    self.gameObject.velocity = Vector3:New(0, 0, 0)
end

function Behavior:Update()
    local manager = SF.physics.manager
    if not self.static then
        for i,v in ipairs(manager.physicsObjects) do
            if v ~= self.gameObject then
                local colliding = manager.isColliding(self.gameObject, v)
                if colliding then
                    manager.resolveCollision(self.gameObject, v)
                end
            end
        end
        
        self.pos = self.gameObject.transform:GetPosition()
        self.gameObject.velocity.y = self.gameObject.velocity.y - (SF.physics.gravity/60)
        self.gameObject.transform:SetPosition(self.pos + self.gameObject.velocity)
    end
end
