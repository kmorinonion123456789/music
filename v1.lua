local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local tweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateEmoteGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 100)
frame.Position = UDim2.new(0.5, -120, 0.85, -50)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BackgroundTransparency = 0.2
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 220, 0, 60)
button.Position = UDim2.new(0, 10, 0, 30)
button.Text = "ULTIMATE EMOTE"
button.Font = Enum.Font.SpecialElite
button.TextSize = 22
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
button.AutoButtonColor = true
button.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "SYSTEM ONLINE"
label.TextColor3 = Color3.fromRGB(0, 255, 255)
label.BackgroundTransparency = 1
label.Font = Enum.Font.Code
label.Parent = frame

local function createUltimateEffect()
    local att = Instance.new("Attachment", rootPart)
    
    local p1 = Instance.new("ParticleEmitter", att)
    p1.Texture = "rbxassetid://2430535539"
    p1.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0))
    p1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 15), NumberSequenceKeypoint.new(1, 0)})
    p1.Lifetime = NumberRange.new(0.8)
    p1.Rate = 200
    p1.Speed = NumberRange.new(30, 60)
    p1.SpreadAngle = Vector2.new(360, 360)
    
    local p2 = Instance.new("ParticleEmitter", att)
    p2.Texture = "rbxassetid://6030229329"
    p2.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    p2.Size = NumberSequence.new(5, 0)
    p2.Lifetime = NumberRange.new(1)
    p2.Rate = 50
    p2.Speed = NumberRange.new(5)
    p2.EmissionDirection = Enum.NormalId.Top
    
    task.wait(1.5)
    p1.Enabled = false
    p2.Enabled = false
    task.wait(1)
    att:Destroy()
end

local function cinematicCamera()
    local originalFieldOfView = camera.FieldOfView
    tweenService:Create(camera, TweenInfo.new(0.2), {FieldOfView = 40}):Play()
    
    for i = 1, 20 do
        local offset = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)) * 0.5
        humanoid.CameraOffset = offset
        task.wait(0.05)
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
    
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    label.Text = "EXECUTING..."
    label.TextColor3 = Color3.fromRGB(255, 0, 0)

    local s = Instance.new("Sound", rootPart)
    s.SoundId = "rbxassetid://157833037"
    s.Volume = 2
    s:Play()

    task.wait(0.5)
    
    local s2 = Instance.new("Sound", rootPart)
    s2.SoundId = "rbxassetid://142376088" 
    s2.Volume = 1
    s2:Play()

    task.spawn(createUltimateEffect)
    task.spawn(cinematicCamera)
    
    track:Play()
    track.TimePosition = 0.2
    track:AdjustSpeed(1.2)

    track.Stopped:Wait()
    
    label.Text = "READY"
    label.TextColor3 = Color3.fromRGB(0, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    cooldown = false
    s:Destroy()
    s2:Destroy()
end)
