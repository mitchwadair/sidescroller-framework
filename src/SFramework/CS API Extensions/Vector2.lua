Vector2 = {}
Vector2.__index = Vector3
setmetatable(Vector2, Vector3)

--[[
    Vector2 constructor
    
    This will gracefully create the Vector3 equivalent of the Vector2
    
    @return the Vector3 representation
]]--
function Vector2:New(x, y)
    return Vector3:New(x, y or x, 0)
end

--[[
    Overrides Vector3:Forward() to error on all calls
    Vector2 only cares about X and Y axes so this is irrelevant
]]--
function Vector2:Forward()
    error("Vector2 does not care about the Z axis")
end

--[[
    Overrides Vector3:UnitZ() to error on all calls
    Vector2 only cares about X and Y axes so this is irrelevant
]]--
function Vector2:UnitZ()
    error("Vector2 does not care about the Z axis")
end