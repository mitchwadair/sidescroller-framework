function Behavior:Awake()
    local renderer = self.gameObject:CreateSpriteRenderer()
    --renderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle"), 6)
    --renderer:StartAnimationPlayback()
    
    SF.physics.setGravity(1)
    self.setVel = false
    self.max = 0
end

function Behavior:Update()
    if not self.setVel then
        self.gameObject.velocity.x = .05
        self.setVel = true
    end
end