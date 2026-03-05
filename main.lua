local p=game.Players.LocalPlayer
local u=game:GetService("UserInputService")
local r=game:GetService("RunService")
local ps=game:GetService("Players")
local c=workspace.CurrentCamera

-- フラグ
local f=false
local n=false
local e=false
local g=false
local tr=false
local w=false
local ij=false
local m=false

-- 設定
local s=50
local ws=16
local jp=50
local ds=150
local bg,bv

-- ESP用
local ef=Instance.new("Folder",p:WaitForChild("PlayerGui"))
ef.Name="ESP"

-- シンプルUI
local gui=Instance.new("ScreenGui")
local frame=Instance.new("Frame")
frame.Size=UDim2.new(0,200,0,200)
frame.Position=UDim2.new(0,10,0,10)
frame.BackgroundColor3=Color3.new(0,0,0)
frame.BackgroundTransparency=0.5
frame.Parent=gui
gui.Parent=p.PlayerGui

local tx={}
local names={"F:OFF","X:OFF","E:OFF","G:OFF","T:OFF","Y:OFF","I:OFF"}
for i=1,7 do
 tx[i]=Instance.new("TextLabel",frame)
 tx[i].Size=UDim2.new(1,0,0.14,0)
 tx[i].Position=UDim2.new(0,0,0,(i-1)*0.14)
 tx[i].Text=names[i]
 tx[i].TextColor3=Color3.new(1,0,0)
 tx[i].BackgroundTransparency=1
end

local function update()
 tx[1].Text=f and"F:ON"or"F:OFF"
 tx[1].TextColor3=f and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[2].Text=n and"X:ON"or"X:OFF"
 tx[2].TextColor3=n and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[3].Text=e and"E:ON"or"E:OFF"
 tx[3].TextColor3=e and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[4].Text=g and"G:ON"or"G:OFF"
 tx[4].TextColor3=g and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[5].Text=tr and"T:ON"or"T:OFF"
 tx[5].TextColor3=tr and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[6].Text=w and"Y:ON"or"Y:OFF"
 tx[6].TextColor3=w and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[7].Text=ij and"I:ON"or"I:OFF"
 tx[7].TextColor3=ij and Color3.new(0,1,0)or Color3.new(1,0,0)
end

-- ESP
local function createESP(pl)
 if pl==p then return end
 local function addESP(ch)
  if not ch then return end
  local rt=ch:FindFirstChild("HumanoidRootPart")
  if not rt then return end
  local bx=Instance.new("BoxHandleAdornment")
  bx.Size=Vector3.new(4,5,2)
  bx.Adornee=rt
  bx.AlwaysOnTop=true
  bx.ZIndex=10
  bx.Transparency=0.3
  bx.Color3=pl.TeamColor==p.TeamColor and Color3.new(0,1,0)or Color3.new(1,0,0)
  bx.Parent=ef
  local bl=Instance.new("BillboardGui")
  bl.Adornee=rt
  bl.Size=UDim2.new(0,100,0,30)
  bl.StudsOffset=Vector3.new(0,3,0)
  bl.AlwaysOnTop=true
  bl.Parent=ef
  local nl=Instance.new("TextLabel")
  nl.Size=UDim2.new(1,0,1,0)
  nl.BackgroundTransparency=1
  nl.Text=pl.Name
  nl.TextColor3=Color3.new(1,1,1)
  nl.TextStrokeTransparency=0.5
  nl.Parent=bl
 end
 if pl.Character then addESP(pl.Character)end
 pl.CharacterAdded:Connect(function(ch)task.wait()addESP(ch)end)
end

-- 各機能
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
  bv.Velocity=Vector3.new(0,0,0)
  bv.Parent=rt
 else
  if bg then bg:Destroy()end
  if bv then bv:Destroy()end
  h.PlatformStand=false
 end
 update()
end

local function toggleN()
 n=not n
 update()
end

local function toggleE()
 e=not e
 for _,v in pairs(ef:GetChildren())do v:Destroy()end
 if e then for _,pl in pairs(ps:GetPlayers())do createESP(pl)end end
 update()
end

local function toggleG()
 g=not g
 if g and p.Character then
  local h=p.Character:FindFirstChild("Humanoid")
  if h then h.MaxHealth=math.huge h.Health=math.huge h.BreakJointsOnDeath=false end
 end
 update()
end

local function toggleTR()
 tr=not tr
 if p.Character then
  for _,pt in pairs(p.Character:GetDescendants())do
   if pt:IsA("BasePart")or pt:IsA("MeshPart")then pt.Transparency=tr and 0.8 or 0 end
  end
 end
 update()
end

local function toggleW()
 w=not w
 for _,pl in pairs(ps:GetPlayers())do
  if pl~=p and pl.Character then
   for _,pt in pairs(pl.Character:GetDescendants())do
    if pt:IsA("BasePart")then pt.LocalTransparencyModifier=w and 0.7 or 0 end
   end
  end
 end
 update()
end

local function toggleIJ()
 ij=not ij
 update()
end

-- Noclip
r.Stepped:Connect(function()
 if n and p.Character then
  for _,pt in pairs(p.Character:GetChildren())do
   if pt:IsA("BasePart")then pt.CanCollide=false end
  end
 end
end)

-- 無限ジャンプ
r.Heartbeat:Connect(function()
 if ij and p.Character then
  local h=p.Character:FindFirstChild("Humanoid")
  if h and h:GetState()==Enum.HumanoidStateType.Jumping then
   h:ChangeState(Enum.HumanoidStateType.Jumping)
  end
 end
end)

-- 飛行
r.Heartbeat:Connect(function()
 if not f then return end
 local ch=p.Character
 if not ch then return end
 local rt=ch:FindFirstChild("HumanoidRootPart")
 if not rt or not bg or not bv then return end
 bg.CFrame=CFrame.lookAt(rt.Position,rt.Position+c.CFrame.LookVector)
 local md=Vector3.new()
 local cs= u:IsKeyDown(Enum.KeyCode.LeftShift)and ds or s
 if u:IsKeyDown(Enum.KeyCode.W)then md=md+c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.S)then md=md-c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.A)then md=md-c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.D)then md=md+c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.Space)then md=md+Vector3.new(0,1,0)end
 if u:IsKeyDown(Enum.KeyCode.LeftControl)then md=md+Vector3.new(0,-1,0)end
 bv.Velocity=md.Magnitude>0 and md.Unit*cs or Vector3.new()
end)

-- 速度適用
local function applyStats()
 if p.Character then
  local h=p.Character:FindFirstChild("Humanoid")
  if h then
   h.WalkSpeed=ws
   if h.UseJumpPower then h.JumpPower=jp else h.JumpHeight=jp/3 end
  end
 end
end

-- キー入力
u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if i.KeyCode==Enum.KeyCode.F then toggleF() end
 if i.KeyCode==Enum.KeyCode.X then toggleN() end
 if i.KeyCode==Enum.KeyCode.E then toggleE() end
 if i.KeyCode==Enum.KeyCode.G then toggleG() end
 if i.KeyCode==Enum.KeyCode.T then toggleTR() end
 if i.KeyCode==Enum.KeyCode.Y then toggleW() end
 if i.KeyCode==Enum.KeyCode.I then toggleIJ() end
 
 -- 速度調整
 if f then
  if i.KeyCode==Enum.KeyCode.Up then s=math.min(s+10,200)
  elseif i.KeyCode==Enum.KeyCode.Down then s=math.max(s-10,10)end
 end
 if i.KeyCode==Enum.KeyCode.Right then ws=math.min(ws+2,100)applyStats()
 elseif i.KeyCode==Enum.KeyCode.Left then ws=math.max(ws-2,1)applyStats()end
 if i.KeyCode==Enum.KeyCode.PageUp then jp=math.min(jp+5,200)applyStats()
 elseif i.KeyCode==Enum.KeyCode.PageDown then jp=math.max(jp-5,10)applyStats()end
end)

p.CharacterAdded:Connect(function()
 if f then f=false
  if bg then bg:Destroy()end
  if bv then bv:Destroy()end
 end
 applyStats()
 update()
end)

ps.PlayerAdded:Connect(function(pl)if e then createESP(pl)end end)
applyStats()
update()
