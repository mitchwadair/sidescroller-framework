function Behavior:Awake()
    local renderer = self.gameObject:CreateSpriteRenderer()
    renderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle"), 6)
    renderer:StartAnimationPlayback()
end

function Behavior:Update()
    
end
