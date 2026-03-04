-- 指定された機能を削除したバージョン
-- 削除した機能: スクリプト検索, Discord連携, 音楽プレイヤー, サーバーホップ, Moderator検出, チャットスパイ

local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local ps = game:GetService("Players")

local flying = false
local noclip = false
local esp = false
local fling = false
local speed = 50
local walkSpeed = 16
local jumpPower = 50
local dashSpeed = 150
local bodyGyro = nil
local bodyVelocity = nil
local espFolder = Instance.new("Folder")
espFolder.Name = "ESP"
espFolder.Parent = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local speedText = Instance.new("TextLabel")
local walkSpeedText = Instance.new("TextLabel")
local jumpText = Instance.new("TextLabel")
local flyText = Instance.new("TextLabel")
local noclipText = Instance.new("TextLabel")
local espText = Instance.new("TextLabel")
local flingText = Instance.new("TextLabel")

frame.Size = UDim2.new(0, 200, 0, 210)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui

speedText.Size = UDim2.new(1, 0, 0.14, 0)
speedText.Position = UDim2.new(0, 0, 0, 0)
speedText.Text = "飛行速度: 50"
speedText.TextColor3 = Color3.new(1, 1, 1)
speedText.BackgroundTransparency = 1
speedText.Parent = frame

walkSpeedText.Size = UDim2.new(1, 0, 0.14, 0)
walkSpeedText.Position = UDim2.new(0, 0, 0.14, 0)
walkSpeedText.Text = "移動速度: 16"
walkSpeedText.TextColor3 = Color3.new(1, 1, 1)
walkSpeedText.BackgroundTransparency = 1
walkSpeedText.Parent = frame

jumpText.Size = UDim2.new(1, 0, 0.14, 0)
jumpText.Position = UDim2.new(0, 0, 0.28, 0)
jumpText.Text = "ジャンプ力: 50"
jumpText.TextColor3 = Color3.new(1, 1, 1)
jumpText.BackgroundTransparency = 1
jumpText.Parent = frame

flyText.Size = UDim2.new(1, 0, 0.14, 0)
flyText.Position = UDim2.new(0, 0, 0.42, 0)
flyText.Text = "飛行: OFF"
flyText.TextColor3 = Color3.new(1, 0, 0)
flyText.BackgroundTransparency = 1
flyText.Parent = frame

noclipText.Size = UDim2.new(1, 0, 0.14, 0)
noclipText.Position = UDim2.new(0, 0, 0.56, 0)
noclipText.Text = "Noclip: OFF"
noclipText.TextColor3 = Color3.new(1, 0, 0)
noclipText.BackgroundTransparency = 1
noclipText.Parent = frame

espText.Size = UDim2.new(1, 0, 0.14, 0)
espText.Position = UDim2.new(0, 0, 0.7, 0)
espText.Text = "ESP: OFF"
espText.TextColor3 = Color3.new(1, 0, 0)
espText.BackgroundTransparency = 1
espText.Parent = frame

flingText.Size = UDim2.new(1, 0, 0.14, 0)
flingText.Position = UDim2.new(0, 0, 0.84, 0)
flingText.Text = "Fling: OFF"
flingText.TextColor3 = Color3.new(1, 0, 0)
flingText.BackgroundTransparency = 1
flingText.Parent = frame

screenGui.Parent = player:WaitForChild("PlayerGui")

local function createESP(plr)
    if plr == player then return end
    local function addESP(character)
        if not character then return end
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local box = Instance.new("BoxHandleAdornment")
        box.Name = plr.Name.."_ESP"
        box.Size = Vector3.new(4, 5, 2)
        box.Adornee = root
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Transparency = 0.3
        box.Color3 = plr.TeamColor == player.TeamColor and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        box.Parent = espFolder
        local billboard = Instance.new("BillboardGui")
        billboard.Name = plr.Name.."_Name"
        billboard.Adornee = root
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = espFolder
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Parent = billboard
    end
    if plr.Character then addESP(plr.Character) end
    plr.CharacterAdded:Connect(function(char) task.wait() addESP(char) end)
end

local function toggleESP()
    esp = not esp
    espText.Text = esp and "ESP: ON" or "ESP: OFF"
    espText.TextColor3 = esp and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    for _, v in pairs(espFolder:GetChildren()) do v:Destroy() end
    if esp then for _, plr in pairs(ps:GetPlayers()) do createESP(plr) end end
end

local function toggleNoclip()
    noclip = not noclip
    noclipText.Text = noclip and "Noclip: ON" or "Noclip: OFF"
    noclipText.TextColor3 = noclip and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
end

rs.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

local function toggleFling()
    fling = not fling
    flingText.Text = fling and "Fling: ON" or "Fling: OFF"
    flingText.TextColor3 = fling and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
end

rs.Heartbeat:Connect(function()
    if fling and player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, otherPlayer in pairs(ps:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    local otherRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if otherRoot and (otherRoot.Position - root.Position).Magnitude < 30 then
                        local direction = (otherRoot.Position - root.Position).Unit
                        otherRoot.Velocity = direction * 200 + Vector3.new(0, 100, 0)
                        otherRoot.RotVelocity = Vector3.new(100, 100, 100)
                    end
                end
            end
        end
    end
end)

local function applyStats()
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeed
            if humanoid.UseJumpPower then humanoid.JumpPower = jumpPower else humanoid.JumpHeight = jumpPower / 3 end
        end
    end
end

local function toggleFly()
    flying = not flying
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    if flying then
        humanoid.PlatformStand = true
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.P = 10000
        bodyGyro.Parent = rootPart
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        flyText.Text = "飛行: ON"
        flyText.TextColor3 = Color3.new(0, 1, 0)
    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        humanoid.PlatformStand = false
        flyText.Text = "飛行: OFF"
        flyText.TextColor3 = Color3.new(1, 0, 0)
    end
end

rs.Heartbeat:Connect(function()
    if not flying then return end
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart or not bodyGyro or not bodyVelocity then return end
    bodyGyro.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + camera.CFrame.LookVector)
    local moveDirection = Vector3.new()
    local currentSpeed = speed
    if uis:IsKeyDown(Enum.KeyCode.LeftShift) then currentSpeed = dashSpeed end
    if uis:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camera.CFrame.LookVector end
    if uis:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camera.CFrame.LookVector end
    if uis:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camera.CFrame.RightVector end
    if uis:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camera.CFrame.RightVector end
    if uis:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
    if uis:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection + Vector3.new(0, -1, 0) end
    if moveDirection.Magnitude > 0 then bodyVelocity.Velocity = moveDirection.Unit * currentSpeed else bodyVelocity.Velocity = Vector3.new(0, 0, 0) end
end)

uis.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then toggleFly() end
    if input.KeyCode == Enum.KeyCode.X then toggleNoclip() end
    if input.KeyCode == Enum.KeyCode.E then toggleESP() end
    if input.KeyCode == Enum.KeyCode.G then toggleFling() end
    if flying then
        if input.KeyCode == Enum.KeyCode.Up then speed = math.min(speed + 10, 200) speedText.Text = "飛行速度: "..speed
        elseif input.KeyCode == Enum.KeyCode.Down then speed = math.max(speed - 10, 10) speedText.Text = "飛行速度: "..speed end
    end
    if input.KeyCode == Enum.KeyCode.Right then walkSpeed = math.min(walkSpeed + 2, 100) walkSpeedText.Text = "移動速度: "..walkSpeed applyStats()
    elseif input.KeyCode == Enum.KeyCode.Left then walkSpeed = math.max(walkSpeed - 2, 1) walkSpeedText.Text = "移動速度: "..walkSpeed applyStats() end
    if input.KeyCode == Enum.KeyCode.PageUp then jumpPower = math.min(jumpPower + 5, 200) jumpText.Text = "ジャンプ力: "..jumpPower applyStats()
    elseif input.KeyCode == Enum.KeyCode.PageDown then jumpPower = math.max(jumpPower - 5, 10) jumpText.Text = "ジャンプ力: "..jumpPower applyStats() end
end)

player.CharacterAdded:Connect(function()
    if flying then
        flying = false
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        flyText.Text = "飛行: OFF"
        flyText.TextColor3 = Color3.new(1, 0, 0)
    end
    applyStats()
end)

ps.PlayerAdded:Connect(function(plr) if esp then createESP(plr) end end)
applyStats()
