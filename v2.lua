local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local tweenService = game:GetService("TweenService")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PhonkEmoteGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 100)
frame.Position = UDim2.new(0.5, -120, 0.85, -50)
frame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 220, 0, 60)
button.Position = UDim2.new(0, 10, 0, 30)
button.Text = "SUMMON THE PHONK"
button.Font = Enum.Font.LuckiestGuy -- 少し派手なフォントに
button.TextSize = 20
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(150, 0, 255) -- 紫（フォンクカラー）
button.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "PHONK STATUS: READY"
label.TextColor3 = Color3.fromRGB(200, 0, 255)
label.BackgroundTransparency = 1
label.Font = Enum.Font.Code
label.Parent = frame

local function createUltimateEffect()
    local att = Instance.new("Attachment", rootPart)
    
    
    local p1 = Instance.new("ParticleEmitter", att)
    p1.Texture = "rbxassetid://2430535539"
    p1.Color = ColorSequence.new(Color3.fromRGB(150, 0, 255), Color3.fromRGB(0, 255, 255))
    p1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 20), NumberSequenceKeypoint.new(1, 0)})
    p1.Lifetime = NumberRange.new(1)
    p1.Rate = 300
    p1.Speed = NumberRange.new(40, 80)
    p1.SpreadAngle = Vector2.new(360, 360)
    
    task.wait(2)
    p1.Enabled = false
    task.wait(1)
    att:Destroy()
end

local function cinematicCamera()
    local originalFieldOfView = camera.FieldOfView
    
    tweenService:Create(camera, TweenInfo.new(0.1, Enum.EasingStyle.Back), {FieldOfView = 50}):Play()
    
    for i = 1, 30 do
        local offset = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)) * 0.8
        humanoid.CameraOffset = offset
        task.wait(0.03)
    end
    
    humanoid.CameraOffset = Vector3.new(0,0,0)
    tweenService:Create(camera, TweenInfo.new(0.5), {FieldOfView = originalFieldOfView}):Play()
end


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://10714347743" 
local track = humanoid:LoadAnimation(anim)


local cooldown = false

button.MouseButton1Click:Connect(function()
    if cooldown then return end
    cooldown = true
    
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    label.Text = "SUMMONING..."

    
    
    local s = Instance.new("Sound", rootPart)
    s.SoundId = "rbxassetid://9043887091" 
    s.Volume = 2
    s.PlaybackSpeed = 0.9 
    s:Play()

    task.wait(0.8) 
    
    
    local s2 = Instance.new("Sound", rootPart)
    s2.SoundId = "rbxassetid://9043887091" 
    s2.TimePosition = 10 
    s2.Volume = 2.5
    s2:Play()

    task.spawn(createUltimateEffect)
    task.spawn(cinematicCamera)
    
    track:Play()
    track:AdjustSpeed(1.3) 

    track.Stopped:Wait()
    
    label.Text = "PHONK STATUS: READY"
    button.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    cooldown = false
    s:Destroy()
    s2:Destroy()
end)
