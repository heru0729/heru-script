local p=game.Players.LocalPlayer
local u=game:GetService("UserInputService")
local r=game:GetService("RunService")
local ps=game:GetService("Players")
local c=workspace.CurrentCamera
local ts=game:GetService("TeleportService")
local hs=game:GetService("HttpService")
local tween=game:GetService("TweenService")

-- 全部最初はOFF
local f=false
local n=false
local e=false
local fl=false
local g=false
local a=false
local m=false

local s=50
local ws=16
local j=50
local ds=150
local bg,bv

local ef=Instance.new("Folder",p:WaitForChild("PlayerGui"))
ef.Name="ESP"

-- モダンUI
local gui=Instance.new("ScreenGui")
gui.Name="ModernHub"
gui.Enabled=false
gui.Parent=p.PlayerGui

local bgFrame=Instance.new("Frame")
bgFrame.Size=UDim2.new(0,350,0,400)
bgFrame.Position=UDim2.new(0.5,-175,0.5,-200)
bgFrame.BackgroundColor3=Color3.fromRGB(15,15,15)
bgFrame.BackgroundTransparency=0.1
bgFrame.BorderSizePixel=0
bgFrame.Parent=gui

local uc=Instance.new("UICorner")
uc.CornerRadius=UDim.new(0,12)
uc.Parent=bgFrame

local us=Instance.new("UIStroke")
us.Thickness=1
us.Color=Color3.fromRGB(80,80,80)
us.Transparency=0.5
us.Parent=bgFrame

local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,0,0,40)
title.Position=UDim2.new(0,0,0,0)
title.BackgroundTransparency=1
title.Text="MODERN HUB"
title.TextColor3=Color3.fromRGB(220,220,220)
title.TextSize=18
title.Font=Enum.Font.GothamBold
title.Parent=bgFrame

local line=Instance.new("Frame")
line.Size=UDim2.new(1,-30,0,1)
line.Position=UDim2.new(0,15,0,45)
line.BackgroundColor3=Color3.fromRGB(100,100,100)
line.BackgroundTransparency=0.7
line.BorderSizePixel=0
line.Parent=bgFrame

local grid=Instance.new("Frame")
grid.Size=UDim2.new(1,-20,1,-70)
grid.Position=UDim2.new(0,10,0,55)
grid.BackgroundTransparency=1
grid.Parent=bgFrame

local layout=Instance.new("UIGridLayout")
layout.CellSize=UDim2.new(0,95,0,70)
layout.CellPadding=UDim2.new(0,8,0,8)
layout.FillDirection=Enum.FillDirection.Horizontal
layout.HorizontalAlignment=Enum.HorizontalAlignment.Center
layout.Parent=grid

local buttons={}
local names={"FLIGHT","NOCLIP","ESP","FLING","GOD","AIM"}
local keys={"F","X","E","G","Q","R"}
local colors={Color3.fromRGB(0,150,255),Color3.fromRGB(0,200,100),Color3.fromRGB(255,180,0),Color3.fromRGB(255,80,80),Color3.fromRGB(200,0,255),Color3.fromRGB(255,100,0)}

for i=1,6 do
 local btn=Instance.new("Frame")
 btn.Name=names[i]
 btn.BackgroundColor3=colors[i]
 btn.BackgroundTransparency=0.8
 btn.BorderSizePixel=0
 btn.Parent=grid
 
 local btnUc=Instance.new("UICorner")
 btnUc.CornerRadius=UDim.new(0,8)
 btnUc.Parent=btn
 
 local icon=Instance.new("TextLabel")
 icon.Size=UDim2.new(1,0,0,30)
 icon.Position=UDim2.new(0,0,0,5)
 icon.BackgroundTransparency=1
 icon.Text=names[i]:sub(1,1)
 icon.TextColor3=colors[i]
 icon.TextSize=24
 icon.Font=Enum.Font.GothamBold
 icon.Parent=btn
 
 local nameLbl=Instance.new("TextLabel")
 nameLbl.Size=UDim2.new(1,0,0,20)
 nameLbl.Position=UDim2.new(0,0,0,35)
 nameLbl.BackgroundTransparency=1
 nameLbl.Text=names[i]
 nameLbl.TextColor3=Color3.fromRGB(200,200,200)
 nameLbl.TextSize=12
 nameLbl.Font=Enum.Font.GothamMedium
 nameLbl.Parent=btn
 
 local status=Instance.new("TextLabel")
 status.Size=UDim2.new(1,0,0,15)
 status.Position=UDim2.new(0,0,0,55)
 status.BackgroundTransparency=1
 status.Text="OFF"
 status.TextColor3=Color3.fromRGB(150,150,150)
 status.TextSize=10
 status.Font=Enum.Font.GothamBold
 status.Parent=btn
 
 local btnBtn=Instance.new("TextButton")
 btnBtn.Size=UDim2.new(1,0,1,0)
 btnBtn.BackgroundTransparency=1
 btnBtn.Text=""
 btnBtn.Parent=btn
 
 table.insert(buttons,{btn,status,btnBtn,names[i]})
end

local closeBtn=Instance.new("TextButton")
closeBtn.Size=UDim2.new(0,30,0,30)
closeBtn.Position=UDim2.new(1,-35,0,5)
closeBtn.BackgroundTransparency=1
closeBtn.Text="✕"
closeBtn.TextColor3=Color3.fromRGB(200,200,200)
closeBtn.TextSize=18
closeBtn.Font=Enum.Font.GothamBold
closeBtn.Parent=bgFrame

local menuBtn=Instance.new("TextButton")
menuBtn.Size=UDim2.new(0,50,0,50)
menuBtn.Position=UDim2.new(0,20,1,-70)
menuBtn.BackgroundColor3=Color3.fromRGB(30,30,30)
menuBtn.Text="MENU"
menuBtn.TextColor3=Color3.fromRGB(200,200,200)
menuBtn.TextSize=14
menuBtn.Font=Enum.Font.GothamBold
menuBtn.Parent=gui

local menuUc=Instance.new("UICorner")
menuUc.CornerRadius=UDim.new(0,25)
menuUc.Parent=menuBtn

local menuStroke=Instance.new("UIStroke")
menuStroke.Thickness=1
menuStroke.Color=Color3.fromRGB(80,80,80)
menuStroke.Parent=menuBtn

local function updateUI()
 for i=1,6 do
  local val=i==1 and f or i==2 and n or i==3 and e or i==4 and fl or i==5 and g or a
  buttons[i][2].Text=val and"ON"or"OFF"
  buttons[i][2].TextColor3=val and Color3.fromRGB(0,255,0)or Color3.fromRGB(150,150,150)
  buttons[i][1].BackgroundTransparency=val and 0.3 or 0.8
 end
end

-- 各機能のトグル関数
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
 updateUI()
end

local function toggleN()
 n=not n
 updateUI()
end

local function toggleE()
 e=not e
 for _,v in pairs(ef:GetChildren())do v:Destroy()end
 if e then
  for _,pl in pairs(ps:GetPlayers())do
   if pl~=p then
    createESP(pl)
   end
  end
 end
 updateUI()
end

local function toggleFl()
 fl=not fl
 updateUI()
end

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
 updateUI()
end

local function toggleA()
 a=not a
 updateUI()
end

-- ESP作成関数
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

-- Noclip処理
r.Stepped:Connect(function()
 if n and p.Character then
  for _,pt in pairs(p.Character:GetChildren())do
   if pt:IsA("BasePart")then pt.CanCollide=false end
  end
 end
end)

-- Aimbot
local function getClosestPlayer()
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

-- ★★★ 修正: AimbotがONの時だけ視点移動 ★★★
r.RenderStepped:Connect(function()
 if a and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
  local tp,pt=getClosestPlayer()
  if tp and pt then
   local cf=c.CFrame
   c.CFrame=cf:Lerp(CFrame.lookAt(cf.Position,pt.Position),0.5)
  end
 end
end)

-- Fling処理
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

-- 飛行処理
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
   if h.UseJumpPower then h.JumpPower=j else h.JumpHeight=j/3 end
  end
 end
end

-- ボタンクリック処理
for i=1,6 do
 buttons[i][3].MouseButton1Click:Connect(function()
  if i==1 then toggleF() end
  if i==2 then toggleN() end
  if i==3 then toggleE() end
  if i==4 then toggleFl() end
  if i==5 then toggleG() end
  if i==6 then toggleA() end
 end)
end

closeBtn.MouseButton1Click:Connect(function()
 m=false
 gui.Enabled=false
end)

menuBtn.MouseButton1Click:Connect(function()
 m=not m
 gui.Enabled=m
end)

-- キー入力
u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if i.KeyCode==Enum.KeyCode.F then toggleF() end
 if i.KeyCode==Enum.KeyCode.X then toggleN() end
 if i.KeyCode==Enum.KeyCode.E then toggleE() end
 if i.KeyCode==Enum.KeyCode.G then toggleFl() end
 if i.KeyCode==Enum.KeyCode.Q then toggleG() end
 if i.KeyCode==Enum.KeyCode.R then toggleA() end
 if i.KeyCode==Enum.KeyCode.M then m=not m gui.Enabled=m end
 
 -- 速度調整
 if f then
  if i.KeyCode==Enum.KeyCode.Up then s=math.min(s+10,200)
  elseif i.KeyCode==Enum.KeyCode.Down then s=math.max(s-10,10)end
 end
 if i.KeyCode==Enum.KeyCode.Right then ws=math.min(ws+2,100)applyStats()
 elseif i.KeyCode==Enum.KeyCode.Left then ws=math.max(ws-2,1)applyStats()end
 if i.KeyCode==Enum.KeyCode.PageUp then j=math.min(j+5,200)applyStats()
 elseif i.KeyCode==Enum.KeyCode.PageDown then j=math.max(j-5,10)applyStats()end
end)

p.CharacterAdded:Connect(function()
 if f then
  f=false
  if bg then bg:Destroy()end
  if bv then bv:Destroy()end
 end
 applyStats()
 updateUI()
end)

ps.PlayerAdded:Connect(function(pl)
 if e then createESP(pl) end
end)

-- サーバーホップ
local function serverHop()
 local success,res=pcall(function()
  return hs:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"))
 end)
 if success and res then
  for _,v in pairs(res.data)do
   if v.playing<v.maxPlayers and v.id~=game.JobId then
    ts:TeleportToPlaceInstance(game.PlaceId,v.id)
    break
   end
  end
 end
end

local function rejoin()
 if #ps:GetPlayers()<=1 then
  ts:Teleport(game.PlaceId,p)
 else
  ts:TeleportToPlaceInstance(game.PlaceId,game.JobId,p)
 end
end

u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if i.KeyCode==Enum.KeyCode.H then serverHop()end
 if i.KeyCode==Enum.KeyCode.J then rejoin()end
end)

-- アンチキック
local ac=hookmetamethod
if ac then
 local oi=ac(game,"__index",function(s,m)
  if s==p and m:lower()=="kick"then return error("",2)end
  return oi(s,m)
 end)
 local on=ac(game,"__namecall",function(s,...)
  if s==p and getnamecallmethod():lower()=="kick"then return end
  return on(s,...)
 end)
end

applyStats()
updateUI()
