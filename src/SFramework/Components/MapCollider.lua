function Behavior:Awake()
    local offset = {
        x = self.gameObject.transform:GetPosition().x,
        y = self.gameObject.transform:GetPosition().y
    }
end

