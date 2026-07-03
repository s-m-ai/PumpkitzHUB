local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local camera = workspace.CurrentCamera

-- สร้างหน้าต่างหลัก
local Window = WindUI:CreateWindow({
    Title = "Pumpkitz V0.0.2",
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

Window:Tag({
    Title = "Version 0.0.2",
    Color = Color3.fromRGB(255, 191, 0)
})

-- ตัวแปรสถานะ Global
_G.NoclipEnabled = false
_G.ESPEnabled = false
_G.AimbotEnabled = false
_G.AimbotStrength = 0.5
_G.AimbotCheckTeam = true

local noclipConnection = nil
local espHighlights = {}
local playerAddedConn = nil
local playerRemovingConn = nil
local aimbotConnection = nil

-- ฟังก์ชัน Noclip
local function applyNoclipToCharacter()
    if _G.NoclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

player.CharacterAdded:Connect(applyNoclipToCharacter)

-- ฟังก์ชันหาผู้เล่นใกล้ที่สุด
local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = 100000
    local localTeam = player.Team
    
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("HumanoidRootPart") then
            if plr.Character.Humanoid.Health > 0 then
                local isTeammate = (localTeam ~= nil and plr.Team == localTeam)
                
                if _G.AimbotCheckTeam and isTeammate then
                    -- ข้ามเพื่อนร่วมทีม
                else
                    local distance = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = plr
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

-- ฟังก์ชันเช็คกำแพง
local function hasWallBetween(target)
    if not player.Character or not player.Character:FindFirstChild("Head") then return true end
    
    local origin = camera.CFrame.Position
    local targetPos = target.Character.Head.Position
    local direction = (targetPos - origin).Unit * (targetPos - origin).Magnitude
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {player.Character, target.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    
    return result ~= nil
end

-- ============================================================
-- TAB 1: หน้าหลัก (Home)
-- ============================================================
local HomeTab = Window:Tab({ Title = "หน้าหลัก", Icon = "house" })

local HomeSection = HomeTab:Section({ Title = "การตั้งค่าทั่วไป" })

HomeSection:Slider({
    Title = "ปรับ FOV",
    Icon = "eye",
    Value = { Min = 10, Max = 120, Default = 70 },
    Step = 1,
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
    end
})

HomeSection:Button({
    Title = "รีเซ็ท FOV",
    Icon = "rotate-ccw",
    Callback = function()
        workspace.CurrentCamera.FieldOfView = 70
        WindUI:Notify({
            Title = "รีเซ็ท FOV",
            Content = "FOV กลับเป็น 70 แล้ว",
            Duration = 2
        })
    end
})

HomeSection:Toggle({
    Title = "Remove Fog (ลบหมอก)",
    Icon = "cloud",
    Default = false,
    Callback = function(state)
        if state then
            Lighting.FogEnd = 1000000
            Lighting.FogStart = 0
        else
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
        end
    end
})

-- ============================================================
-- TAB 2: ผู้เล่น (Player)
-- ============================================================
local PlayerTab = Window:Tab({ Title = "ผู้เล่น", Icon = "user" })

local PlayerSection = PlayerTab:Section({ Title = "การปรับแต่งตัวละคร" })

PlayerSection:Slider({
    Title = "ปรับ WalkSpeed",
    Icon = "zap",
    Value = { Min = 16, Max = 500, Default = 16 },
    Step = 1,
    Callback = function(value)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end
})

PlayerSection:Slider({
    Title = "ปรับ JumpPower",
    Icon = "arrow-up",
    Value = { Min = 50, Max = 500, Default = 50 },
    Step = 1,
    Callback = function(value)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end
})

PlayerSection:Button({
    Title = "Fly (บินได้)",
    Icon = "wing",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-gui-V3-II-REDUX-224789"))()
        WindUI:Notify({
            Title = "เปิด Fly",
            Content = "เปิดโหมดบินแล้ว! กด Space เพื่อขึ้น",
            Duration = 2
        })
    end
})

PlayerSection:Toggle({
    Title = "Noclip (ทะลุกำแพง)",
    Icon = "shield",
    Default = false,
    Callback = function(state)
        _G.NoclipEnabled = state
        
        if state then
            noclipConnection = RunService.Stepped:Connect(function()
                applyNoclipToCharacter()
            end)
            applyNoclipToCharacter()
            WindUI:Notify({
                Title = "เปิด Noclip",
                Content = "สามารถทะลุกำแพงได้แล้ว",
                Duration = 2
            })
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            WindUI:Notify({
                Title = "ปิด Noclip",
                Content = "ไม่สามารถทะลุกำแพงได้แล้ว",
                Duration = 2
            })
        end
    end
})

PlayerSection:Toggle({
    Title = "ESP (Highlight สีส้ม)",
    Icon = "eye",
    Default = false,
    Callback = function(state)
        _G.ESPEnabled = state
        
        local function addHighlight(plr)
            if plr ~= player and plr.Character and not espHighlights[plr] then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 165, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 165, 0)
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Parent = plr.Character
                espHighlights[plr] = highlight
            end
        end

        local function removeHighlight(plr)
            if espHighlights[plr] then
                espHighlights[plr]:Destroy()
                espHighlights[plr] = nil
            end
        end

        if state then
            for _, plr in ipairs(game.Players:GetPlayers()) do
                addHighlight(plr)
            end
            
            playerAddedConn = game.Players.PlayerAdded:Connect(function(plr)
                plr.CharacterAdded:Connect(function()
                    if _G.ESPEnabled then addHighlight(plr) end
                end)
                if plr.Character then addHighlight(plr) end
            end)
            
            playerRemovingConn = game.Players.PlayerRemoving:Connect(function(plr)
                removeHighlight(plr)
            end)
            WindUI:Notify({
                Title = "เปิด ESP",
                Content = "เห็นผู้เล่นทุกคนแล้ว",
                Duration = 2
            })
        else
            if playerAddedConn then playerAddedConn:Disconnect() end
            if playerRemovingConn then playerRemovingConn:Disconnect() end
            
            for _, highlight in pairs(espHighlights) do
                highlight:Destroy()
            end
            espHighlights = {}
            WindUI:Notify({
                Title = "ปิด ESP",
                Content = "ปิดการเห็นผู้เล่นแล้ว",
                Duration = 2
            })
        end
    end
})

-- ============================================================
-- TAB 3: เซิร์ฟเวอร์ (Server)
-- ============================================================
local ServerTab = Window:Tab({ Title = "เซิร์ฟเวอร์", Icon = "server" })

local ServerSection = ServerTab:Section({ Title = "การตั้งค่าเซิร์ฟเวอร์" })

ServerSection:Toggle({
    Title = "Fullbright (สว่างตลอด)",
    Icon = "sun",
    Default = false,
    Callback = function(state)
        if state then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            WindUI:Notify({
                Title = "เปิด Fullbright",
                Content = "เกมสว่างตลอดแล้ว",
                Duration = 2
            })
        else
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            WindUI:Notify({
                Title = "ปิด Fullbright",
                Content = "กลับสู่แสงปกติ",
                Duration = 2
            })
        end
    end
})

-- ============================================================
-- TAB 4: FPS (Aimbot)
-- ============================================================
local FPSTab = Window:Tab({ Title = "FPS", Icon = "crosshair" })

local FPSSection = FPSTab:Section({ Title = "ระบบเล็งอัตโนมัติ" })

FPSSection:Toggle({
    Title = "ล็อกหัว (Aimbot)",
    Icon = "crosshair",
    Default = false,
    Callback = function(state)
        _G.AimbotEnabled = state
        
        if state then
            aimbotConnection = RunService.RenderStepped:Connect(function()
                if not _G.AimbotEnabled then return end
                if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
                
                local target = getClosestPlayer()
                if target and not hasWallBetween(target) then
                    local targetHead = target.Character.Head
                    local targetPos = targetHead.Position
                    local currentCF = camera.CFrame
                    local targetCF = CFrame.new(currentCF.Position, targetPos)
                    
                    local strength = _G.AimbotStrength
                    camera.CFrame = currentCF:Lerp(targetCF, strength)
                end
            end)
            WindUI:Notify({
                Title = "เปิด Aimbot",
                Content = "ล็อกหัวอัตโนมัติแล้ว",
                Duration = 2
            })
        else
            if aimbotConnection then
                aimbotConnection:Disconnect()
                aimbotConnection = nil
            end
            WindUI:Notify({
                Title = "ปิด Aimbot",
                Content = "ปิดการล็อกหัวแล้ว",
                Duration = 2
            })
        end
    end
})

FPSSection:Toggle({
    Title = "ตรวจสอบทีม (ไม่ล็อกเพื่อน)",
    Icon = "users",
    Default = true,
    Callback = function(state)
        _G.AimbotCheckTeam = state
        if state then
            WindUI:Notify({
                Title = "เปิดตรวจสอบทีม",
                Content = "ไม่ล็อกเพื่อนร่วมทีม",
                Duration = 2
            })
        else
            WindUI:Notify({
                Title = "ปิดตรวจสอบทีม",
                Content = "ล็อกทุกคนรวมเพื่อน",
                Duration = 2
            })
        end
    end
})

FPSSection:Slider({
    Title = "ความแรงล็อกหัว",
    Icon = "gauge",
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Step = 0.01,
    Callback = function(value)
        _G.AimbotStrength = value
    end
})

-- ============================================================
-- TAB 5: สคริปต์อื่นๆ (Scripts)
-- ============================================================
local ScriptsTab = Window:Tab({ Title = "สคริปต์อื่นๆ", Icon = "code" })

local ScriptsSection = ScriptsTab:Section({ Title = "โหลดสคริปต์เพิ่มเติม" })

ScriptsSection:Button({
    Title = "เสกของ",
    Icon = "wand",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/Sekloso/refs/heads/main/Sekloso.lua"))()
        WindUI:Notify({
            Title = "โหลดเสกของ",
            Content = "โหลดสคริปต์เสกของเรียบร้อย",
            Duration = 2
        })
    end
})

ScriptsSection:Button({
    Title = "MM2",
    Icon = "sword",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/PumpkitzHUB/refs/heads/main/Mm2.lua"))()
        WindUI:Notify({
            Title = "โหลด MM2",
            Content = "โหลดสคริปต์ MM2 เรียบร้อย",
            Duration = 2
        })
    end
})

ScriptsSection:Button({
    Title = "ยิงปืน+",
    Icon = "target",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/PumpkitzHUB/refs/heads/main/Aimbot.lua"))()
        WindUI:Notify({
            Title = "โหลดยิงปืน+",
            Content = "โหลดสคริปต์ยิงปืน+ เรียบร้อย",
            Duration = 2
        })
    end
})

-- ============================================================
-- Notify ตอนเปิด GUI
-- ============================================================
WindUI:Notify({
    Title = "Pumpkitz V0.0.2",
    Content = "โหลด GUI สำเร็จ! ทุกแท็บและปุ่มมีไอคอนแล้ว",
    Duration = 5
})

print("✅ Pumpkitz V0.0.2 โหลดเสร็จเรียบร้อย!")
