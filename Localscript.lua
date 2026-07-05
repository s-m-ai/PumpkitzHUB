-- ====== โหลด WindUI ======
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
if not WindUI then
    warn("❌ โหลด WindUI ไม่สำเร็จ")
    return
end

-- ====== สร้างหน้าต่างหลัก ======
local Window = WindUI:CreateWindow({
    Title = "Pumpkitz HUB",
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
    Title = "Version 0.0.6",
    Color = Color3.fromRGB(255, 191, 0)
})

print("✅ สร้าง Window สำเร็จ")

-- ====== ฟังก์ชันสร้าง Tab ======
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
-- ตัวแปรเริ่มต้น
-- ============================================================
_G.TweenMaxSpeed = 50
_G.FloatHeight = 5
_G.FloatToTarget = false
_G.TeleportTarget = ""
_G.TweenEnabled = false
_G.ESPColor = Color3.fromRGB(255, 165, 0)
_G.ESPTransparency = 0.5
_G.ESPEnabled = false
_G.NoclipEnabled = false
_G.AimbotEnabled = false
_G.AimbotStrength = 0.5
_G.AimbotCheckTeam = true
_G.GodModeEnabled = false
_G.InfiniteJumpEnabled = false

-- ตัวแปรสำหรับเก็บ Highlight
local espHighlights = {}
local playerAddedConn = nil
local playerRemovingConn = nil

-- ตัวแปรสำหรับ God Mode
_G._godModeConnection = nil
_G._godModeCharAdded = nil

-- ============================================================
-- ฟังก์ชัน ESP (ใช้ Highlight)
-- ============================================================
local function UpdateESP()
    if not _G.ESPEnabled then return end
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer and espHighlights[plr] then
            espHighlights[plr].FillColor = _G.ESPColor
            espHighlights[plr].OutlineColor = _G.ESPColor
            espHighlights[plr].FillTransparency = _G.ESPTransparency
            espHighlights[plr].OutlineTransparency = _G.ESPTransparency
        end
    end
end

local function addHighlight(plr)
    if not _G.ESPEnabled then return end
    if plr == game.Players.LocalPlayer then return end
    if not plr.Character then return end
    if espHighlights[plr] then 
        espHighlights[plr]:Destroy()
        espHighlights[plr] = nil
    end
    
    local h = Instance.new("Highlight")
    h.FillColor = _G.ESPColor
    h.OutlineColor = _G.ESPColor
    h.FillTransparency = _G.ESPTransparency
    h.OutlineTransparency = _G.ESPTransparency
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = plr.Character
    espHighlights[plr] = h
end

local function removeHighlight(plr)
    if espHighlights[plr] then
        espHighlights[plr]:Destroy()
        espHighlights[plr] = nil
    end
end

local function updateAllHighlights()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer then
            if _G.ESPEnabled then
                addHighlight(plr)
            else
                removeHighlight(plr)
            end
        end
    end
end

local function setupESPConnections()
    if playerAddedConn then playerAddedConn:Disconnect() end
    if playerRemovingConn then playerRemovingConn:Disconnect() end
    
    playerAddedConn = game.Players.PlayerAdded:Connect(function(plr)
        if _G.ESPEnabled then
            plr.CharacterAdded:Connect(function()
                if _G.ESPEnabled then addHighlight(plr) end
            end)
            if plr.Character then addHighlight(plr) end
        end
    end)
    
    playerRemovingConn = game.Players.PlayerRemoving:Connect(function(plr)
        removeHighlight(plr)
    end)
end

-- ============================================================
-- ฟังก์ชัน God Mode
-- ============================================================
local function applyGodMode()
    local plr = game.Players.LocalPlayer
    if not _G.GodModeEnabled then return end
    if not plr.Character then return end
    local humanoid = plr.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    
    if _G._godModeConnection then
        _G._godModeConnection:Disconnect()
    end
    _G._godModeConnection = humanoid.HealthChanged:Connect(function(health)
        if health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

-- ============================================================
-- ฟังก์ชัน Infinite Jump (จาก Olemad Admin)
-- ============================================================
local function setupInfiniteJump()
    local plr = game.Players.LocalPlayer
    
    -- ถ้ามี Connection เก่า ให้ลบก่อน
    if _G._infiniteJumpConnection then
        _G._infiniteJumpConnection:Disconnect()
        _G._infiniteJumpConnection = nil
    end
    
    if not _G.InfiniteJumpEnabled then return end
    
    -- ใช้ JumpRequest เพื่อตรวจจับการกระโดด (จาก Olemad)
    _G._infiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfiniteJumpEnabled then
            local plr = game.Players.LocalPlayer
            if plr and plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end)
end

-- ============================================================
-- TAB 1: อัปเดตใหม่ (V0.0.6)
-- ============================================================
local updateTab = createTab("อัปเดตใหม่", "star")
if updateTab then
    local sec1 = createSection(updateTab, "📌 เวอร์ชันล่าสุด V.0.0.6")
    if sec1 then
        pcall(function()
            sec1:Button({ Title = "🎉 ยินดีต้อนรับสู่ Pumpkitz HUB V.0.0.6", Icon = "party-popper", Callback = function() end })
            sec1:Button({ Title = "📅 อัปเดตล่าสุด: 5 กรกฎาคม 2026", Icon = "calendar", Callback = function() end })
        end)
    end
    
    local sec2 = createSection(updateTab, "✨ อัปเดตใหม่ในเวอร์ชันนี้")
    if sec2 then
        pcall(function()
            sec2:Button({ Title = "🔄 ปรับปรุง Tab ป่วน", Icon = "sparkle", Callback = function() end })
            sec2:Button({ Title = "   • ปุ่ม 'เตะปลิว (ภายนอก)' เรียก GHSX Fling", Icon = "", Callback = function() end })
            sec2:Button({ Title = "   • ปุ่ม 'กระโดดเตะ (ภายนอก)' เรียก DropKick", Icon = "", Callback = function() end })
            sec2:Button({ Title = "", Icon = "", Callback = function() end })
            sec2:Button({ Title = "🆕 เพิ่ม Infinite Jump ในพลังวิเศษ", Icon = "arrow-up", Callback = function() end })
            sec2:Button({ Title = "   • ใช้ระบบ JumpRequest จาก Olemad Admin", Icon = "", Callback = function() end })
            sec2:Button({ Title = "", Icon = "", Callback = function() end })
            sec2:Button({ Title = "🆕 เพิ่ม Section Tools ในเซิร์ฟเวอร์", Icon = "wrench", Callback = function() end })
            sec2:Button({ Title = "   • Infinite Yield - Admin Command", Icon = "", Callback = function() end })
            sec2:Button({ Title = "   • Dex Explorer - Explorer Game", Icon = "", Callback = function() end })
            sec2:Button({ Title = "   • Simple Spy - Spy Remote Events", Icon = "", Callback = function() end })
            sec2:Button({ Title = "   • Hydroxide - Debug Tool", Icon = "", Callback = function() end })
            sec2:Button({ Title = "", Icon = "", Callback = function() end })
            sec2:Button({ Title = "⬆️ อัปเดตเวอร์ชันเป็น V.0.0.6", Icon = "arrow-up", Callback = function() end })
        end)
    end
end

-- ============================================================
-- TAB 2: หน้าหลัก
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
-- TAB 3: ผู้เล่น
-- ============================================================
local playerTab = createTab("ผู้เล่น", "user")
if playerTab then
    local sec1 = createSection(playerTab, "⚡ ปรับตัวละคร")
    if sec1 then
        pcall(function()
            sec1:Slider({
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
            sec1:Slider({
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
        end)
    end
    
    local sec2 = createSection(playerTab, "✨ พลังวิเศษ")
    if sec2 then
        pcall(function()
            sec2:Button({
                Title = "Fly (บินได้)",
                Icon = "wing",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/PumpkitzHUB/refs/heads/main/Fly.lua"))()
                    WindUI:Notify({ Title = "Fly", Content = "เปิดโหมดบินแล้ว", Duration = 2 })
                end
            })
            sec2:Button({
                Title = "ล่องหน (Invisible)",
                Icon = "eye-off",
                Callback = function()
                    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-GUI-128871"))()
                    WindUI:Notify({ Title = "ล่องหน", Content = "เปิดโหมดล่องหนแล้ว!", Duration = 2 })
                end
            })
            
            -- ====== Infinite Jump (จาก Olemad Admin) ======
            sec2:Toggle({
                Title = "Infinite Jump (กระโดดไม่จำกัด)",
                Icon = "arrow-up",
                Default = false,
                Callback = function(state)
                    _G.InfiniteJumpEnabled = state
                    if state then
                        setupInfiniteJump()
                        WindUI:Notify({ 
                            Title = "Infinite Jump", 
                            Content = "เปิดแล้ว! กระโดดได้ไม่จำกัด", 
                            Duration = 2 
                        })
                    else
                        if _G._infiniteJumpConnection then
                            _G._infiniteJumpConnection:Disconnect()
                            _G._infiniteJumpConnection = nil
                        end
                        WindUI:Notify({ 
                            Title = "Infinite Jump", 
                            Content = "ปิดแล้ว! กระโดดปกติ", 
                            Duration = 2 
                        })
                    end
                end
            })
            
            sec2:Toggle({
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
            sec2:Toggle({
                Title = "โหมดพระเจ้า (God Mode)",
                Icon = "shield",
                Default = false,
                Callback = function(state)
                    _G.GodModeEnabled = state
                    local plr = game.Players.LocalPlayer
                    
                    if state then
                        local function applyGodModeNow()
                            if not plr.Character then return end
                            local humanoid = plr.Character:FindFirstChild("Humanoid")
                            if not humanoid then return end
                            
                            humanoid.MaxHealth = math.huge
                            humanoid.Health = math.huge
                            humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                            
                            if _G._godModeConnection then
                                _G._godModeConnection:Disconnect()
                            end
                            _G._godModeConnection = humanoid.HealthChanged:Connect(function(health)
                                if health < humanoid.MaxHealth then
                                    humanoid.Health = humanoid.MaxHealth
                                end
                            end)
                        end
                        
                        applyGodModeNow()
                        
                        if plr.Character then
                            applyGodModeNow()
                        end
                        
                        if _G._godModeCharAdded then
                            _G._godModeCharAdded:Disconnect()
                        end
                        _G._godModeCharAdded = plr.CharacterAdded:Connect(function()
                            task.wait(0.5)
                            applyGodModeNow()
                        end)
                        
                        WindUI:Notify({ 
                            Title = "โหมดพระเจ้า", 
                            Content = "เปิดแล้ว! คุณจะไม่มีวันตาย", 
                            Duration = 2 
                        })
                    else
                        if plr.Character then
                            local humanoid = plr.Character:FindFirstChild("Humanoid")
                            if humanoid then
                                humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                                humanoid.MaxHealth = 100
                                humanoid.Health = 100
                            end
                        end
                        
                        if _G._godModeConnection then
                            _G._godModeConnection:Disconnect()
                            _G._godModeConnection = nil
                        end
                        if _G._godModeCharAdded then
                            _G._godModeCharAdded:Disconnect()
                            _G._godModeCharAdded = nil
                        end
                        
                        WindUI:Notify({ 
                            Title = "โหมดพระเจ้า", 
                            Content = "ปิดแล้ว! กลับสู่สภาวะปกติ", 
                            Duration = 2 
                        })
                    end
                end
            })
        end)
    end
    
    local sec3 = createSection(playerTab, "👁️ ตาเทพ")
    if sec3 then
        pcall(function()
            sec3:Toggle({
                Title = "เปิด ESP",
                Icon = "eye",
                Default = false,
                Callback = function(state)
                    _G.ESPEnabled = state
                    if state then
                        updateAllHighlights()
                        setupESPConnections()
                        WindUI:Notify({ Title = "ESP", Content = "เปิด ESP แล้ว!", Duration = 2 })
                    else
                        for _, plr in pairs(game.Players:GetPlayers()) do
                            removeHighlight(plr)
                        end
                        if playerAddedConn then playerAddedConn:Disconnect() end
                        if playerRemovingConn then playerRemovingConn:Disconnect() end
                        WindUI:Notify({ Title = "ESP", Content = "ปิด ESP แล้ว", Duration = 2 })
                    end
                end
            })
            sec3:Colorpicker({
                Title = "เลือกสีและปรับความใส ESP",
                Icon = "palette",
                Default = _G.ESPColor,
                Transparency = _G.ESPTransparency,
                Callback = function(color, transparency)
                    _G.ESPColor = color
                    _G.ESPTransparency = transparency
                    if _G.ESPEnabled then
                        UpdateESP()
                    end
                    WindUI:Notify({ Title = "ปรับ ESP", Content = "สีและความใสอัปเดตแล้ว", Duration = 1 })
                end
            })
        end)
    end
end

-- ============================================================
-- TAB 4: เซิร์ฟเวอร์ (เพิ่ม Section Tools)
-- ============================================================
local serverTab = createTab("เซิร์ฟเวอร์", "server")
if serverTab then
    local sec1 = createSection(serverTab, "การตั้งค่าเซิร์ฟเวอร์")
    if sec1 then
        pcall(function()
            sec1:Toggle({
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
    
    local sec2 = createSection(serverTab, "📷 มุมมองกล้อง")
    if sec2 then
        pcall(function()
            sec2:Button({
                Title = "ปรับมุมมองบุคคลที่ 1",
                Icon = "eye",
                Callback = function()
                    local player = game.Players.LocalPlayer
                    player.CameraMode = Enum.CameraMode.LockFirstPerson
                    player.CameraMinZoomDistance = 0.5
                    player.CameraMaxZoomDistance = 0.5
                    WindUI:Notify({ Title = "มุมมองกล้อง", Content = "เปลี่ยนเป็นบุคคลที่ 1", Duration = 2 })
                end
            })
            sec2:Button({
                Title = "ปรับมุมมองบุคคลที่ 3",
                Icon = "eye",
                Callback = function()
                    local player = game.Players.LocalPlayer
                    player.CameraMode = Enum.CameraMode.Classic
                    player.CameraMinZoomDistance = 6
                    player.CameraMaxZoomDistance = 50
                    WindUI:Notify({ Title = "มุมมองกล้อง", Content = "เปลี่ยนเป็นบุคคลที่ 3", Duration = 2 })
                end
            })
        end)
    end
    
    -- ====== Section Tools (จาก Olemad Admin) ======
    local sec3 = createSection(serverTab, "🔧 Tools")
    if sec3 then
        pcall(function()
            sec3:Button({
                Title = "Infinite Yield",
                Icon = "terminal",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
                    WindUI:Notify({ Title = "Infinite Yield", Content = "โหลด Admin Command สำเร็จ!", Duration = 3 })
                end
            })
            sec3:Button({
                Title = "Dex Explorer",
                Icon = "folder-tree",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
                    WindUI:Notify({ Title = "Dex Explorer", Content = "โหลด Dex Explorer สำเร็จ!", Duration = 3 })
                end
            })
            sec3:Button({
                Title = "Simple Spy",
                Icon = "radar",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
                    WindUI:Notify({ Title = "Simple Spy", Content = "โหลด Simple Spy สำเร็จ!", Duration = 3 })
                end
            })
            sec3:Button({
                Title = "Hydroxide",
                Icon = "bug",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/init.lua"))()
                    WindUI:Notify({ Title = "Hydroxide", Content = "โหลด Hydroxide สำเร็จ!", Duration = 3 })
                end
            })
        end)
    end
end

-- ============================================================
-- TAB 5: FPS
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
-- TAB 6: สคริปต์อื่นๆ
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
-- TAB 7: เทเลพอร์ต
-- ============================================================
local teleportTab = createTab("เทเลพอร์ต", "map-pin")
if teleportTab then
    local sec = createSection(teleportTab, "ระบบ Float + Tween")
    if sec then
        pcall(function()
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
            
            local function refreshDropdown()
                if not targetDropdown then return end
                local currentValue = _G.TeleportTarget or ""
                local newList = updateList()
                targetDropdown:SetValues(newList)
                if table.find(newList, currentValue) then
                    targetDropdown:SetValue(currentValue)
                else
                    targetDropdown:SetValue("")
                    _G.TeleportTarget = ""
                end
            end
            
            game.Players.PlayerAdded:Connect(function()
                task.wait(0.5)
                refreshDropdown()
            end)
            game.Players.PlayerRemoving:Connect(function()
                task.wait(0.5)
                refreshDropdown()
            end)
            task.spawn(function()
                while task.wait(5) do
                    refreshDropdown()
                end
            end)

            local floatConn = nil
            local tween = nil
            local isFloating = false
            
            local function enableFloat()
                if isFloating then return end
                local plr = game.Players.LocalPlayer
                if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = plr.Character.HumanoidRootPart
                local hum = plr.Character:FindFirstChild("Humanoid")
                if hum then
                    hum.PlatformStand = true
                    hum.Sit = true
                end
                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(1,1,1)*100000
                bp.Position = hrp.Position + Vector3.new(0, _G.FloatHeight or 5, 0)
                bp.P = 10000
                bp.D = 2000
                bp.Name = "FloatPosition"
                bp.Parent = hrp
                local bg = Instance.new("BodyGyro")
                bg.MaxTorque = Vector3.new(1,1,1)*100000
                bg.CFrame = hrp.CFrame
                bg.P = 10000
                bg.D = 500
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
                if hum then
                    hum.PlatformStand = false
                    hum.Sit = false
                end
                isFloating = false
            end
            
            local function tweenToTarget()
                if not _G.FloatToTarget then return end
                local plr = game.Players.LocalPlayer
                if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
                    disableFloat()
                    return
                end
                local target = game.Players:FindFirstChild(_G.TeleportTarget)
                if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
                local hrp = plr.Character.HumanoidRootPart
                local targetPos = target.Character.HumanoidRootPart.Position
                local distance = (targetPos - hrp.Position).Magnitude
                if distance < 1 then return end
                if tween then
                    tween:Cancel()
                    tween = nil
                end
                local targetCF = CFrame.new(targetPos + Vector3.new(0, _G.FloatHeight or 5, 0))
                local currentSpeed = _G.TweenMaxSpeed or 50
                local duration = math.max(distance / currentSpeed, 0.1)
                local info = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                tween = game:GetService("TweenService"):Create(hrp, info, {CFrame = targetCF})
                tween:Play()
                tween.Completed:Connect(function()
                    tween = nil
                    if isFloating and hrp then
                        local bp = hrp:FindFirstChild("FloatPosition")
                        if bp then
                            bp.Position = hrp.Position
                        end
                    end
                end)
            end
            
            local function startFloat()
                if floatConn then
                    floatConn:Disconnect()
                    floatConn = nil
                end
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
                    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
                        disableFloat()
                        return
                    end
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
                        if bp then
                            bp.Position = hrp.Position
                        end
                    end
                end)
            end
            
            local function stopFloat()
                if floatConn then
                    floatConn:Disconnect()
                    floatConn = nil
                end
                if tween then
                    tween:Cancel()
                    tween = nil
                end
                disableFloat()
                WindUI:Notify({ Title = "Float", Content = "หยุดลอยแล้ว", Duration = 2 })
            end

            sec:Toggle({
                Title = "Float + Tween ไปหา",
                Icon = "move",
                Default = false,
                Callback = function(state)
                    _G.FloatToTarget = state
                    if state then
                        startFloat()
                    else
                        stopFloat()
                    end
                end
            })
            
            sec:Slider({
                Title = "ความเร็ว Tween",
                Icon = "gauge",
                Value = { Min = 15, Max = 500000, Default = 50 },
                Step = 1,
                Callback = function(v)
                    _G.TweenMaxSpeed = v
                    WindUI:Notify({ Title = "ปรับความเร็ว Tween", Content = "ความเร็ว: " .. v, Duration = 1 })
                end
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
                            if bp then
                                bp.Position = hrp.Position
                            end
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
                Title = "Teleport ไปหา (กระโดดทันที)",
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
                            WindUI:Notify({ Title = "Teleport", Content = "ไปหา "..target.Name.." แล้ว", Duration = 2 })
                        end
                    else
                        WindUI:Notify({ Title = "Teleport", Content = "ไม่พบผู้เล่น", Duration = 2 })
                    end
                end
            })
        end)
    end
end

-- ============================================================
-- TAB 8: ป่วน
-- ============================================================
local chaosTab = createTab("ป่วน", "sparkle")
if chaosTab then
    local sec = createSection(chaosTab, "💥 Fling")
    if sec then
        pcall(function()
            -- ปุ่มสำหรับเรียก GHSX Fling GUI (ภายนอก)
            sec:Button({
                Title = "เตะปลิว (ภายนอก)",
                Icon = "footprints",
                Callback = function()
                    local success, err = pcall(function()
                        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GHSX-FLING-GUI-158629"))()
                    end)
                    if success then
                        WindUI:Notify({ 
                            Title = "GHSX Fling", 
                            Content = "โหลด Fling GUI สำเร็จ!", 
                            Duration = 3 
                        })
                    else
                        WindUI:Notify({ 
                            Title = "GHSX Fling", 
                            Content = "โหลดไม่สำเร็จ: " .. tostring(err), 
                            Duration = 3 
                        })
                    end
                end
            })
            
            -- ปุ่มสำหรับเรียก FE DropKick Script (ภายนอก)
            sec:Button({
                Title = "กระโดดเตะ (ภายนอก)",
                Icon = "footprints",
                Callback = function()
                    local success, err = pcall(function()
                        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-DropKick-Script-165813"))()
                    end)
                    if success then
                        WindUI:Notify({ 
                            Title = "DropKick", 
                            Content = "โหลด DropKick สำเร็จ!", 
                            Duration = 3 
                        })
                    else
                        WindUI:Notify({ 
                            Title = "DropKick", 
                            Content = "โหลดไม่สำเร็จ: " .. tostring(err), 
                            Duration = 3 
                        })
                    end
                end
            })
        end)
    end
end

-- ====== แจ้งเตือนสำเร็จ ======
WindUI:Notify({
    Title = "Pumpkitz HUB V0.0.6",
    Content = "โหลด GUI สำเร็จ! อัปเดต V0.0.6 แล้ว",
    Duration = 5
})
print("✅ Pumpkitz HUB V0.0.6 ทำงานครบทุก Tab")
