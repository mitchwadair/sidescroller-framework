--[[ Made by Mitchell Adair https://github.com/mitchwadair ]]--

--[[
    Returns the sign of the given value
    
    @param value (required) the value to check
    
    @return 1 if positive, -1 if negative
]]--
function math.sign(value)
    if value < 0 then return -1 end
    return 1
end