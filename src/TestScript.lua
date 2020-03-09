function Behavior:Awake()
    local renderer = self.gameObject:CreateSpriteRenderer()
    renderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle"), 6)
    renderer:StartAnimationPlayback()
    
    SF.physics.setGravity(1)
end

function Behavior:Start()
    self.gameObject.physics:ApplyImpulse(Vector3:New(0, 0, 0))
end

function Behavior:Update()
    --self.gameObject.physics.velocity.x = -.1
    --print(self.gameObject.physics.velocity)
end