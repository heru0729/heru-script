local p=game.Players.LocalPlayer
local u=game:GetService("UserInputService")
local r=game:GetService("RunService")
local c=workspace.CurrentCamera

-- フラグ
local f=false
local n=false
local g=false
local bg,bv

-- シンプルUI
local gui=Instance.new("ScreenGui")
local frame=Instance.new("Frame")
frame.Size=UDim2.new(0,150,0,60)
frame.Position=UDim2.new(0,10,0,10)
frame.BackgroundColor3=Color3.new(0,0,0)
frame.BackgroundTransparency=0.5
frame.Parent=gui
gui.Parent=p:WaitForChild("PlayerGui")

local tx1=Instance.new("TextLabel",frame)
tx1.Size=UDim2.new(1,0,0.5,0)
tx1.Position=UDim2.new(0,0,0,0)
tx1.Text="F:OFF"
tx1.TextColor3=Color3.new(1,0,0)
tx1.BackgroundTransparency=1

local tx2=Instance.new("TextLabel",frame)
tx2.Size=UDim2.new(1,0,0.5,0)
tx2.Position=UDim2.new(0,0,0.5,0)
tx2.Text="X:OFF"
tx2.TextColor3=Color3.new(1,0,0)
tx2.BackgroundTransparency=1

local function update()
 tx1.Text=f and"F:ON"or"F:OFF"
 tx1.TextColor3=f and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx2.Text=n and"X:ON"or"X:OFF"
 tx2.TextColor3=n and Color3.new(0,1,0)or Color3.new(1,0,0)
end

-- 飛行
local function toggleF()
 f=not f
 local ch=p.Character
 if not ch then return end
 local h=ch:FindFirstChild("Humanoid")
 local rt=ch:FindFirstChild("HumanoidRootPart")
 if not h or not rt then return end
 if f then
  h.PlatformStand=true
  bg=Instance.new("BodyGyro")
  bg.MaxTorque=Vector3.new(9e9,9e9,9e9)
  bg.P=10000
  bg.Parent=rt
  bv=Instance.new("BodyVelocity")
  bv.MaxForce=Vector3.new(9e9,9e9,9e9)
  bv.Parent=rt
 else
  if bg then bg:Destroy()end
  if bv then bv:Destroy()end
  h.PlatformStand=false
 end
 update()
end

-- Noclip
local function toggleN()
 n=not n
 update()
end

r.Stepped:Connect(function()
 if n and p.Character then
  for _,pt in pairs(p.Character:GetChildren())do
   if pt:IsA("BasePart")then pt.CanCollide=false end
  end
 end
end)

-- 飛行移動
r.Heartbeat:Connect(function()
 if not f then return end
 local ch=p.Character
 if not ch then return end
 local rt=ch:FindFirstChild("HumanoidRootPart")
 if not rt or not bg or not bv then return end
 bg.CFrame=CFrame.lookAt(rt.Position,rt.Position+c.CFrame.LookVector)
 local md=Vector3.new()
 if u:IsKeyDown(Enum.KeyCode.W)then md=md+c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.S)then md=md-c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.A)then md=md-c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.D)then md=md+c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.Space)then md=md+Vector3.new(0,1,0)end
 if u:IsKeyDown(Enum.KeyCode.LeftControl)then md=md+Vector3.new(0,-1,0)end
 bv.Velocity=md.Magnitude>0 and md.Unit*50 or Vector3.new()
end)

-- Godmode
local function toggleG()
 g=not g
 if g and p.Character then
  local h=p.Character:FindFirstChild("Humanoid")
  if h then
   h.MaxHealth=math.huge
   h.Health=math.huge
   h.BreakJointsOnDeath=false
  end
 end
end

-- キー入力
u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if i.KeyCode==Enum.KeyCode.F then toggleF() end
 if i.KeyCode==Enum.KeyCode.X then toggleN() end
 if i.KeyCode==Enum.KeyCode.Q then toggleG() end
end)

p.CharacterAdded:Connect(function()
 if f then
  f=false
  if bg then bg:Destroy()end
  if bv then bv:Destroy()end
 end
 update()
end)

update()
print("起動完了 - F:飛行 X:Noclip Q:無敵")
