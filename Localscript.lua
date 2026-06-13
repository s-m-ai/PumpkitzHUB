local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("🔴 [Pumpkitz HUB] ล้มเหลวในการโหลด Rayfield!")
    return
end

-- ใส่ไอดีโลโก้ที่มึงยืนยันมาเป๊ะๆ
local LogoID = 75519083960535

local Window = Rayfield:CreateWindow({
   Name = "Pumpkitz HUB V0.0.1",
   Icon = LogoID, -- โลโก้ตรง Header
   LoadingTitle = "Pumpkitz HUB V0.0.1",
   LoadingSubtitle = "by Winning",
   ShowText = "Pumpkitz HUB V0.0.1",
   Theme = "AmberGlow",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = { Enabled = false, FolderName = nil, FileName = "PumpkitzHub_V001" },
   Discord = { Enabled = false, Invite = "noinvitelink", RememberJoins = true },
   KeySystem = false,
})

local function SafeNotify(title, content, duration)
    pcall(function()
        Rayfield:Notify({ 
            Title = title, 
            Content = content, 
            Duration = duration or 3,
            Icon = LogoID -- โลโก้ตรงแจ้งเตือน
        })
    end)
end

SafeNotify("Pumpkitz HUB", "กำลังโหลดระบบ...", 3)

-- =====================================================================
-- 📂 TAB: Main
-- =====================================================================
local MainTab = Window:CreateTab("Main", 7539983780) 
MainTab:CreateSection("Welcome")
MainTab:CreateParagraph({
    Title = "Pumpkitz HUB V0.0.1",
    Content = "ยินดีต้อนรับสู่ Hub ส่วนตัวของคุณ!\nพัฒนาโดย Winning\nระบบกัน Error 100% พร้อมใช้งาน"
})

-- =====================================================================
-- 📂 TAB: Player Customize
-- =====================================================================
local PlayersTab = Window:CreateTab("Player Customize", 7992557371) 
PlayersTab:CreateSection("Players")

PlayersTab:CreateSlider({
    Name = "WalkSpeed", Range = {0, 500}, Increment = 1, Suffix = "", CurrentValue = 16, Flag = "WalkSpeedSlider",
    Callback = function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").WalkSpeed = Value end
    end,
})

PlayersTab:CreateSlider({
    Name = "JumpHeight", Range = {0, 200}, Increment = 1, Suffix = "", CurrentValue = 50, Flag = "JumpHeightSlider",
    Callback = function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").JumpPower = Value end
    end,
})

local NoclipConnection = nil
PlayersTab:CreateToggle({
    Name = "Noclip", CurrentValue = false, Flag = "NoclipToggle",
    Callback = function(Value)
        if Value then
            NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        else
            if NoclipConnection then NoclipConnection:Disconnect(); NoclipConnection = nil end
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end,
})

local espHighlights, espCharAddedConns = {}, {}
local espPlayerAddedConn, espPlayerRemovingConn = nil, nil
local function createHighlight(character)
    if not character or espHighlights[character] then return end
    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(255, 136, 0)
    h.OutlineColor = Color3.fromRGB(255, 165, 0)
    h.FillTransparency = 0.6
    h.OutlineTransparency = 0
    h.Parent = character
    espHighlights[character] = h
end
local function removeHighlight(character)
    if espHighlights[character] then espHighlights[character]:Destroy(); espHighlights[character] = nil end
end

PlayersTab:CreateToggle({
    Name = "ESP", CurrentValue = false, Flag = "ESPToggle",
    Callback = function(Value)
        if Value then
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p.Character then createHighlight(p.Character) end
                if not espCharAddedConns[p] then espCharAddedConns[p] = p.CharacterAdded:Connect(function(c) createHighlight(c) end) end
            end
            espPlayerAddedConn = game.Players.PlayerAdded:Connect(function(p)
                if not espCharAddedConns[p] then espCharAddedConns[p] = p.CharacterAdded:Connect(function(c) createHighlight(c) end) end
                if p.Character then createHighlight(p.Character) end
            end)
            espPlayerRemovingConn = game.Players.PlayerRemoving:Connect(function(p)
                if espCharAddedConns[p] then espCharAddedConns[p]:Disconnect(); espCharAddedConns[p] = nil end
                if p.Character then removeHighlight(p.Character) end
            end)
        else
            if espPlayerAddedConn then espPlayerAddedConn:Disconnect(); espPlayerAddedConn = nil end
            if espPlayerRemovingConn then espPlayerRemovingConn:Disconnect(); espPlayerRemovingConn = nil end
            for _, c in pairs(espCharAddedConns) do c:Disconnect() end
            espCharAddedConns = {}
            for _, h in pairs(espHighlights) do h:Destroy() end
            espHighlights = {}
        end
    end,
})

local antiFlingConn = nil
PlayersTab:CreateToggle({
    Name = "Anti-Fling", CurrentValue = false, Flag = "AntiFlingToggle",
    Callback = function(Value)
        if Value then
            antiFlingConn = game:GetService("RunService").Heartbeat:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local v = char.HumanoidRootPart.AssemblyLinearVelocity
                    if v.Magnitude > 100 then char.HumanoidRootPart.AssemblyLinearVelocity = v.Unit * 50 end
                end
            end)
        else
            if antiFlingConn then antiFlingConn:Disconnect(); antiFlingConn = nil end
        end
    end,
})

-- =====================================================================
-- 📂 TAB: FPS
-- =====================================================================
local FPSTab = Window:CreateTab("FPS", 13612969960) 
FPSTab:CreateSection("Combat")

local fovCircle = nil
pcall(function()
    if Drawing then
        fovCircle = Drawing.new("Circle")
        fovCircle.Visible = false
        fovCircle.Thickness = 2
        fovCircle.Color = Color3.fromRGB(255, 136, 0)
        fovCircle.Filled = false
        fovCircle.Radius = 150
        fovCircle.NumSides = 60
    else
        local gui = Instance.new("ScreenGui")
        gui.Name = "Pumpkitz_FOV"
        gui.ResetOnSpawn = false
        gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 300)
        frame.Position = UDim2.new(0.5, -150, 0.5, -150)
        frame.BackgroundTransparency = 1
        frame.Parent = gui
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 136, 0)
        stroke.Thickness = 2
        stroke.Parent = frame
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = frame
        fovCircle = frame
    end
end)

local aimbotConn = nil
local aimbotStrength = 0.5
local maxDistance = 10000

FPSTab:CreateToggle({
    Name = "Aimbot (Camera Lerp + WallCheck)",
    CurrentValue = false,
    Flag = "AdvancedAimbotToggle",
    Callback = function(Value)
        if Value then
            SafeNotify("Aimbot", "เปิดใช้งาน Camera Lerp แล้ว!", 2)
            pcall(function()
                if type(fovCircle) == "table" and fovCircle.Visible ~= nil then fovCircle.Visible = true
                elseif type(fovCircle) == "userdata" then fovCircle.Enabled = true end
            end)
            
            aimbotConn = game:GetService("RunService").RenderStepped:Connect(function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                local camera = workspace.CurrentCamera
                if not char or not char:FindFirstChild("HumanoidRootPart") or not camera then return end
                
                local closestPlr = nil
                local shortestDist = math.huge
                local cameraPos = camera.CFrame.Position
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = {char}
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude

                for _, target in ipairs(game.Players:GetPlayers()) do
                    if target ~= plr and target.Character then
                        local head = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
                        local humanoid = target.Character:FindFirstChild("Humanoid")
                        
                        if head and humanoid and humanoid.Health > 0 then
                            local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                            if onScreen then
                                local dist = (cameraPos - head.Position).Magnitude
                                if dist < maxDistance and dist < shortestDist then
                                    local origin = cameraPos
                                    local direction = (head.Position - origin).Unit * dist
                                    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
                                    
                                    if not raycastResult or (raycastResult.Instance and raycastResult.Instance:IsDescendantOf(target.Character)) then
                                        shortestDist = dist
                                        closestPlr = target
                                    end
                                end
                            end
                        end
                    end
                end
                
                if closestPlr and closestPlr.Character then
                    local targetHead = closestPlr.Character:FindFirstChild("Head") or closestPlr.Character:FindFirstChild("HumanoidRootPart")
                    if targetHead then
                        local targetCFrame = CFrame.new(cameraPos, targetHead.Position)
                        camera.CFrame = camera.CFrame:Lerp(targetCFrame, aimbotStrength)
                    end
                end
            end)
        else
            if aimbotConn then aimbotConn:Disconnect(); aimbotConn = nil end
            pcall(function()
                if type(fovCircle) == "table" and fovCircle.Visible ~= nil then fovCircle.Visible = false
                elseif type(fovCircle) == "userdata" then fovCircle.Enabled = false end
            end)
            SafeNotify("Aimbot", "ปิดใช้งาน Aimbot แล้ว", 2)
        end
    end,
})

FPSTab:CreateSlider({
    Name = "Aimbot Strength (ความแรง)",
    Range = {0.1, 1.0},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 0.5,
    Flag = "AimbotStrengthSlider",
    Callback = function(Value)
        aimbotStrength = Value
    end,
})

FPSTab:CreateSlider({
    Name = "Max Distance (ระยะไกลสุด)",
    Range = {100, 10000},
    Increment = 100,
    Suffix = " studs",
    CurrentValue = 10000,
    Flag = "AimbotDistanceSlider",
    Callback = function(Value)
        maxDistance = Value
    end,
})

SafeNotify("Pumpkitz HUB", "โหลดครบ! ระบบพร้อมใช้งาน", 4)

