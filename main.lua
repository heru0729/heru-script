local p=game.Players.LocalPlayer
local u=game:GetService("UserInputService")
local r=game:GetService("RunService")
local ps=game:GetService("Players")
local c=workspace.CurrentCamera
local ts=game:GetService("TeleportService")
local sg=game:GetService("StarterGui")
local l=game:GetService("Lighting")
local tween=game:GetService("TweenService")

-- フラグ
local f=false local n=false local e=false local g=false local w=false local ij=false
local sb=false local grav=false local nk=false local hr=false local fr=false local wi=false
local pi=false local ko=false local af=false local iesp=false local skin=false local nr=false
local ik=false local nd=false local fire=false local water=false local stun=false local tp=false
local pos=false local timef=false local weather=false local fps=false
local menuOpen=true

-- 設定値
local s=50 local ws=16 local jp=50 local ds=150 local gravVal=1 local bg,bv local tpTarget=nil
local ef=Instance.new("Folder",p:WaitForChild("PlayerGui")) ef.Name="ESP"

-- キーバインド
local keys={
 F1=Enum.KeyCode.F1, F2=Enum.KeyCode.F2, F3=Enum.KeyCode.F3, F4=Enum.KeyCode.F4,
 F5=Enum.KeyCode.F5, F6=Enum.KeyCode.F6, F7=Enum.KeyCode.F7, F8=Enum.KeyCode.F8,
 F9=Enum.KeyCode.F9, F10=Enum.KeyCode.F10, F11=Enum.KeyCode.F11, F12=Enum.KeyCode.F12,
 Num0=Enum.KeyCode.KeypadZero, Num1=Enum.KeyCode.KeypadOne, Num2=Enum.KeyCode.KeypadTwo,
 Num3=Enum.KeyCode.KeypadThree, Num4=Enum.KeyCode.KeypadFour, Num5=Enum.KeyCode.KeypadFive,
 Num6=Enum.KeyCode.KeypadSix, Num7=Enum.KeyCode.KeypadSeven, Num8=Enum.KeyCode.KeypadEight,
 Num9=Enum.KeyCode.KeypadNine, NumDot=Enum.KeyCode.KeypadPeriod, NumEnter=Enum.KeyCode.KeypadEnter,
 NumPlus=Enum.KeyCode.KeypadPlus, NumMinus=Enum.KeyCode.KeypadMinus, NumMul=Enum.KeyCode.KeypadMultiply,
 NumDiv=Enum.KeyCode.KeypadDivide, M=Enum.KeyCode.M
}

-- モダンUI
local gui=Instance.new("ScreenGui")
gui.Name="ModMenu"
gui.Parent=p.PlayerGui

-- メインパネル
local main=Instance.new("Frame")
main.Size=UDim2.new(0,800,0,600)
main.Position=UDim2.new(0.5,-400,0.5,-300)
main.BackgroundColor3=Color3.fromRGB(20,20,20)
main.BackgroundTransparency=0.1
main.BorderSizePixel=0
main.Visible=menuOpen
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
title.Text="MODERN HUB - FULL FEATURES"
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

-- スクロールエリア
local scrolling=Instance.new("ScrollingFrame")
scrolling.Size=UDim2.new(1,-20,1,-60)
scrolling.Position=UDim2.new(0,10,0,55)
scrolling.BackgroundTransparency=1
scrolling.ScrollBarThickness=8
scrolling.ScrollBarImageColor3=Color3.fromRGB(100,100,100)
scrolling.CanvasSize=UDim2.new(0,0,0,0)
scrolling.Parent=main

local grid=Instance.new("UIGridLayout")
grid.CellSize=UDim2.new(0,180,0,70)
grid.CellPadding=UDim2.new(0,10,0,10)
grid.FillDirection=Enum.FillDirection.Horizontal
grid.HorizontalAlignment=Enum.HorizontalAlignment.Center
grid.Parent=scrolling

-- ボタン作成関数
local function createButton(name,key,color)
 local btn=Instance.new("Frame")
 btn.BackgroundColor3=color
 btn.BackgroundTransparency=0.8
 btn.BorderSizePixel=0
 btn.Parent=scrolling
 
 local btnCorner=Instance.new("UICorner")
 btnCorner.CornerRadius=UDim.new(0,8)
 btnCorner.Parent=btn
 
 local nameLbl=Instance.new("TextLabel")
 nameLbl.Size=UDim2.new(1,0,0,25)
 nameLbl.Position=UDim2.new(0,5,0,5)
 nameLbl.BackgroundTransparency=1
 nameLbl.Text=name
 nameLbl.TextColor3=Color3.fromRGB(255,255,255)
 nameLbl.TextSize=14
 nameLbl.Font=Enum.Font.GothamBold
 nameLbl.TextXAlignment=Enum.TextXAlignment.Left
 nameLbl.Parent=btn
 
 local keyLbl=Instance.new("TextLabel")
 keyLbl.Size=UDim2.new(1,0,0,20)
 keyLbl.Position=UDim2.new(0,5,0,30)
 keyLbl.BackgroundTransparency=1
 keyLbl.Text=key
 keyLbl.TextColor3=Color3.fromRGB(200,200,200)
 keyLbl.TextSize=12
 keyLbl.Font=Enum.Font.GothamMedium
 keyLbl.TextXAlignment=Enum.TextXAlignment.Left
 keyLbl.Parent=btn
 
 local status=Instance.new("TextLabel")
 status.Size=UDim2.new(0,50,0,25)
 status.Position=UDim2.new(1,-55,0,22)
 status.BackgroundColor3=Color3.fromRGB(255,0,0)
 status.BackgroundTransparency=0.3
 status.Text="OFF"
 status.TextColor3=Color3.fromRGB(255,255,255)
 status.TextSize=12
 status.Font=Enum.Font.GothamBold
 status.Parent=btn
 
 local statusCorner=Instance.new("UICorner")
 statusCorner.CornerRadius=UDim.new(0,6)
 statusCorner.Parent=status
 
 local clickBtn=Instance.new("TextButton")
 clickBtn.Size=UDim2.new(1,0,1,0)
 clickBtn.BackgroundTransparency=1
 clickBtn.Text=""
 clickBtn.Parent=btn
 
 return {btn,status,clickBtn}
end

-- 全ボタン作成
local buttons={}
local names={
 "Flight","NoClip","ESP","Godmode","Wallhack","Infinite Jump",
 "Speed Boost","Gravity Change","No Knockback","Auto Heal","Instant Heal","Wall Transparent",
 "Player Info","Kill All","Auto Farm","Item ESP","Skin Changer","No Recoil",
 "Instant Kill","No Damage","Fire Proof","Water Proof","Stun Proof","Teleport",
 "Show Position","Time Fix","Weather Fix","FPS Counter"
}
local keyTexts={
 "F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12",
 "Num1","Num2","Num3","Num4","Num5","Num6","Num7","Num8","Num9","Num.","NumEnter","Num+",
 "Num-","Num*","Num/","Num0"
}
local colors={
 Color3.fromRGB(0,150,255),Color3.fromRGB(0,200,100),Color3.fromRGB(255,180,0),
 Color3.fromRGB(200,0,255),Color3.fromRGB(255,100,100),Color3.fromRGB(255,150,0),
 Color3.fromRGB(0,200,200),Color3.fromRGB(150,100,255),Color3.fromRGB(100,200,100),
 Color3.fromRGB(255,80,80),Color3.fromRGB(0,255,0),Color3.fromRGB(150,150,255),
 Color3.fromRGB(255,200,0),Color3.fromRGB(255,0,0),Color3.fromRGB(200,100,0),
 Color3.fromRGB(100,255,100),Color3.fromRGB(255,100,200),Color3.fromRGB(100,100,255),
 Color3.fromRGB(255,0,100),Color3.fromRGB(0,100,255),Color3.fromRGB(255,150,150),
 Color3.fromRGB(150,255,255),Color3.fromRGB(255,255,100),Color3.fromRGB(150,0,255),
 Color3.fromRGB(100,255,0),Color3.fromRGB(0,255,200),Color3.fromRGB(200,200,200),
 Color3.fromRGB(255,255,255)
}

for i=1,28 do
 local btn=createButton(names[i],keyTexts[i],colors[i])
 table.insert(buttons,{btn[1],btn[2],btn[3],names[i]})
end

scrolling.CanvasSize=UDim2.new(0,0,0,math.ceil(28/4)*80)

-- 状態更新
local function updateUI()
 local states={f,n,e,g,w,ij,sb,grav,nk,hr,fr,wi,pi,ko,af,iesp,skin,nr,ik,nd,fire,water,stun,tp,pos,timef,weather,fps}
 for i=1,28 do
  buttons[i][2].Text=states[i] and"ON"or"OFF"
  buttons[i][2].BackgroundColor3=states[i] and Color3.fromRGB(0,255,0)or Color3.fromRGB(255,0,0)
 end
end

-- ESP作成
local function createESP(pl)
 if pl==p then return end
 local function addESP(ch)
  if not ch then return end
  local rt=ch:FindFirstChild("HumanoidRootPart") if not rt then return end
  local bx=Instance.new("BoxHandleAdornment") bx.Size=Vector3.new(4,5,2) bx.Adornee=rt bx.AlwaysOnTop=true bx.ZIndex=10 bx.Transparency=0.3
  bx.Color3=pl.TeamColor==p.TeamColor and Color3.new(0,1,0)or Color3.new(1,0,0) bx.Parent=ef
  local bl=Instance.new("BillboardGui") bl.Adornee=rt bl.Size=UDim2.new(0,100,0,30) bl.StudsOffset=Vector3.new(0,3,0) bl.AlwaysOnTop=true bl.Parent=ef
  local nl=Instance.new("TextLabel") nl.Size=UDim2.new(1,0,1,0) nl.BackgroundTransparency=1 nl.Text=pl.Name
  nl.TextColor3=Color3.new(1,1,1) nl.TextStrokeTransparency=0.5 nl.Parent=bl
 end
 if pl.Character then addESP(pl.Character)end
 pl.CharacterAdded:Connect(function(ch)task.wait()addESP(ch)end)
end

-- 各機能
local function toggleF() f=not f local ch=p.Character if not ch then return end local h=ch:FindFirstChild("Humanoid")local rt=ch:FindFirstChild("HumanoidRootPart") if not h or not rt then return end if f then h.PlatformStand=true bg=Instance.new("BodyGyro")bg.MaxTorque=Vector3.new(9e9,9e9,9e9)bg.P=10000 bg.Parent=rt bv=Instance.new("BodyVelocity")bv.MaxForce=Vector3.new(9e9,9e9,9e9)bv.Velocity=Vector3.new(0,0,0)bv.Parent=rt else if bg then bg:Destroy()end if bv then bv:Destroy()end h.PlatformStand=false end updateUI()end
local function toggleN() n=not n updateUI()end
local function toggleE() e=not e for _,v in pairs(ef:GetChildren())do v:Destroy()end if e then for _,pl in pairs(ps:GetPlayers())do createESP(pl)end end updateUI()end
local function toggleG() g=not g if g and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.MaxHealth=math.huge h.Health=math.huge h.BreakJointsOnDeath=false end end updateUI()end
local function toggleW() w=not w for _,pl in pairs(ps:GetPlayers())do if pl~=p and pl.Character then for _,pt in pairs(pl.Character:GetDescendants())do if pt:IsA("BasePart")then pt.LocalTransparencyModifier=w and 0.7 or 0 end end end end updateUI()end
local function toggleIJ() ij=not ij updateUI()end
local function toggleSB() sb=not sb if p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.WalkSpeed=sb and 80 or ws end end updateUI()end
local function toggleGrav() grav=not grav gravVal=grav and 2 or 1 workspace.Gravity=grav and 100 or 196.2 updateUI()end
local function toggleNK() nk=not nk updateUI()end
local function toggleHR() hr=not hr if hr then coroutine.wrap(function()while hr and p.Character do local h=p.Character:FindFirstChild("Humanoid")if h then h.Health=math.min(h.Health+2,h.MaxHealth)end task.wait(1)end end)()end updateUI()end
local function toggleFR() fr=not fr if fr and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h then h.Health=h.MaxHealth end end updateUI()end
local function toggleWI() wi=not wi for _,v in pairs(workspace:GetDescendants())do if v:IsA("BasePart")and v.Material~=Enum.Material.Water then v.LocalTransparencyModifier=wi and 0.5 or 0 end end updateUI()end
local function togglePI() pi=not pi updateUI()end
local function toggleKO() ko=not ko if ko then for _,pl in pairs(ps:GetPlayers())do if pl~=p and pl.Character then local h=pl.Character:FindFirstChild("Humanoid") if h then h.Health=0 end end end ko=false updateUI()end end
local function toggleAF() af=not af if af then coroutine.wrap(function()while af do for _,pl in pairs(ps:GetPlayers())do if pl~=p and pl.Character then local h=pl.Character:FindFirstChild("Humanoid") if h then h.Health=h.Health-10 end end end task.wait(0.5)end end)()end updateUI()end
local function toggleIESP() iesp=not iesp updateUI()end
local function toggleSKIN() skin=not skin updateUI()end
local function toggleNR() nr=not nr updateUI()end
local function toggleIK() ik=not ik updateUI()end
local function toggleND() nd=not nd updateUI()end
local function toggleFIRE() fire=not fire updateUI()end
local function toggleWATER() water=not water updateUI()end
local function toggleSTUN() stun=not stun updateUI()end
local function toggleTP() tp=not tp if tp then local pls={}for _,pl in pairs(ps:GetPlayers())do if pl~=p then table.insert(pls,pl.Name)end end local target=pls[math.random(#pls)] tpTarget=ps:FindFirstChild(target) if tpTarget and tpTarget.Character and p.Character then p.Character.HumanoidRootPart.CFrame=tpTarget.Character.HumanoidRootPart.CFrame end tp=false updateUI()end end
local function togglePOS() pos=not pos if pos then coroutine.wrap(function()while pos do if p.Character then local rt=p.Character:FindFirstChild("HumanoidRootPart") if rt then sg:SetCore("ChatMakeSystemMessage",{Text="POS: "..math.floor(rt.Position.X)..","..math.floor(rt.Position.Y)..","..math.floor(rt.Position.Z),Color=Color3.new(0,1,0)})end end task.wait(1)end end)()end updateUI()end
local function toggleTIMEF() timef=not timef if timef then l.ClockTime=12 else l:SetMinutesAfterMidnight(os.date("*t").hour*60+os.date("*t").min)end updateUI()end
local function toggleWEATHER() weather=not weather if weather then l:SetMinutesAfterMidnight(6*60) l.Ambient=Color3.new(1,1,1) else l:SetMinutesAfterMidnight(os.date("*t").hour*60+os.date("*t").min) end updateUI()end
local function toggleFPS() fps=not fps if fps then coroutine.wrap(function()while fps do sg:SetCore("ChatMakeSystemMessage",{Text="FPS: "..math.floor(1/r:Wait()),Color=Color3.new(0,1,0)})end end)()end updateUI()end

-- ボタンクリック
for i=1,28 do
 buttons[i][3].MouseButton1Click:Connect(function()
  if i==1 then toggleF()
  elseif i==2 then toggleN()
  elseif i==3 then e=not e updateUI() createESP()
  elseif i==4 then toggleG()
  elseif i==5 then toggleW()
  elseif i==6 then toggleIJ()
  elseif i==7 then toggleSB()
  elseif i==8 then toggleGrav()
  elseif i==9 then toggleNK()
  elseif i==10 then toggleHR()
  elseif i==11 then toggleFR()
  elseif i==12 then toggleWI()
  elseif i==13 then togglePI()
  elseif i==14 then toggleKO()
  elseif i==15 then toggleAF()
  elseif i==16 then toggleIESP()
  elseif i==17 then toggleSKIN()
  elseif i==18 then toggleNR()
  elseif i==19 then toggleIK()
  elseif i==20 then toggleND()
  elseif i==21 then toggleFIRE()
  elseif i==22 then toggleWATER()
  elseif i==23 then toggleSTUN()
  elseif i==24 then toggleTP()
  elseif i==25 then togglePOS()
  elseif i==26 then toggleTIMEF()
  elseif i==27 then toggleWEATHER()
  elseif i==28 then toggleFPS()
  end
 end)
end

-- キー入力
local keyMap={
 [keys.F1]=toggleF, [keys.F2]=toggleN, [keys.F3]=function()e=not e updateUI() end,
 [keys.F4]=toggleG, [keys.F5]=toggleW, [keys.F6]=toggleIJ,
 [keys.F7]=toggleSB, [keys.F8]=toggleGrav, [keys.F9]=toggleNK,
 [keys.F10]=toggleHR, [keys.F11]=toggleFR, [keys.F12]=toggleWI,
 [keys.Num1]=togglePI, [keys.Num2]=toggleKO, [keys.Num3]=toggleAF,
 [keys.Num4]=toggleIESP, [keys.Num5]=toggleSKIN, [keys.Num6]=toggleNR,
 [keys.Num7]=toggleIK, [keys.Num8]=toggleND, [keys.Num9]=toggleFIRE,
 [keys.NumDot]=toggleWATER, [keys.NumEnter]=toggleSTUN, [keys.NumPlus]=toggleTP,
 [keys.NumMinus]=togglePOS, [keys.NumMul]=toggleTIMEF, [keys.NumDiv]=toggleWEATHER,
 [keys.Num0]=toggleFPS, [keys.M]=function()menuOpen=not menuOpen main.Visible=menuOpen end
}

u.InputBegan:Connect(function(i,pr)
 if pr then return end
 if keyMap[i.KeyCode] then keyMap[i.KeyCode]() end
 
 -- 速度調整
 if i.KeyCode==keys.Right then ws=math.min(ws+2,100)
 elseif i.KeyCode==keys.Left then ws=math.max(ws-2,1)end
 if i.KeyCode==keys.PageUp then jp=math.min(jp+5,200)
 elseif i.KeyCode==keys.PageDown then jp=math.max(jp-5,10)end
 if f then
  if i.KeyCode==keys.Up then s=math.min(s+10,200)
  elseif i.KeyCode==keys.Down then s=math.max(s-10,10)end
 end
end)

-- 常時処理
r.Stepped:Connect(function()if n and p.Character then for _,pt in pairs(p.Character:GetChildren())do if pt:IsA("BasePart")then pt.CanCollide=false end end end end)
r.Heartbeat:Connect(function()
 if ij and p.Character then local h=p.Character:FindFirstChild("Humanoid") if h and h:GetState()==Enum.HumanoidStateType.Jumping then h:ChangeState(Enum.HumanoidStateType.Jumping)end end
 if nk and p.Character then local rt=p.Character:FindFirstChild("HumanoidRootPart") if rt then rt.AssemblyLinearVelocity=Vector3.new(rt.AssemblyLinearVelocity.X,0,rt.AssemblyLinearVelocity.Z)end end
 if nr and p.Character then for _,t in pairs(p.Character:GetDescendants())do if t:IsA("Tool")and t:FindFirstChild("Humanoid")then t.Humanoid.WalkSpeed=0 end end end
 if ik and p.Character then for _,t in pairs(p.Character:GetDescendants())do if t:IsA("Tool")then local s=t:FindFirstChildWhichIsA("LocalScript") if s then s:Destroy()end end end end
 if not f then return end
 local ch=p.Character if not ch then return end
 local rt=ch:FindFirstChild("HumanoidRootPart") if not rt or not bg or not bv then return end
 bg.CFrame=CFrame.lookAt(rt.Position,rt.Position+c.CFrame.LookVector)
 local md=Vector3.new() local cs=u:IsKeyDown(keys.Shift)and ds or s
 if u:IsKeyDown(Enum.KeyCode.W)then md=md+c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.S)then md=md-c.CFrame.LookVector end
 if u:IsKeyDown(Enum.KeyCode.A)then md=md-c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.D)then md=md+c.CFrame.RightVector end
 if u:IsKeyDown(Enum.KeyCode.Space)then md=md+Vector3.new(0,1,0)end
 if u:IsKeyDown(Enum.KeyCode.LeftControl)then md=md+Vector3.new(0,-1,0)end
 bv.Velocity=md.Magnitude>0 and md.Unit*cs or Vector3.new()
end)

-- 閉じるボタン
closeBtn.MouseButton1Click:Connect(function()
 menuOpen=false
 main.Visible=false
end)

-- Mキーで開閉
u.InputBegan:Connect(function(i)
 if i.KeyCode==keys.M then
  menuOpen=not menuOpen
  main.Visible=menuOpen
 end
end)

p.CharacterAdded:Connect(function()if f then f=false if bg then bg:Destroy()end if bv then bv:Destroy()end end updateUI()end)
ps.PlayerAdded:Connect(function(pl)if e then createESP(pl)end end)
updateUI()
