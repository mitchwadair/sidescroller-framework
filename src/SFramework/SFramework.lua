-- Copyright (c) 2020 Mitchell Adair
-- 
-- (https://github.com/mitchwadair)
--  
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

SF = {}

--
SF.physics = {}
SF.physics.manager = nil
SF.physics.gravity = 1 --the gravity in units/second

--[[
    Sets the gravity to the given value (in units/second)
    
    @param the gravity in units per second
]]--
SF.physics.setGravity = function(g)
    if g == nil then
        error("missing required argument 'g' in setGravity call")
        return
    end
    SF.physics.gravity = g
end

--[[
    Gets the gravity of SFramework's physics
    
    @return the gravity in units per second
]]--
SF.physics.getGravity = function()
    return SF.physics.gravity
end

--[[
    Returns the physics manager instance
    
    @return the instance of the SF Physics Manager
]]--
SF.physics.getPhysicsManager = function()
    return SF.physics.manager
end
