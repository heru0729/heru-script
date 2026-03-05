local p=game.Players.LocalPlayer
local u=game:GetService("UserInputService")
local r=game:GetService("RunService")
local ps=game:GetService("Players")
local c=workspace.CurrentCamera

-- 全部最初はOFF
local f=false
local n=false
local e=false
local fl=false
local g=false
local a=false

-- 設定
local s=50
local ws=16
local j=50
local ds=150
local bg,bv

-- ESP用
local ef=Instance.new("Folder",p:WaitForChild("PlayerGui"))
ef.Name="ESP"

-- シンプルなUI（画面左上に小さく表示）
local gui=Instance.new("ScreenGui")
local fr=Instance.new("Frame")
local tx={}

fr.Size=UDim2.new(0,150,0,140)
fr.Position=UDim2.new(0,5,0,5)
fr.BackgroundColor3=Color3.new(0,0,0)
fr.BackgroundTransparency=0.6
fr.BorderSizePixel=0
fr.Parent=gui
gui.Parent=p.PlayerGui

local y=0
for i,v in pairs({"F:OFF","N:OFF","E:OFF","FL:OFF","G:OFF","A:OFF"})do
 tx[i]=Instance.new("TextLabel")
 tx[i].Size=UDim2.new(1,0,0.16,0)
 tx[i].Position=UDim2.new(0,0,0,y)
 tx[i].Text=v
 tx[i].TextColor3=Color3.new(1,1,1)
 tx[i].TextSize=14
 tx[i].Font=Enum.Font.GothamBold
 tx[i].BackgroundTransparency=1
 tx[i].Parent=fr
 y=y+0.16
end

local function up()
 tx[1].Text="F:"..(f and"ON"or"OFF")
 tx[1].TextColor3=f and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[2].Text="N:"..(n and"ON"or"OFF")
 tx[2].TextColor3=n and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[3].Text="E:"..(e and"ON"or"OFF")
 tx[3].TextColor3=e and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[4].Text="FL:"..(fl and"ON"or"OFF")
 tx[4].TextColor3=fl and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[5].Text="G:"..(g and"ON"or"OFF")
 tx[5].TextColor3=g and Color3.new(0,1,0)or Color3.new(1,0,0)
 tx[6].Text="A:"..(a and"ON"or"OFF")
 tx[6].TextColor3=a and Color3.new(0,1,0)or Color3.new(1,0,0)
end
up()

-- ESP
local function cESP(pl)
 if pl==p then return end
 local function aESP(ch)
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
 if pl.Character then aESP(pl.Character)end
 pl.CharacterAdded:Connect(function(ch)task.wait()aESP(ch)end)
end

local function tE()
 e=not e
 for _,v in pairs(ef:GetChildren())do v:Destroy()end
 if e then for _,pl in pairs(ps:GetPlayers())do cESP(pl)end end
 up()
end

local function tN()
 n=not n
 up()
end

r.Stepped:Connect(function()
 if n and p.Character then
  for _,pt in pairs(p.Character:GetChildren())do
   if pt:IsA("BasePart")then pt.CanCollide=false end
  end
 end
end)

local function tFl()
 fl=not fl
 up()
end

local function tG()
 g=not g
 if g and p.Character then
  local h=p.Character:FindFirstChild("Humanoid")
  if h then
   h.MaxHealth=math.huge
   h.Health=math.huge
   h.BreakJointsOnDeath=false
  end
 end
 up()
end

local function tA()
 a=not a
 up()
end

local function gCP()
 local cd=100
 local cp,pt
 if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart")then return nil,nil end
 local mp=p.Character.HumanoidRootPart.Position
 for _,pl in pairs(ps:GetPlayers())do
  if pl~=p and pl.Character and pl.Character:FindFirstChild("Humanoid")and pl.Character.Humanoid.Health>0 then
   local tp=pl.Character:FindFirstChild("Head")or pl.Character:FindFirstChild("HumanoidRootPart")
   if tp then
    local d=(tp.Position-mp).Magnitude
    if d<cd then cd=d cp=pl pt=tp end
   end
  end
 end
 return cp,pt
end

r.RenderStepped:Connect(function()
 if a and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
  local tp,pt=gCP()
  if tp and pt then
   local cf=c.CFrame
   local lc=CFrame.lookAt(cf.Position,pt.Position)
   c.CFrame=cf:Lerp(lc,0.5)
  end
 end
end)

r.Heartbeat:Connect(function()
 if fl and p.Character then
  local rt=p.Character:FindFirstChild("HumanoidRootPart")
  if rt then
   for _,op in pairs(ps:GetPlayers())do
    if op~=p and op.Character then
     local ort=op.Character:FindFirstChild("HumanoidRootPart")
     if ort and(ort.Position-rt.Position).Magnitude<30 then
      local d=(ort.Position-rt.Position).Unit
      ort.Velocity=d*200+Vector3.new(0,100,0)
      ort.RotVelocity=Vector3.new(100,100,100)
     end
    end
   end
  end
 end
end)

local function tF()
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
 up()
end

r.Heartbeat:Connect(function()
 if not f then return end
 local ch=p.Character
 if not ch then return end
 local rt=ch:FindFirstChild("HumanoidRootPart")
 if not rt or not bg or not bv then return end
 bg.CFrame=CFrame.lookAt(rt.Position,rt.Position+c.CFrame.LookVector)
 local md=Vector3.new()
 local cs=s
 if u:IsKeyDown(Enum.KeyCode.LeftShift)then cs=ds end
 if u:IsKeyDown(Enum.KeyCode.W)then md=md+c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.S)then md=md-c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.A)then md=md-c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.D)then md=md+c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.Space)then md=md+Vector3.new(0,1,0) end
 if u:IsKeyDown(Enum.KeyCode.LeftControl)then md=md+Vector3.new(0,-1,0) end
 if md.Magnitude>0 then bv.Velocity=md.Unit*cs else bv.Velocity=Vector3.new(0,0,0) end
end)

local function aS()
 if p.Character then
  local h=p.Character:FindFirstChild("Humanoid")
  if h then
   h.WalkSpeed=ws
   if h.UseJumpPower then h.JumpPower=j else h.JumpHeight=j/3 end
  end
 end
end

u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if i.KeyCode==Enum.KeyCode.F then tF()end
 if i.KeyCode==Enum.KeyCode.X then tN()end
 if i.KeyCode==Enum.KeyCode.E then tE()end
 if i.KeyCode==Enum.KeyCode.G then tFl()end
 if i.KeyCode==Enum.KeyCode.Q then tG()end
 if i.KeyCode==Enum.KeyCode.R then tA()end
 if f then
  if i.KeyCode==Enum.KeyCode.Up then s=math.min(s+10,200)up()
  elseif i.KeyCode==Enum.KeyCode.Down then s=math.max(s-10,10)up()end
 end
 if i.KeyCode==Enum.KeyCode.Right then ws=math.min(ws+2,100)up()aS()
 elseif i.KeyCode==Enum.KeyCode.Left then ws=math.max(ws-2,1)up()aS()end
 if i.KeyCode==Enum.KeyCode.PageUp then j=math.min(j+5,200)up()aS()
 elseif i.KeyCode==Enum.KeyCode.PageDown then j=math.max(j-5,10)up()aS()end
end)

p.CharacterAdded:Connect(function()
 if f then f=false
  if bg then bg:Destroy()end
  if bv then bv:Destroy()end
 end
 aS()up()
end)

ps.PlayerAdded:Connect(function(pl)if e then cESP(pl)end end)
aS()up()
