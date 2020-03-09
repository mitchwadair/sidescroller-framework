-- Copyright (c) 2020 Mitchell Adair
-- 
-- (https://github.com/mitchwadair)
--  
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

--[[
    Returns the sign of the given value
    
    @param value (required) the value to check
    
    @return 1 if positive, -1 if negative
]]--
function math.sign(value)
    if value < 0 then return -1 end
    return 1
end