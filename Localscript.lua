-- ====== โหลด WindUI ======
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
if not WindUI then
    warn("❌ โหลด WindUI ไม่สำเร็จ")
    return
end

-- ====== สร้างหน้าต่างหลัก ======
local Window = WindUI:CreateWindow({
    Title = "Pumpkitz V0.0.3",
    Icon = "rbxassetid://75519083960535",
    Author = "By Pumpkitz",
    Folder = "Pumpkitz",
    Size = UDim2.fromOffset(700, 520),
    Transparent = true,
    Theme = "Amber",
    SideBarWidth = 220,
    Resizable = true,
    IconSize = 48,
    TopbarHeight = 48,
    Background = "rbxassetid://75519083960535",
    BackgroundImageTransparency = 0.98,
    User = {
        Enabled = true,
        Anonymous = false
    }
})

-- เพิ่ม Tag
Window:Tag({
    Title = "Version 0.0.3",
    Color = Color3.fromRGB(255, 191, 0)
})

print("✅ สร้าง Window สำเร็จ")

-- ====== ฟังก์ชันสร้าง Tab แบบปลอดภัย ======
local function createTab(title, icon)
    local success, tab = pcall(function()
        return Window:Tab({ Title = title, Icon = icon })
    end)
    if not success then
        warn("❌ สร้าง Tab '" .. title .. "' ล้มเหลว:", tab)
        return nil
    end
    print("✅ สร้าง Tab:", title)
    return tab
end

local function createSection(tab, title)
    if not tab then return nil end
    local success, sec = pcall(function()
        return tab:Section({ Title = title })
    end)
    if not success then
        warn("❌ สร้าง Section '" .. title .. "' ล้มเหลว:", sec)
        return nil
    end
    return sec
end

-- ============================================================
-- TAB 1: อัปเดตใหม่ (ใช้ Button แทน Label)
-- ============================================================
local updateTab = createTab("อัปเดตใหม่", "star")
if updateTab then
    -- Section 1: หัวข้อหลัก
    local sec1 = createSection(updateTab, "📌 เวอร์ชันล่าสุด V.0.0.3")
    if sec1 then
        pcall(function()
            sec1:Button({
                Title = "🎉 ยินดีต้อนรับสู่ Pumpkitz V.0.0.3",
                Icon = "party-popper",
                Callback = function() end
            })
            sec1:Button({
                Title = "📅 อัปเดตล่าสุด: 4 กรกฎาคม 2026",
                Icon = "calendar",
                Callback = function() end
            })
        end)
    end
    
    -- Section 2: อัปเดตหลัก
    local sec2 = createSection(updateTab, "✨ อัปเดตใหม่ในเวอร์ชันนี้")
    if sec2 then
        pcall(function()
            sec2:Button({
                Title = "🔄 เปลี่ยนสคริปต์ Fly เป็นเวอร์ชันใหม่",
                Icon = "wing",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • ใช้ GUI ของตัวเอง",
                Icon = "",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • ปรับความเร็วด้วยปุ่ม + / -",
                Icon = "",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • ปุ่ม UP / DOWN สำหรับขึ้นลง",
                Icon = "",
                Callback = function() end
            })
            
            sec2:Button({
                Title = "",
                Icon = "",
                Callback = function() end
            })
            
            sec2:Button({
                Title = "📍 อัปเดต Tab เทเลพอร์ต",
                Icon = "map-pin",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • ระบบ Float + Tween ไปหาผู้เล่น",
                Icon = "",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • ปรับความเร็วในการเคลื่อนที่ได้",
                Icon = "",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • ปรับความสูงในการลอยได้",
                Icon = "",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • Tween อัตโนมัติเมื่อเป้าหมายเคลื่อนที่",
                Icon = "",
                Callback = function() end
            })
            
            sec2:Button({
                Title = "",
                Icon = "",
                Callback = function() end
            })
            
            sec2:Button({
                Title = "🐛 แก้ไขบั๊กต่างๆ",
                Icon = "bug",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • แก้ไขปัญหาการขึ้นลงของ Float",
                Icon = "",
                Callback = function() end
            })
            sec2:Button({
                Title = "   • ปรับปรุงระบบ Tween ให้เนียนขึ้น",
                Icon = "",
                Callback = function() end
            })
        end)
    end
    
    -- Section 3: การเปลี่ยนแปลงอื่นๆ
    local sec3 = createSection(updateTab, "📋 การเปลี่ยนแปลงอื่นๆ")
    if sec3 then
        pcall(function()
            sec3:Button({
                Title = "📝 อัปเดต UI ให้ใช้งานง่ายขึ้น",
                Icon = "pencil",
                Callback = function() end
            })
            sec3:Button({
                Title = "🔧 ปรับปรุงประสิทธิภาพโดยรวม",
                Icon = "wrench",
                Callback = function() end
            })
            sec3:Button({
                Title = "⚡ เพิ่มความเสถียรของระบบ",
                Icon = "zap",
                Callback = function() end
            })
        end)
    end
    
    -- Section 4: หมายเหตุ
    local sec4 = createSection(updateTab, "📝 หมายเหตุ")
    if sec4 then
        pcall(function()
            sec4:Button({
                Title = "หากพบปัญหาแจ้งได้ที่ Discord",
                Icon = "info",
                Callback = function() end
            })
            sec4:Button({
                Title = "ขอให้สนุกกับการใช้งานครับ! 😊",
                Icon = "smile",
                Callback = function() end
            })
        end)
    end
end

-- ============================================================
-- TAB 2: หน้าหลัก (Home)
-- ============================================================
local homeTab = createTab("หน้าหลัก", "house")
if homeTab then
    local sec = createSection(homeTab, "การตั้งค่าทั่วไป")
    if sec then
        pcall(function()
            sec:Slider({
                Title = "ปรับ FOV",
                Icon = "eye",
                Value = { Min = 10, Max = 120, Default = 70 },
                Step = 1,
                Callback = function(v) workspace.CurrentCamera.FieldOfView = v end
            })
            sec:Button({
                Title = "รีเซ็ท FOV",
                Icon = "rotate-ccw",
                Callback = function()
                    workspace.CurrentCamera.FieldOfView = 70
                    WindUI:Notify({ Title = "รีเซ็ท FOV", Content = "FOV กลับเป็น 70", Duration = 2 })
                end
            })
            sec:Toggle({
                Title = "Remove Fog",
                Icon = "cloud",
                Default = false,
                Callback = function(state)
                    local Lighting = game:GetService("Lighting")
                    if state then
                        Lighting.FogEnd = 1000000
                        Lighting.FogStart = 0
                    else
                        Lighting.FogEnd = 100000
                        Lighting.FogStart = 0
                    end
                end
            })
        end)
    end
end

-- ============================================================
-- TAB 3: ผู้เล่น (Player) - เพิ่มปุ่มล่องหน
-- ============================================================
local playerTab = createTab("ผู้เล่น", "user")
if playerTab then
    local sec = createSection(playerTab, "การปรับแต่งตัวละคร")
    if sec then
        pcall(function()
            sec:Slider({
                Title = "WalkSpeed",
                Icon = "zap",
                Value = { Min = 16, Max = 500, Default = 16 },
                Step = 1,
                Callback = function(v)
                    local plr = game.Players.LocalPlayer
                    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                        plr.Character.Humanoid.WalkSpeed = v
                    end
                end
            })
            sec:Slider({
                Title = "JumpPower",
                Icon = "arrow-up",
                Value = { Min = 50, Max = 500, Default = 50 },
                Step = 1,
                Callback = function(v)
                    local plr = game.Players.LocalPlayer
                    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                        plr.Character.Humanoid.JumpPower = v
                    end
                end
            })
            sec:Button({
                Title = "Fly (บินได้)",
                Icon = "wing",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/PumpkitzHUB/refs/heads/main/Fly.lua"))()
                    WindUI:Notify({ Title = "Fly", Content = "เปิดโหมดบินแล้ว", Duration = 2 })
                end
            })
            -- ปุ่มล่องหน (เพิ่มใหม่)
            sec:Button({
                Title = "ล่องหน (Invisible)",
                Icon = "eye-off",
                Callback = function()
                    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-GUI-128871"))()
                    WindUI:Notify({ Title = "ล่องหน", Content = "เปิดโหมดล่องหนแล้ว!", Duration = 2 })
                end
            })
            sec:Toggle({
                Title = "Noclip",
                Icon = "shield",
                Default = false,
                Callback = function(state)
                    _G.NoclipEnabled = state
                    local plr = game.Players.LocalPlayer
                    if state then
                        local conn
                        conn = game:GetService("RunService").Stepped:Connect(function()
                            if _G.NoclipEnabled and plr.Character then
                                for _, part in pairs(plr.Character:GetDescendants()) do
                                    if part:IsA("BasePart") then part.CanCollide = false end
                                end
                            end
                        end)
                        _G._noclipConnection = conn
                    else
                        if _G._noclipConnection then _G._noclipConnection:Disconnect() end
                        if plr.Character then
                            for _, part in pairs(plr.Character:GetDescendants()) do
                                if part:IsA("BasePart") then part.CanCollide = true end
                            end
                        end
                    end
                end
            })
            sec:Toggle({
                Title = "ESP (Highlight)",
                Icon = "eye",
                Default = false,
                Callback = function(state)
                    _G.ESPEnabled = state
                    local plr = game.Players.LocalPlayer
                    local highlights = {}
                    local function addHighlight(p)
                        if p ~= plr and p.Character and not highlights[p] then
                            local h = Instance.new("Highlight")
                            h.FillColor = Color3.fromRGB(255,165,0)
                            h.OutlineColor = Color3.fromRGB(255,165,0)
                            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            h.Parent = p.Character
                            highlights[p] = h
                        end
                    end
                    local function removeHighlight(p)
                        if highlights[p] then
                            highlights[p]:Destroy()
                            highlights[p] = nil
                        end
                    end
                    if state then
                        for _, p in pairs(game.Players:GetPlayers()) do addHighlight(p) end
                        _G._playerAddedConn = game.Players.PlayerAdded:Connect(function(p)
                            p.CharacterAdded:Connect(function()
                                if _G.ESPEnabled then addHighlight(p) end
                            end)
                            if p.Character then addHighlight(p) end
                        end)
                        _G._playerRemovingConn = game.Players.PlayerRemoving:Connect(function(p)
                            removeHighlight(p)
                        end)
                    else
                        if _G._playerAddedConn then _G._playerAddedConn:Disconnect() end
                        if _G._playerRemovingConn then _G._playerRemovingConn:Disconnect() end
                        for _, h in pairs(highlights) do h:Destroy() end
                        highlights = {}
                    end
                end
            })
        end)
    end
end

-- ============================================================
-- TAB 4: เซิร์ฟเวอร์ (Server)
-- ============================================================
local serverTab = createTab("เซิร์ฟเวอร์", "server")
if serverTab then
    local sec = createSection(serverTab, "การตั้งค่าเซิร์ฟเวอร์")
    if sec then
        pcall(function()
            sec:Toggle({
                Title = "Fullbright",
                Icon = "sun",
                Default = false,
                Callback = function(state)
                    local Lighting = game:GetService("Lighting")
                    if state then
                        Lighting.Brightness = 2
                        Lighting.ClockTime = 14
                        Lighting.FogEnd = 100000
                        Lighting.GlobalShadows = false
                    else
                        Lighting.Brightness = 1
                        Lighting.ClockTime = 12
                        Lighting.FogEnd = 100000
                        Lighting.GlobalShadows = true
                    end
                end
            })
        end)
    end
end

-- ============================================================
-- TAB 5: FPS (Aimbot)
-- ============================================================
local fpsTab = createTab("FPS", "crosshair")
if fpsTab then
    local sec = createSection(fpsTab, "ระบบเล็งอัตโนมัติ")
    if sec then
        pcall(function()
            sec:Toggle({
                Title = "Aimbot",
                Icon = "crosshair",
                Default = false,
                Callback = function(state)
                    _G.AimbotEnabled = state
                    local plr = game.Players.LocalPlayer
                    local cam = workspace.CurrentCamera
                    if state then
                        local function getClosest()
                            local closest, dist = nil, math.huge
                            for _, p in pairs(game.Players:GetPlayers()) do
                                if p ~= plr and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("HumanoidRootPart") then
                                    if p.Character.Humanoid.Health > 0 then
                                        local d = (p.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                                        if d < dist then dist = d; closest = p end
                                    end
                                end
                            end
                            return closest
                        end
                        local conn
                        conn = game:GetService("RunService").RenderStepped:Connect(function()
                            if not _G.AimbotEnabled then return end
                            if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
                            local target = getClosest()
                            if target and target.Character and target.Character:FindFirstChild("Head") then
                                local targetPos = target.Character.Head.Position
                                local currentCF = cam.CFrame
                                local targetCF = CFrame.new(currentCF.Position, targetPos)
                                cam.CFrame = currentCF:Lerp(targetCF, _G.AimbotStrength or 0.5)
                            end
                        end)
                        _G._aimbotConnection = conn
                    else
                        if _G._aimbotConnection then _G._aimbotConnection:Disconnect() end
                    end
                end
            })
            sec:Toggle({
                Title = "ตรวจสอบทีม",
                Icon = "users",
                Default = true,
                Callback = function(state)
                    _G.AimbotCheckTeam = state
                end
            })
            sec:Slider({
                Title = "ความแรงล็อกหัว",
                Icon = "gauge",
                Value = { Min = 0, Max = 1, Default = 0.5 },
                Step = 0.01,
                Callback = function(v) _G.AimbotStrength = v end
            })
        end)
    end
end

-- ============================================================
-- TAB 6: สคริปต์อื่นๆ (Scripts)
-- ============================================================
local scriptTab = createTab("สคริปต์อื่นๆ", "code")
if scriptTab then
    local sec = createSection(scriptTab, "โหลดสคริปต์เพิ่มเติม")
    if sec then
        pcall(function()
            sec:Button({
                Title = "เสกของ",
                Icon = "wand",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/Sekloso/refs/heads/main/Sekloso.lua"))()
                    WindUI:Notify({ Title = "โหลดเสกของ", Content = "เรียบร้อย", Duration = 2 })
                end
            })
            sec:Button({
                Title = "MM2",
                Icon = "sword",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/PumpkitzHUB/refs/heads/main/Mm2.lua"))()
                    WindUI:Notify({ Title = "โหลด MM2", Content = "เรียบร้อย", Duration = 2 })
                end
            })
            sec:Button({
                Title = "ยิงปืน+",
                Icon = "target",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/PumpkitzHUB/refs/heads/main/Aimbot.lua"))()
                    WindUI:Notify({ Title = "โหลดยิงปืน+", Content = "เรียบร้อย", Duration = 2 })
                end
            })
        end)
    end
end

-- ============================================================
-- TAB 7: เทเลพอร์ต (Teleport)
-- ============================================================
local teleportTab = createTab("เทเลพอร์ต", "map-pin")
if teleportTab then
    local sec = createSection(teleportTab, "ระบบ Float + Tween")
    if sec then
        pcall(function()
            -- ตัวแปรสำหรับ Dropdown
            local targetDropdown = nil
            local function updateList()
                local list = {}
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer then
                        table.insert(list, p.Name)
                    end
                end
                return list
            end
            targetDropdown = sec:Dropdown({
                Title = "เลือกผู้เล่น",
                Icon = "users",
                Values = updateList(),
                Value = "",
                Callback = function(v)
                    _G.TeleportTarget = v
                end
            })
            -- รีเฟรชรายชื่อ
            game.Players.PlayerAdded:Connect(function()
                task.wait(0.5)
                if targetDropdown then
                    local cur = _G.TeleportTarget or ""
                    local newList = updateList()
                    targetDropdown:SetValues(newList)
                    if table.find(newList, cur) then
                        targetDropdown:SetValue(cur)
                    else
                        targetDropdown:SetValue("")
                        _G.TeleportTarget = ""
                    end
                end
            end)
            game.Players.PlayerRemoving:Connect(function()
                task.wait(0.5)
                if targetDropdown then
                    local cur = _G.TeleportTarget or ""
                    local newList = updateList()
                    targetDropdown:SetValues(newList)
                    if table.find(newList, cur) then
                        targetDropdown:SetValue(cur)
                    else
                        targetDropdown:SetValue("")
                        _G.TeleportTarget = ""
                    end
                end
            end)

            -- ฟังก์ชัน Float
            local floatConn = nil
            local tween = nil
            local isFloating = false
            local function enableFloat()
                if isFloating then return end
                local plr = game.Players.LocalPlayer
                if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = plr.Character.HumanoidRootPart
                local hum = plr.Character:FindFirstChild("Humanoid")
                if hum then hum.PlatformStand = true; hum.Sit = true end
                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(1,1,1)*100000
                bp.Position = hrp.Position + Vector3.new(0, _G.FloatHeight or 5, 0)
                bp.P = 10000; bp.D = 2000
                bp.Name = "FloatPosition"
                bp.Parent = hrp
                local bg = Instance.new("BodyGyro")
                bg.MaxTorque = Vector3.new(1,1,1)*100000
                bg.CFrame = hrp.CFrame
                bg.P = 10000; bg.D = 500
                bg.Name = "FloatGyro"
                bg.Parent = hrp
                isFloating = true
            end
            local function disableFloat()
                if not isFloating then return end
                local plr = game.Players.LocalPlayer
                if not plr.Character then return end
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChild("Humanoid")
                if hrp then
                    for _, c in pairs(hrp:GetChildren()) do
                        if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
                            c:Destroy()
                        end
                    end
                end
                if hum then hum.PlatformStand = false; hum.Sit = false end
                isFloating = false
            end
            local function tweenToTarget()
                if not _G.FloatToTarget then return end
                local plr = game.Players.LocalPlayer
                if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then disableFloat(); return end
                local target = game.Players:FindFirstChild(_G.TeleportTarget)
                if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = plr.Character.HumanoidRootPart
                local targetPos = target.Character.HumanoidRootPart.Position
                local distance = (targetPos - hrp.Position).Magnitude
                if distance < 1 then return end
                if tween then tween:Cancel(); tween = nil end
                local targetCF = CFrame.new(targetPos + Vector3.new(0, _G.FloatHeight or 5, 0))
                local duration = math.max(distance / (_G.FloatSpeed or 16), 0.2)
                local info = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                tween = game:GetService("TweenService"):Create(hrp, info, {CFrame = targetCF})
                tween:Play()
                tween.Completed:Connect(function()
                    tween = nil
                    if isFloating and hrp then
                        local bp = hrp:FindFirstChild("FloatPosition")
                        if bp then bp.Position = hrp.Position end
                    end
                end)
            end
            local function startFloat()
                if floatConn then floatConn:Disconnect(); floatConn = nil end
                if not _G.TeleportTarget or _G.TeleportTarget == "" then
                    WindUI:Notify({ Title = "Float", Content = "เลือกผู้เล่นก่อน", Duration = 2 })
                    return
                end
                local target = game.Players:FindFirstChild(_G.TeleportTarget)
                if not target then
                    WindUI:Notify({ Title = "Float", Content = "ไม่พบผู้เล่น", Duration = 2 })
                    return
                end
                enableFloat()
                tweenToTarget()
                WindUI:Notify({ Title = "Float", Content = "กำลังลอยไปหา "..target.Name, Duration = 2 })
                floatConn = game:GetService("RunService").Heartbeat:Connect(function()
                    if not _G.FloatToTarget then return end
                    local plr = game.Players.LocalPlayer
                    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then disableFloat(); return end
                    local target = game.Players:FindFirstChild(_G.TeleportTarget)
                    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = plr.Character.HumanoidRootPart
                    local targetPos = target.Character.HumanoidRootPart.Position
                    local distance = (targetPos - hrp.Position).Magnitude
                    if distance > 3 and not tween then
                        tweenToTarget()
                    end
                    if isFloating and hrp then
                        local bp = hrp:FindFirstChild("FloatPosition")
                        if bp then bp.Position = hrp.Position end
                    end
                end)
            end
            local function stopFloat()
                if floatConn then floatConn:Disconnect(); floatConn = nil end
                if tween then tween:Cancel(); tween = nil end
                disableFloat()
                WindUI:Notify({ Title = "Float", Content = "หยุดลอยแล้ว", Duration = 2 })
            end

            sec:Toggle({
                Title = "Float + Tween ไปหา",
                Icon = "move",
                Default = false,
                Callback = function(state)
                    _G.FloatToTarget = state
                    if state then startFloat() else stopFloat() end
                end
            })
            sec:Slider({
                Title = "ความเร็ว Tween",
                Icon = "gauge",
                Value = { Min = 5, Max = 50, Default = 16 },
                Step = 1,
                Callback = function(v) _G.FloatSpeed = v end
            })
            sec:Slider({
                Title = "ความสูงในการลอย",
                Icon = "arrow-up",
                Value = { Min = 1, Max = 20, Default = 5 },
                Step = 1,
                Callback = function(v)
                    _G.FloatHeight = v
                    if isFloating then
                        local plr = game.Players.LocalPlayer
                        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = plr.Character.HumanoidRootPart
                            local bp = hrp:FindFirstChild("FloatPosition")
                            if bp then bp.Position = hrp.Position end
                        end
                    end
                end
            })
            sec:Button({
                Title = "หยุด Float ทันที",
                Icon = "stop-circle",
                Callback = function()
                    _G.FloatToTarget = false
                    stopFloat()
                    WindUI:Notify({ Title = "หยุด Float", Content = "หยุดแล้ว", Duration = 2 })
                end
            })
            sec:Button({
                Title = "Teleport ทันที",
                Icon = "user-plus",
                Callback = function()
                    if not _G.TeleportTarget or _G.TeleportTarget == "" then
                        WindUI:Notify({ Title = "Teleport", Content = "เลือกผู้เล่นก่อน", Duration = 2 })
                        return
                    end
                    local target = game.Players:FindFirstChild(_G.TeleportTarget)
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        local plr = game.Players.LocalPlayer
                        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            local pos = target.Character.HumanoidRootPart.Position + Vector3.new(0, _G.FloatHeight or 5, 0)
                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
                            WindUI:Notify({ Title = "Teleport", Content = "ไปหา "..target.Name, Duration = 2 })
                        end
                    else
                        WindUI:Notify({ Title = "Teleport", Content = "ไม่พบผู้เล่น", Duration = 2 })
                    end
                end
            })
        end)
    end
end

-- ====== แจ้งเตือนสำเร็จ ======
WindUI:Notify({
    Title = "Pumpkitz V0.0.3",
    Content = "โหลด GUI สำเร็จ! (7 Tabs)",
    Duration = 5
})
print("✅ Pumpkitz V0.0.3 ทำงานครบทุก Tab")
