--[[ Made by Mitchell Adair https://github.com/mitchwadair ]]--

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