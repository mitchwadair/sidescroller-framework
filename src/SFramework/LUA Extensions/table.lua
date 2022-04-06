-- Copyright (c) 2020 Mitchell Adair
-- 
-- (https://github.com/mitchwadair)
--  
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

--[[
    Returns the index of a given object in the given table
    
    @param t (required) the table to check
    @param val (required) the value to find
    
    @return the index of the value or 0 if not found
]]--
function table.indexOf(t, val)
    for i,v in ipairs(t) do
        if v == val then
            return i
        end
    end
    return 0
end

--[[
    Returns the length of the given table
    
    @param t (required) the table to check
    
    @return the length of the table
]]--
function table.length(t)
    local len = #t
    if len ~= 0 then
        return len
    end
    for k,v in pairs(t) do
        len = len + 1
    end
    return len
end