function Behavior:Awake()
    local renderer = self.gameObject:CreateSpriteRenderer()
    --renderer:SetAnimation(CS.FindAsset("Sprites/Sample/Animations/Idle"), 6)
    --renderer:StartAnimationPlayback()
    
    SF.physics.setGravity(0)
end

function Behavior:Start()
    self.gameObject.transform.velocity.x = .1
    self.gameObject.transform.velocity.y = .15
    --CS.FindGameObject("Character 2").transform.velocity.x = -.05
end

function Behavior:Update()
    --print(self.gameObject.transform.velocity.y) --:GetPosition().y)
end