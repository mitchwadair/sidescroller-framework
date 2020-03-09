--[[ Made by Mitchell Adair https://github.com/mitchwadair ]]--

function Behavior:Awake()
    self.physicsObjects = {}
end

--[[
    Adds the given PhysicsObject to the manager's table of PhysicsObjects
    
    @param obj (required) the PhysicsObject to add
]]--
function Behavior:AddPhysicsObject(obj)
    if obj == nil then
        error("missing required argument 'obj' in AddPhysicsObject call")
        return
    end

    table.insert(self.physicsObjects, obj)
end

--[[
    Removes the given PhysicsObject from the manager's table of PhysicsObjects
    
    @param obj (required) the PhysicsObject to remove
]]--
function Behavior:RemovePhysicsObject(obj)
    if obj == nil then
        error("missing required argument 'obj' in RemovePhysicsObject call")
        return
    end
    
    local i = table.indexOf(self.physicsObjects, obj)
    if i > 0 then
        table.remove(self.physicsObjects, i)
    end
end

function getCornersOfOBB(obj)
    if obj.physics.colliderType == 'TRIANGLE' then
        return getCornersOfTriangle(obj)
    end
    
    local corners = {}
    local p = obj.transform:GetPosition()
    local o = obj.transform:GetOrientation()
    corners.topLeft = p + Vector3.Rotate(Vector3:New(p.x - obj.physics.halfWidth, p.y + obj.physics.halfHeight, 0) - p, o)
    corners.topRight = p + Vector3.Rotate(Vector3:New(p.x + obj.physics.halfWidth, p.y + obj.physics.halfHeight, 0) - p, o)
    corners.bottomLeft = p + Vector3.Rotate(Vector3:New(p.x - obj.physics.halfWidth, p.y - obj.physics.halfHeight, 0) - p, o)
    corners.bottomRight = p + Vector3.Rotate(Vector3:New(p.x + obj.physics.halfWidth, p.y - obj.physics.halfHeight, 0) - p, o)
    return corners
end

function getCornersOfTriangle(obj)
    local corners = {}
    local p = obj.transform:GetPosition()
    local o = obj.transform:GetOrientation()
    corners.topRight = p + Vector3.Rotate(Vector3:New(p.x + obj.physics.halfWidth, p.y + obj.physics.halfHeight, 0) - p, o)
    corners.bottomLeft = p + Vector3.Rotate(Vector3:New(p.x - obj.physics.halfWidth, p.y - obj.physics.halfHeight, 0) - p, o)
    corners.bottomRight = p + Vector3.Rotate(Vector3:New(p.x + obj.physics.halfWidth, p.y - obj.physics.halfHeight, 0) - p, o)
    return corners
end

function getAxesOfOBB(c)
    local axes = {}
    axes[1] = (c.bottomRight - c.topRight):Normalized()
    axes[2] = (c.bottomRight - c.bottomLeft):Normalized()
    if table.length(c) == 3 then
        axes[3] = Vector3.Cross((c.bottomLeft - c.topRight):Normalized(), -Vector3:Forward())
    else
        axes[3] = (c.topLeft - c.bottomLeft):Normalized()
        axes[4] = (c.topLeft - c.topRight):Normalized()
    end
    return axes
end

function getMinMax(c, a)
    local minMax = {}
    local min = math.huge
    local max = -math.huge
    for k,corner in pairs(c) do
        local p = Vector3.Dot(corner, a)
        if p < min then 
            min = p
            minMax.min = corner
        end
        if p > max then
            max = p
            minMax.max = corner
        end
    end
    return minMax
end

--box vs box collision detection
function OBBvOBB(obj1, obj2)
    local obj1Corners = getCornersOfOBB(obj1)
    local obj2Corners = getCornersOfOBB(obj2)
    
    local axes = getAxesOfOBB(obj1Corners)
    for i,axis in ipairs(getAxesOfOBB(obj2Corners)) do
        if table.indexOf(axes, axis) == 0 then
            table.insert(axes, axis)
        end
    end
    
    local minDepth = math.huge
    local norm = nil
    for i,a in ipairs(axes) do
        local minMax1 = getMinMax(obj1Corners, a)
        local minMax2 = getMinMax(obj2Corners, a)
        local min1Proj = Vector3.Dot(minMax1.min, a)
        local max1Proj = Vector3.Dot(minMax1.max, a)
        local min2Proj = Vector3.Dot(minMax2.min, a)
        local max2Proj = Vector3.Dot(minMax2.max, a)
        if max2Proj < min1Proj then
            return nil
        else
            local d = math.abs(max2Proj - min1Proj)
            if d < minDepth then
                minDepth = d
                norm = a
            end
        end
    end
    return {depth = minDepth, normal = norm}
end

function getCircleMinMax(c, a)
    local minMax = {}
    local pos = c.transform:GetPosition()
    local side1 = a * c.physics.halfWidth
    local side2 = a * -c.physics.halfWidth
    local min = math.huge
    local max = -math.huge
    local p = Vector3.Dot(side1, a)
    if p < min then
        min = p
        minMax.min = pos + side1
    end
    if p > max then
        max = p
        minMax.max = pos + side1
    end
    p = Vector3.Dot(side2, a)
    if p < min then
        min = p
        minMax.min = pos + side2
    end
    if p > max then
        max = p
        minMax.max = pos + side2
    end
    return minMax
end

--box vs circle collision detection
function OBBvCircle(obj1, obj2)
    local circle = obj1
    local box = obj2
    if obj1.physics.colliderType == 'BOX' or obj1.physics.colliderType == 'TRIANGLE' then
        box = obj1
        circle = obj2
    end
    
    local cirPos = circle.transform:GetPosition()
    local boxPos = box.transform:GetPosition()
    local t = cirPos - boxPos
    local boxCorners = getCornersOfOBB(box)
    local axes = getAxesOfOBB(boxCorners)
    table.insert(axes, t:Normalized())
    
    local minDepth = math.huge
    local norm = nil
    for i,a in ipairs(axes) do
        local minMax1 = getMinMax(boxCorners, a)
        local minMax2 = getCircleMinMax(circle, a)
        local min1Proj = Vector3.Dot(minMax1.min, a)
        local max1Proj = Vector3.Dot(minMax1.max, a)
        local min2Proj = Vector3.Dot(minMax2.min, a)
        local max2Proj = Vector3.Dot(minMax2.max, a)
        if max2Proj < min1Proj then
            return nil
        else
            local d = math.abs(max2Proj - min1Proj)
            if d < minDepth then
                minDepth = d
                norm = a
            end
        end
        if max1Proj < min2Proj then
            return nil
        else
            local d = math.abs(max1Proj - min2Proj)
            if d < minDepth then
                minDepth = d
                norm = -a
            end
        end
    end
    if obj1.physics.colliderType == 'CIRCLE' then
        norm = -norm
    end
    return {depth = minDepth, normal = norm}
end

function getSqDist(v1, v2)
    return ((v2.x - v1.x) * (v2.x - v1.x)) + ((v2.y - v1.y) * (v2.y - v1.y))
end

-- circle vs circle collision detection
function circleVCircle(obj1, obj2)
    local p1 = obj1.transform:GetPosition()
    local p2 = obj2.transform:GetPosition()
    local dist = getSqDist(p1, p2)
    local depth = dist - (obj1.physics.halfWidth + obj2.physics.halfWidth)
    if depth < 0 then
        return {depth = depth, normal = p1 - p2}
    end
    return nil
end

--[[
    Gets the collision normal and depth of two objects
    
    @param obj1 (required) the first object to check
    @param obj2 (required) the second object to check
    
    @return a table containing the depth and normal of the collision, nil if no collision
]]--
function Behavior:GetCollisionData(obj1, obj2)
    if obj1 == nil then
        error("missing required argument 'obj1' in GetCollisionData call")
        return
    elseif obj2 == nil then
        error("missing required argument 'obj2' in GetCollisionData call")
        return
    end
    
    if (obj1.physics.colliderType == 'BOX' or obj1.physics.colliderType == 'TRIANGLE') and (obj2.physics.colliderType == 'BOX' or obj2.physics.colliderType == 'TRIANGLE') then
        return OBBvOBB(obj1, obj2)
    else
        if obj1.physics.colliderType == obj2.physics.colliderType then
            return circleVCircle(obj1, obj2)
        end
        return OBBvCircle(obj1, obj2)
    end
end

--[[
    Resolved the collision between two objects using the provided data
    
    @param obj1 (required) the first object in the collision
    @param obj2 (required) the second object in the collision
    @param data (data) the collision data
]]--
function Behavior:ResolveCollision(obj1, obj2, data)
    if obj1 == nil then
        error("missing required argument 'obj1' in ResolveCollision call")
        return
    elseif obj2 == nil then
        error("missing required argument 'obj2' in ResolveCollision call")
        return
    elseif data == nil then
        error("missing required argument 'data' in ResolveCollision call")
        return
    end

    local relativeVelocity = obj2.physics.velocity - obj1.physics.velocity
    local velProjected = Vector3.Dot(relativeVelocity, data.normal)
    
    if velProjected < -.0005 then return end
    
    local restitution = obj1.physics.bounciness * obj2.physics.bounciness
    local impulseMagnitude = (1+restitution) * velProjected
    impulseMagnitude = impulseMagnitude / (obj1.physics.inverseMass + obj2.physics.inverseMass)
    
    local impulse = data.normal * impulseMagnitude
    local frictionCoeff = obj1.physics.friction * obj2.physics.friction
    local friction = Vector3:New(data.normal.y * frictionCoeff, data.normal.x * frictionCoeff, 0)/60
    obj1.physics.velocity = obj1.physics.velocity + (obj1.physics.inverseMass*impulse) - (friction*obj1.physics.inverseMass*Vector3:New(math.sign(obj1.physics.velocity.x), math.sign(obj1.physics.velocity.y), 0))
    if math.abs(obj1.physics.velocity.y) <= .05 * SF.physics.gravity then obj1.physics.velocity.y = 0 end
    if math.abs(obj1.physics.velocity.x) <= .02 then obj1.physics.velocity.x = 0 end
    obj2.physics.velocity = obj2.physics.velocity - (obj2.physics.inverseMass*impulse) + (friction*obj2.physics.inverseMass*Vector3:New(math.sign(obj2.physics.velocity.x), math.sign(obj2.physics.velocity.y), 0))
    if math.abs(obj2.physics.velocity.y) <= .05 * SF.physics.gravity then obj2.physics.velocity.y = 0 end
    if math.abs(obj2.physics.velocity.x) <= .02 then obj2.physics.velocity.x = 0 end
    
    obj1.transform:SetPosition(obj1.transform:GetPosition() + (data.normal * data.depth))
    obj1.transform:SetPosition(obj1.transform:GetPosition() + Vector3:New(0, .0002, 0))
end

function Behavior:Update()
    
end
