local p=game.Players.LocalPlayer
local u=game:GetService("UserInputService")
local r=game:GetService("RunService")
local ps=game:GetService("Players")
local c=workspace.CurrentCamera
local tween=game:GetService("TweenService")

-- フラグ
local f=false
local n=false
local e=false
local g=false
local tr=false
local w=false
local ij=false
local menu=false

-- 設定値
local s=50
local ws=16
local jp=50
local ds=150
local bg,bv

-- キーバインド設定（自由に変更可）
local keys={
 f=Enum.KeyCode.F,
 n=Enum.KeyCode.X,
 e=Enum.KeyCode.E,
 g=Enum.KeyCode.G,
 tr=Enum.KeyCode.T,
 w=Enum.KeyCode.Y,  -- W→Yに変更（前進と被らない）
 ij=Enum.KeyCode.I,
 menu=Enum.KeyCode.M
}

-- ESP用
local ef=Instance.new("Folder",p:WaitForChild("PlayerGui"))
ef.Name="ESP"

-- モダンUI（Sirius風）
local gui=Instance.new("ScreenGui")
gui.Name="ModernHub"
gui.Enabled=false
gui.Parent=p.PlayerGui

-- メインパネル
local main=Instance.new("Frame")
main.Size=UDim2.new(0,400,0,500)
main.Position=UDim2.new(0.5,-200,0.5,-250)
main.BackgroundColor3=Color3.fromRGB(20,20,20)
main.BackgroundTransparency=0.1
main.BorderSizePixel=0
main.Parent=gui

local corner=Instance.new("UICorner")
corner.CornerRadius=UDim.new(0,12)
corner.Parent=main

local stroke=Instance.new("UIStroke")
stroke.Thickness=1
stroke.Color=Color3.fromRGB(80,80,80)
stroke.Transparency=0.5
stroke.Parent=main

-- ヘッダー
local header=Instance.new("Frame")
header.Size=UDim2.new(1,0,0,50)
header.BackgroundColor3=Color3.fromRGB(30,30,30)
header.BorderSizePixel=0
header.Parent=main

local headerCorner=Instance.new("UICorner")
headerCorner.CornerRadius=UDim.new(0,12)
headerCorner.Parent=header

local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-40,1,0)
title.Position=UDim2.new(0,15,0,0)
title.BackgroundTransparency=1
title.Text="MODERN HUB"
title.TextColor3=Color3.fromRGB(220,220,220)
title.TextSize=20
title.Font=Enum.Font.GothamBold
title.TextXAlignment=Enum.TextXAlignment.Left
title.Parent=header

local closeBtn=Instance.new("TextButton")
closeBtn.Size=UDim2.new(0,30,0,30)
closeBtn.Position=UDim2.new(1,-40,0,10)
closeBtn.BackgroundTransparency=1
closeBtn.Text="✕"
closeBtn.TextColor3=Color3.fromRGB(200,200,200)
closeBtn.TextSize=20
closeBtn.Font=Enum.Font.GothamBold
closeBtn.Parent=header

-- タブ
local tabFrame=Instance.new("Frame")
tabFrame.Size=UDim2.new(1,0,0,40)
tabFrame.Position=UDim2.new(0,0,0,50)
tabFrame.BackgroundTransparency=1
tabFrame.Parent=main

local mainTab=Instance.new("TextButton")
mainTab.Size=UDim2.new(0.5,-5,0,30)
mainTab.Position=UDim2.new(0,10,0,5)
mainTab.BackgroundColor3=Color3.fromRGB(50,50,50)
mainTab.Text="MAIN"
mainTab.TextColor3=Color3.fromRGB(255,255,255)
mainTab.TextSize=14
mainTab.Font=Enum.Font.GothamBold
mainTab.Parent=tabFrame

local keyTab=Instance.new("TextButton")
keyTab.Size=UDim2.new(0.5,-5,0,30)
keyTab.Position=UDim2.new(0.5,0,0,5)
keyTab.BackgroundColor3=Color3.fromRGB(30,30,30)
keyTab.Text="KEYBINDS"
keyTab.TextColor3=Color3.fromRGB(200,200,200)
keyTab.TextSize=14
keyTab.Font=Enum.Font.GothamBold
keyTab.Parent=tabFrame

local tabCorner=Instance.new("UICorner")
tabCorner.CornerRadius=UDim.new(0,6)
tabCorner.Parent=mainTab
local tabCorner2=tabCorner:Clone()
tabCorner2.Parent=keyTab

-- メインコンテンツ
local content=Instance.new("ScrollingFrame")
content.Size=UDim2.new(1,-20,1,-100)
content.Position=UDim2.new(0,10,0,100)
content.BackgroundTransparency=1
content.ScrollBarThickness=4
content.ScrollBarImageColor3=Color3.fromRGB(100,100,100)
content.CanvasSize=UDim2.new(0,0,0,0)
content.Parent=main

local layout=Instance.new("UIListLayout")
layout.Padding=UDim.new(0,8)
layout.Parent=content

-- 機能ボタン作成関数
local function createToggle(name,key,color,desc)
 local frame=Instance.new("Frame")
 frame.Size=UDim2.new(1,0,0,70)
 frame.BackgroundColor3=Color3.fromRGB(30,30,30)
 frame.BorderSizePixel=0
 frame.Parent=content
 
 local fCorner=Instance.new("UICorner")
 fCorner.CornerRadius=UDim.new(0,8)
 fCorner.Parent=frame
 
 local icon=Instance.new("Frame")
 icon.Size=UDim2.new(0,50,0,50)
 icon.Position=UDim2.new(0,10,0,10)
 icon.BackgroundColor3=color
 icon.BackgroundTransparency=0.3
 icon.Parent=frame
 
 local iCorner=Instance.new("UICorner")
 iCorner.CornerRadius=UDim.new(0,8)
 iCorner.Parent=icon
 
 local nameLbl=Instance.new("TextLabel")
 nameLbl.Size=UDim2.new(1,-80,0,20)
 nameLbl.Position=UDim2.new(0,70,0,15)
 nameLbl.BackgroundTransparency=1
 nameLbl.Text=name
 nameLbl.TextColor3=Color3.fromRGB(255,255,255)
 nameLbl.TextSize=16
 nameLbl.Font=Enum.Font.GothamBold
 nameLbl.TextXAlignment=Enum.TextXAlignment.Left
 nameLbl.Parent=frame
 
 local keyLbl=Instance.new("TextLabel")
 keyLbl.Size=UDim2.new(1,-80,0,15)
 keyLbl.Position=UDim2.new(0,70,0,35)
 keyLbl.BackgroundTransparency=1
 keyLbl.Text="Key: "..key.Name
 keyLbl.TextColor3=Color3.fromRGB(150,150,150)
 keyLbl.TextSize=12
 keyLbl.Font=Enum.Font.GothamMedium
 keyLbl.TextXAlignment=Enum.TextXAlignment.Left
 keyLbl.Parent=frame
 
 local status=Instance.new("TextLabel")
 status.Size=UDim2.new(0,50,0,30)
 status.Position=UDim2.new(1,-60,0,20)
 status.BackgroundColor3=Color3.fromRGB(255,0,0)
 status.BackgroundTransparency=0.5
 status.Text="OFF"
 status.TextColor3=Color3.fromRGB(255,255,255)
 status.TextSize=12
 status.Font=Enum.Font.GothamBold
 status.Parent=frame
 
 local sCorner=Instance.new("UICorner")
 sCorner.CornerRadius=UDim.new(0,6)
 sCorner.Parent=status
 
 local btn=Instance.new("TextButton")
 btn.Size=UDim2.new(1,0,1,0)
 btn.BackgroundTransparency=1
 btn.Text=""
 btn.Parent=frame
 
 return {frame,status,btn,keyLbl}
end

-- 機能ボタン作成
local toggles={}
toggles[1]=createToggle("FLIGHT",keys.f,Color3.fromRGB(0,150,255))
toggles[2]=createToggle("NOCLIP",keys.n,Color3.fromRGB(0,200,100))
toggles[3]=createToggle("ESP",keys.e,Color3.fromRGB(255,180,0))
toggles[4]=createToggle("GODMODE",keys.g,Color3.fromRGB(200,0,255))
toggles[5]=createToggle("TRANSPARENT",keys.tr,Color3.fromRGB(100,100,255))
toggles[6]=createToggle("WALLHACK",keys.w,Color3.fromRGB(255,100,100))
toggles[7]=createToggle("INF JUMP",keys.ij,Color3.fromRGB(255,150,0))

content.CanvasSize=UDim2.new(0,0,0,#toggles*78)

-- キーバインド設定画面
local keyContent=Instance.new("ScrollingFrame")
keyContent.Size=UDim2.new(1,-20,1,-100)
keyContent.Position=UDim2.new(0,10,0,100)
keyContent.BackgroundTransparency=1
keyContent.ScrollBarThickness=4
keyContent.ScrollBarImageColor3=Color3.fromRGB(100,100,100)
keyContent.CanvasSize=UDim2.new(0,0,0,0)
keyContent.Visible=false
keyContent.Parent=main

local keyLayout=Instance.new("UIListLayout")
keyLayout.Padding=UDim.new(0,8)
keyLayout.Parent=keyContent

local keyFrames={}
local function createKeybind(name,key,default)
 local frame=Instance.new("Frame")
 frame.Size=UDim2.new(1,0,0,60)
 frame.BackgroundColor3=Color3.fromRGB(30,30,30)
 frame.BorderSizePixel=0
 frame.Parent=keyContent
 
 local fCorner=Instance.new("UICorner")
 fCorner.CornerRadius=UDim.new(0,8)
 fCorner.Parent=frame
 
 local nameLbl=Instance.new("TextLabel")
 nameLbl.Size=UDim2.new(1,-150,0,20)
 nameLbl.Position=UDim2.new(0,15,0,20)
 nameLbl.BackgroundTransparency=1
 nameLbl.Text=name
 nameLbl.TextColor3=Color3.fromRGB(255,255,255)
 nameLbl.TextSize=16
 nameLbl.Font=Enum.Font.GothamBold
 nameLbl.TextXAlignment=Enum.TextXAlignment.Left
 nameLbl.Parent=frame
 
 local keyBtn=Instance.new("TextButton")
 keyBtn.Size=UDim2.new(0,100,0,30)
 keyBtn.Position=UDim2.new(1,-115,0,15)
 keyBtn.BackgroundColor3=Color3.fromRGB(50,50,50)
 keyBtn.Text=default.Name
 keyBtn.TextColor3=Color3.fromRGB(255,255,255)
 keyBtn.TextSize=14
 keyBtn.Font=Enum.Font.GothamBold
 keyBtn.Parent=frame
 
 local kCorner=Instance.new("UICorner")
 kCorner.CornerRadius=UDim.new(0,6)
 kCorner.Parent=keyBtn
 
 table.insert(keyFrames,{keyBtn,key})
end

createKeybind("FLIGHT",keys,"F")
createKeybind("NOCLIP",keys,"X")
createKeybind("ESP",keys,"E")
createKeybind("GODMODE",keys,"G")
createKeybind("TRANSPARENT",keys,"T")
createKeybind("WALLHACK",keys,"Y")
createKeybind("INF JUMP",keys,"I")
createKeybind("MENU",keys,"M")

keyContent.CanvasSize=UDim2.new(0,0,0,#keyFrames*68)

-- タブ切り替え
mainTab.MouseButton1Click:Connect(function()
 content.Visible=true
 keyContent.Visible=false
 mainTab.BackgroundColor3=Color3.fromRGB(50,50,50)
 keyTab.BackgroundColor3=Color3.fromRGB(30,30,30)
 mainTab.TextColor3=Color3.fromRGB(255,255,255)
 keyTab.TextColor3=Color3.fromRGB(200,200,200)
end)

keyTab.MouseButton1Click:Connect(function()
 content.Visible=false
 keyContent.Visible=true
 mainTab.BackgroundColor3=Color3.fromRGB(30,30,30)
 keyTab.BackgroundColor3=Color3.fromRGB(50,50,50)
 mainTab.TextColor3=Color3.fromRGB(200,200,200)
 keyTab.TextColor3=Color3.fromRGB(255,255,255)
end)

-- メニューボタン
local menuBtn=Instance.new("TextButton")
menuBtn.Size=UDim2.new(0,50,0,50)
menuBtn.Position=UDim2.new(0,20,1,-70)
menuBtn.BackgroundColor3=Color3.fromRGB(30,30,30)
menuBtn.Text="MENU"
menuBtn.TextColor3=Color3.fromRGB(200,200,200)
menuBtn.TextSize=14
menuBtn.Font=Enum.Font.GothamBold
menuBtn.Parent=gui

local menuCorner=Instance.new("UICorner")
menuCorner.CornerRadius=UDim.new(0,25)
menuCorner.Parent=menuBtn

local menuStroke=Instance.new("UIStroke")
menuStroke.Thickness=1
menuStroke.Color=Color3.fromRGB(80,80,80)
menuStroke.Parent=menuBtn

-- ESP作成
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

-- 各機能のトグル
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
 toggles[1][2].Text=f and"ON"or"OFF"
 toggles[1][2].BackgroundColor3=f and Color3.new(0,255,0)or Color3.new(255,0,0)
end

local function toggleN()
 n=not n
 toggles[2][2].Text=n and"ON"or"OFF"
 toggles[2][2].BackgroundColor3=n and Color3.new(0,255,0)or Color3.new(255,0,0)
end

local function toggleE()
 e=not e
 for _,v in pairs(ef:GetChildren())do v:Destroy()end
 if e then
  for _,pl in pairs(ps:GetPlayers())do createESP(pl)end
 end
 toggles[3][2].Text=e and"ON"or"OFF"
 toggles[3][2].BackgroundColor3=e and Color3.new(0,255,0)or Color3.new(255,0,0)
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
 toggles[4][2].Text=g and"ON"or"OFF"
 toggles[4][2].BackgroundColor3=g and Color3.new(0,255,0)or Color3.new(255,0,0)
end

local function toggleTR()
 tr=not tr
 if p.Character then
  for _,pt in pairs(p.Character:GetDescendants())do
   if pt:IsA("BasePart")or pt:IsA("MeshPart")then
    pt.Transparency=tr and 0.8 or 0
   end
  end
 end
 toggles[5][2].Text=tr and"ON"or"OFF"
 toggles[5][2].BackgroundColor3=tr and Color3.new(0,255,0)or Color3.new(255,0,0)
end

local function toggleW()
 w=not w
 for _,pl in pairs(ps:GetPlayers())do
  if pl~=p and pl.Character then
   for _,pt in pairs(pl.Character:GetDescendants())do
    if pt:IsA("BasePart")then
     pt.LocalTransparencyModifier=w and 0.7 or 0
    end
   end
  end
 end
 toggles[6][2].Text=w and"ON"or"OFF"
 toggles[6][2].BackgroundColor3=w and Color3.new(0,255,0)or Color3.new(255,0,0)
end

local function toggleIJ()
 ij=not ij
 toggles[7][2].Text=ij and"ON"or"OFF"
 toggles[7][2].BackgroundColor3=ij and Color3.new(0,255,0)or Color3.new(255,0,0)
end

-- ボタンクリック
for i=1,7 do
 toggles[i][3].MouseButton1Click:Connect(function()
  if i==1 then toggleF() end
  if i==2 then toggleN() end
  if i==3 then toggleE() end
  if i==4 then toggleG() end
  if i==5 then toggleTR() end
  if i==6 then toggleW() end
  if i==7 then toggleIJ() end
 end)
end

closeBtn.MouseButton1Click:Connect(function()
 menu=false
 gui.Enabled=false
end)

menuBtn.MouseButton1Click:Connect(function()
 menu=not menu
 gui.Enabled=menu
end)

-- キー入力処理
u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if i.KeyCode==keys.f then toggleF() end
 if i.KeyCode==keys.n then toggleN() end
 if i.KeyCode==keys.e then toggleE() end
 if i.KeyCode==keys.g then toggleG() end
 if i.KeyCode==keys.tr then toggleTR() end
 if i.KeyCode==keys.w then toggleW() end
 if i.KeyCode==keys.ij then toggleIJ() end
 if i.KeyCode==keys.menu then menu=not menu gui.Enabled=menu end
end)

-- キーバインド変更処理
for _,kf in pairs(keyFrames) do
 kf[1].MouseButton1Click:Connect(function()
  kf[1].Text="PRESS KEY"
  local conn
  conn=u.InputBegan:Connect(function(k)
   if k.UserInputType==Enum.UserInputType.Keyboard then
    kf[1].Text=k.KeyCode.Name
    if kf[2]==keys then
     if kf[1].Parent.Name=="FLIGHT" then keys.f=k.KeyCode
     elseif kf[1].Parent.Name=="NOCLIP" then keys.n=k.KeyCode
     elseif kf[1].Parent.Name=="ESP" then keys.e=k.KeyCode
     elseif kf[1].Parent.Name=="GODMODE" then keys.g=k.KeyCode
     elseif kf[1].Parent.Name=="TRANSPARENT" then keys.tr=k.KeyCode
     elseif kf[1].Parent.Name=="WALLHACK" then keys.w=k.KeyCode
     elseif kf[1].Parent.Name=="INF JUMP" then keys.ij=k.KeyCode
     elseif kf[1].Parent.Name=="MENU" then keys.menu=k.KeyCode
     end
    end
    conn:Disconnect()
   end
  end)
 end)
end

-- 各種処理
r.Stepped:Connect(function()
 if n and p.Character then
  for _,pt in pairs(p.Character:GetChildren())do
   if pt:IsA("BasePart")then pt.CanCollide=false end
  end
 end
end)

r.Heartbeat:Connect(function()
 if ij and p.Character then
  local h=p.Character:FindFirstChild("Humanoid")
  if h and h:GetState()==Enum.HumanoidStateType.Jumping then
   h:ChangeState(Enum.HumanoidStateType.Jumping)
  end
 end
end)

-- 飛行処理（長押し対応）
local speedPress=0
u.InputBegan:Connect(function(i)
 if i.KeyCode==Enum.KeyCode.Up and f then
  speedPress=1
  while speedPress==1 and f do
   s=math.min(s+1,200)
   r.Stepped:Wait()
  end
 elseif i.KeyCode==Enum.KeyCode.Down and f then
  speedPress=2
  while speedPress==2 and f do
   s=math.max(s-1,10)
   r.Stepped:Wait()
  end
 end
end)

u.InputEnded:Connect(function(i)
 if i.KeyCode==Enum.KeyCode.Up and speedPress==1 then speedPress=0 end
 if i.KeyCode==Enum.KeyCode.Down and speedPress==2 then speedPress=0 end
end)

-- バー式表示
local barFrame=Instance.new("Frame")
barFrame.Size=UDim2.new(0,200,0,30)
barFrame.Position=UDim2.new(0,10,0,200)
barFrame.BackgroundColor3=Color3.new(0,0,0)
barFrame.BackgroundTransparency=0.5
barFrame.Parent=gui

local bar=Instance.new("Frame")
bar.Size=UDim2.new(0,0,1,0)
bar.BackgroundColor3=Color3.new(0,255,0)
bar.Parent=barFrame

local barText=Instance.new("TextLabel")
barText.Size=UDim2.new(1,0,1,0)
barText.BackgroundTransparency=1
barText.Text="Speed: "..s
barText.TextColor3=Color3.new(1,1,1)
barText.Parent=barFrame

r.Heartbeat:Connect(function()
 barText.Text="Speed: "..s
 bar:TweenSize(UDim2.new(s/200,0,1,0),"Out","Linear",0.1)
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

-- 移動速度/ジャンプ力調整
u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if i.KeyCode==Enum.KeyCode.Right then ws=math.min(ws+2,100)applyStats()
 elseif i.KeyCode==Enum.KeyCode.Left then ws=math.max(ws-2,1)applyStats()end
 if i.KeyCode==Enum.KeyCode.PageUp then jp=math.min(jp+5,200)applyStats()
 elseif i.KeyCode==Enum.KeyCode.PageDown then jp=math.max(jp-5,10)applyStats()end
end)

p.CharacterAdded:Connect(function()
 if f then
  f=false
  if bg then bg:Destroy()end
  if bv then bv:Destroy()end
 end
 applyStats()
end)

ps.PlayerAdded:Connect(function(pl)
 if e then createESP(pl)end
end)

applyStats()
