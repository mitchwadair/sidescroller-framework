function Behavior:Awake()
    local renderer = self.gameObject:CreateSpriteRenderer()
    --renderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle"), 6)
    --renderer:StartAnimationPlayback()
    
    SF.physics.setGravity(0)
end

function Behavior:Start()
    self.gameObject.physics:ApplyImpulse(Vector3:New(.1, .15, 0))
end

function Behavior:Update()
    --print(self.gameObject.transform.velocity.y) --:GetPosition().y)
end