-- Copyright (c) 2020 Mitchell Adair
-- 
-- (https://github.com/mitchwadair)
--  
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

function Behavior:Awake()
    local offset = {
        x = self.gameObject.transform:GetPosition().x,
        y = self.gameObject.transform:GetPosition().y
    }
end

