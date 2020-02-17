function Behavior:Awake()
    self.physicsObjects = {}
    self.stopThreshold = .05
    
    self.isColliding = function(obj1, obj2)
        local center1 = obj1.transform:GetPosition()
        local center2 = obj2.transform:GetPosition()
        if math.abs(center1.x - center2.x) > obj1.halfWidth + obj2.halfWidth then return nil end
        if math.abs(center1.y - center2.y) > obj1.halfHeight + obj2.halfHeight then return nil end
        return true
    end
    
    self.resolveCollision = function(obj1, obj2)
        local center1 = obj1.transform:GetPosition()
        local center2 = obj2.transform:GetPosition()
        local dx = (center1.x - center2.x)/obj2.halfWidth
        local dy = (center1.y - center2.y)/obj2.halfHeight
        
        if math.abs(math.abs(dx)-math.abs(dy)) < 0.1 then
            local x = 0
            local y = 0
            if dx < 0 then
                x = center2.x + obj2.halfWidth + obj1.halfWidth
            else
                x = center2.x - obj2.halfWidth - obj1.halfWidth
            end
            
            if dy < 0 then
                y = center2.y + obj2.halfHeight + obj1.halfHeight
            else
                y = center2.y - obj2.halfHeight - obj1.halfHeight
            end
            
            obj1.transform:SetPosition(Vector3:New(x, y, center1.z))
            
            if math.randomrange(0, 1) < .5 then
                obj1.velocity.x = -obj1.velocity.x * obj2.bounciness * obj1.bounciness
                if math.abs(obj1.velocity.x) < self.stopThreshold then
                    obj1.velocity.x = 0
                end
            else
                obj1.velocity.y = -obj1.velocity.y * obj2.bounciness * obj1.bounciness
                if math.abs(obj1.velocity.y) < self.stopThreshold then
                    obj1.velocity.y = 0
                end
            end
        elseif math.abs(dx) > math.abs(dy) then
            local x = 0
            if dx > 0 then
                x = center2.x + obj2.halfWidth + obj1.halfWidth
            else
                x = center2.x - obj2.halfWidth - obj1.halfWidth
            end
            obj1.transform:SetPosition(Vector3:New(x, center1.y, center1.z))
            
            obj1.velocity.x = -obj1.velocity.x * obj2.bounciness * obj1.bounciness
            
            if math.abs(obj1.velocity.x) < self.stopThreshold then
                obj1.velocity.x = 0
            end
        else
            local y = 0
            if dy > 0 then
                y = center2.y + obj2.halfHeight + obj1.halfHeight
            else
                y = center2.y - obj2.halfHeight - obj1.halfHeight
            end
            obj1.transform:SetPosition(Vector3:New(center1.x, y, center1.z))
            
            obj1.velocity.y = -(obj1.velocity.y - (SF.physics.gravity/60)) * obj2.bounciness * obj1.bounciness
            
            if math.abs(obj1.velocity.y) < self.stopThreshold then
                obj1.velocity.y = 0
            end
        end
    end
end

function Behavior:AddPhysicsObject(obj)
    table.insert(self.physicsObjects, obj)
end

function Behavior:RemovePhysicsObject(obj)
    local i = table.indexOf(self.physicsObjects, obj)
    if i > 0 then
        table.remove(self.physicsObjects, i)
    end
end

function Behavior:Update()
    
end
