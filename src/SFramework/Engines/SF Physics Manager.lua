function Behavior:Awake()
    self.physicsObjects = {}
end

--[[
    Adds the given PhysicsObject to the manager's table of PhysicsObjects
    
    @param obj (required) the PhysicsObject to add
]]--
function Behavior:AddPhysicsObject(obj)
    table.insert(self.physicsObjects, obj)
end

--[[
    Removes the given PhysicsObject from the manager's table of PhysicsObjects
    
    @param obj (required) the PhysicsObject to remove
]]--
function Behavior:RemovePhysicsObject(obj)
    local i = table.indexOf(self.physicsObjects, obj)
    if i > 0 then
        table.remove(self.physicsObjects, i)
    end
end

--box vs box collision detection
function boxVBox(obj1, obj2)
    local p1 = obj1.transform:GetPosition()
    local p2 = obj2.transform:GetPosition()
    local uv1X = Vector3.Rotate(Vector3:Left(), obj1.transform:GetOrientation())
    local uv1Y = Vector3.Rotate(Vector3:Up(), obj1.transform:GetOrientation())
    local uv2X = Vector3.Rotate(Vector3:Left(), obj2.transform:GetOrientation())
    local uv2Y = Vector3.Rotate(Vector3:Up(), obj2.transform:GetOrientation())
    local r1X = uv1X*obj1.halfWidth
    local r1Y = uv1Y*obj1.halfHeight
    local r2X = uv2X*obj2.halfWidth
    local r2Y = uv2Y*obj2.halfHeight
    local t = p2 - p1
    
    local norm = nil
    local minD = math.huge
    
    local depth = math.abs(Vector3.Dot(t, uv1X)) - (math.abs(Vector3.Dot(r1X, uv1X)) + math.abs(Vector3.Dot(r1Y, uv1X)) + math.abs(Vector3.Dot(r2X, uv1X)) + math.abs(Vector3.Dot(r2Y, uv1X)))
    if depth > 0 then
        return nil
    else
        minD = math.abs(depth)
        if p1.x - p2.x < 0 then norm = uv1X else norm = -uv1X end
    end
    
    depth = math.abs(Vector3.Dot(t, uv1Y)) - (math.abs(Vector3.Dot(r1X, uv1Y)) + math.abs(Vector3.Dot(r1Y, uv1Y)) + math.abs(Vector3.Dot(r2X, uv1Y)) + math.abs(Vector3.Dot(r2Y, uv1Y)))
    if depth > 0 then
        return nil
    else
        if math.abs(depth) < minD then
            minD = math.abs(depth)
            if p1.y - p2.y > 0 then norm = uv1Y else norm = -uv1Y end
        end
    end
    
    depth = math.abs(Vector3.Dot(t, uv2X)) - (math.abs(Vector3.Dot(r1X, uv2X)) + math.abs(Vector3.Dot(r1Y, uv2X)) + math.abs(Vector3.Dot(r2X, uv2X)) + math.abs(Vector3.Dot(r2Y, uv2X)))
    if depth > 0 then
        return nil
    else
        if math.abs(depth) < minD then
            minD = math.abs(depth)
            if p1.x - p2.x < 0 then norm = uv2X else norm = -uv2X end
        end
    end
    
    depth = math.abs(Vector3.Dot(t, uv2Y)) - (math.abs(Vector3.Dot(r1X, uv2Y)) + math.abs(Vector3.Dot(r1Y, uv2Y)) + math.abs(Vector3.Dot(r2X, uv2Y)) + math.abs(Vector3.Dot(r2Y, uv2Y)))
    if depth > 0 then
        return nil
    else
        if math.abs(depth) < minD then
            minD = math.abs(depth)
            if p1.y - p2.y > 0 then norm = uv2Y else norm = -uv2Y end
        end
    end
    return {normal = norm, depth = minD}
end

--box vs circle collision detection
function boxVCircle(obj1, obj2)
    local box = nil
    local circle = nil
    if obj1.colliderType == 'BOX' then
        box = obj1
        circle = obj2
    else
        box = obj2
        circle = obj1
    end
    
    local boxPos = box.transform:GetPosition()
    local cirPos = circle.transform:GetPosition()
    local boxNormX = Vector3.Rotate(Vector3:Left(), box.transform:GetOrientation())
    local boxNormY = Vector3.Rotate(Vector3:Up(), box.transform:GetOrientation())
    local t = boxPos - cirPos
    
    local norm = nil
    local minD = math.huge
    
    local depth = math.abs(Vector3.Dot(t, boxNormX)) - (box.halfWidth + circle.halfWidth)
    if depth > 0 then
        return nil
    else
        minD = math.abs(depth)
        if circle.transform.velocity.x > 0 then norm = boxNormX else norm = -boxNormX end
    end
    
    depth = math.abs(Vector3.Dot(t, boxNormY)) - (box.halfHeight + circle.halfWidth)
    if depth > 0 then
        return nil
    else
        if math.abs(depth) < minD then
            minD = math.abs(depth)
            if circle.transform.velocity.y < 0 then norm = boxNormY else norm = -boxNormY end
        end
    end
    
    return {normal = norm, depth = minD}
end

--[[
    Gets the collision normal and depth of two objects
    
    @param obj1 (required) the first object to check
    @param obj2 (required) the second object to check
    
    @return a table containing the depth and normal of the collision, nil if no collision
]]--
function Behavior:GetCollisionData(obj1, obj2)
    if obj1.colliderType == obj2.colliderType then
        if obj1.colliderType == 'BOX' then
            return boxVBox(obj1, obj2)
        else
            return circleVCircle(obj1, obj2)
        end
    else
        
        return boxVCircle(obj1, obj2)
    end
end

--[[
    Resolved the collision between two objects using the provided data
    
    @param obj1 (required) the first object in the collision
    @param obj2 (required) the second object in the collision
    @param data (data) the collision data
]]--
function Behavior:ResolveCollision(obj1, obj2, data)
    local relativeVelocity = obj2.transform.velocity - obj1.transform.velocity
    local velProjected = Vector3.Dot(relativeVelocity, data.normal)
    
    if velProjected < 0 then return end
    
    local restitution = obj1.bounciness * obj2.bounciness
    local impulseMagnitude = (1+restitution) * velProjected
    impulseMagnitude = impulseMagnitude / (obj1.inverseMass + obj2.inverseMass)
    
    local impulse = data.normal * impulseMagnitude
    impulse.y = impulse.y + (SF.physics.gravity/60)
    obj1.transform.velocity = obj1.transform.velocity + (obj1.inverseMass*impulse)
    if math.abs(obj1.transform.velocity.y) <= .05 * SF.physics.gravity then obj1.transform.velocity.y = 0 end
    obj2.transform.velocity = obj2.transform.velocity - (obj2.inverseMass*impulse)
    if math.abs(obj2.transform.velocity.y) <= .05 * SF.physics.gravity then obj2.transform.velocity.y = 0 end
    
    obj1.transform:SetPosition(obj1.transform:GetPosition() + (data.normal * data.depth))
    obj1.transform:SetPosition(obj1.transform:GetPosition() + Vector3:New(0, .0002, 0))
end

function Behavior:Update()
    
end
