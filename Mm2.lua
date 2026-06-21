--[[
    WindUI Amber Theme Library Demo
    Multi-Tab Version (Fixed Player Dropdown List Display)
    Theme: Amber
    Header : Murder Mystery 2
    Desc   : By Pumpkitz
    Logo   : 75519083960535
]]

-- // LOAD LIBRARY
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- // THEME SYSTEM
WindUI:SetTheme("Amber")

-- // WINDOW CREATION
local Window = WindUI:CreateWindow({
    Title = "Murder Mystery 2",
    Icon = "rbxassetid://75519083960535",
    Author = "By Pumpkitz",
    Folder = "PumpkitzHub",
    Size = UDim2.fromOffset(650, 500),
    Transparent = true,
    Theme = "Amber",
    SideBarWidth = 200,
    Background = "",
    BackgroundImageTransparency = 0.3,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false
    }
})

-- // HEADER TAG SYSTEM (สร้างป้าย Tag สีเหลือง)
Window:Tag({
    Text = "V0.0.3",
    Color = Color3.fromRGB(255, 215, 0)
})

-- // FORCE FIX TAG TEXT (แก้คำว่า "Tag" ให้เป็น "V0.0.3" ชัวร์ 100%)
task.spawn(function()
    pcall(function()
        local coreGui = game:GetService("CoreGui")
        for i = 1, 20 do
            task.wait(0.1)
            for _, v in pairs(coreGui:GetDescendants()) do
                if v:IsA("TextLabel") and (v.Text == "Tag" or v.Text == "Tag Example" or v.Text == "V0.0.2") then
                    v.Text = "V0.0.3"
                    v.TextColor3 = Color3.fromRGB(0, 0, 0)
                end
            end
        end
    end)
end)

-- // LOGO RESIZER & POSITION ADJUSTMENT
task.spawn(function()
    pcall(function()
        task.wait(1.5) 
        local coreGui = game:GetService("CoreGui")
        
        for _, v in pairs(coreGui:GetDescendants()) do
            if v:IsA("ImageLabel") and (string.find(tostring(v.Image), "75519083960535")) then
                v.AnchorPoint = Vector2.new(0, 0.5)
                v.Size = UDim2.fromOffset(35, 35)
                v.Position = UDim2.new(0, 6, 0.5, 0)
                v.ScaleType = Enum.ScaleType.Fit
            end
        end
    end)
end)

-- ====================================================================
-- TABS CONFIGURATION
-- ====================================================================
local PlayersTab = Window:Tab({ Title = "Players", Icon = "users" })
local EspTab = Window:Tab({ Title = "Esp", Icon = "eye" })
local CombatTab = Window:Tab({ Title = "ต่อสู้", Icon = "sword" })
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "map-pin" })

-- ====================================================================
-- PLAYERS TAB SECTIONS & COMPONENTS
-- ====================================================================
local PlayerSection = PlayersTab:Section({ Title = "Player Modifications" })

PlayerSection:Slider({
    Title = "WalkSpeed",
    Desc = "Adjust Player Speed",
    Value = { Min = 16, Max = 1000, Default = 16 },
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
        end
    end
})

PlayerSection:Slider({
    Title = "JumpPower",
    Desc = "Adjust Player Jump Power",
    Value = { Min = 50, Max = 500, Default = 50 },
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true 
            player.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
        end
    end
})

local RunService = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer
local noclipConnection = nil
local noclipEnabled = false

local function startNoclip()
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        if noclipEnabled and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

PlayerSection:Toggle({
    Title = "Noclip",
    Desc = "Enable/Disable Walking through walls",
    Value = false,
    Callback = function(state)
        noclipEnabled = state
        if noclipEnabled then
            startNoclip()
        else
            if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end
})

PlayerSection:Button({
    Title = "Fly",
    Desc = "Execute external Fly GUI script",
    Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-goktug110gx-fly-gui-236664"))()
        end)
    end
})

-- ====================================================================
-- ESP TAB SECTIONS & COMPONENTS
-- ====================================================================
local EspSection = EspTab:Section({ Title = "Esp" })
local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local espTransparency = 0.6
local espMurderEnabled = false
local espSheriffEnabled = false
local espInnocentEnabled = false

local espFolder = Instance.new("Folder", game:GetService("CoreGui"))
espFolder.Name = "WindUI_ESP_Folder"

EspSection:Toggle({
    Title = "Enable ESP",
    Value = false,
    Callback = function(state) espEnabled = state end
})

EspSection:Colorpicker({
    Title = "ESP Color Settings",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0.6,
    Callback = function(color, transparency)
        espColor = color
        espTransparency = transparency
    end
})

local EspRoleSection = EspTab:Section({ Title = "Esp Role" })

local function getPlayerRole(plr)
    if not plr then return "Innocent" end
    local hasKnife, hasGun = false, false
    if plr:FindFirstChild("Backpack") then
        if plr.Backpack:FindFirstChild("Knife") then hasKnife = true end
        if plr.Backpack:FindFirstChild("Gun") then hasGun = true end
    end
    if plr.Character then
        if plr.Character:FindFirstChild("Knife") then hasKnife = true end
        if plr.Character:FindFirstChild("Gun") then hasGun = true end
    end
    if hasKnife then return "Murder" end
    if hasGun then return "Sheriff" end
    return "Innocent"
end

local function updateESP()
    if not espEnabled and not espMurderEnabled and not espSheriffEnabled and not espInnocentEnabled then
        espFolder:ClearAllChildren()
        return
    end
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local role = getPlayerRole(v)
            local shouldHighlight = false
            local finalColor = espColor
            local finalTransparency = espTransparency

            if espEnabled then
                shouldHighlight = true
            elseif role == "Murder" and espMurderEnabled then
                shouldHighlight = true; finalColor = Color3.fromRGB(255, 0, 0); finalTransparency = 0.4
            elseif role == "Sheriff" and espSheriffEnabled then
                shouldHighlight = true; finalColor = Color3.fromRGB(0, 0, 255); finalTransparency = 0.4
            elseif role == "Innocent" and espInnocentEnabled then
                shouldHighlight = true; finalColor = Color3.fromRGB(0, 255, 0); finalTransparency = 0.6
            end

            local highlight = espFolder:FindFirstChild(v.Name)
            if shouldHighlight then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = v.Name
                    highlight.Parent = espFolder
                end
                highlight.Adornee = v.Character
                highlight.FillColor = finalColor
                highlight.OutlineColor = finalColor
                highlight.FillTransparency = finalTransparency
                highlight.OutlineTransparency = 0
            else
                if highlight then highlight:Destroy() end
            end
        else
            local highlight = espFolder:FindFirstChild(v.Name)
            if highlight then highlight:Destroy() end
        end
    end
end

task.spawn(function()
    while true do task.wait(0.1) pcall(updateESP) end
end)

EspRoleSection:Toggle({ Title = "Esp Murder", Value = false, Callback = function(state) espMurderEnabled = state end })
EspRoleSection:Toggle({ Title = "Esp Sheriff", Value = false, Callback = function(state) espSheriffEnabled = state end })
EspRoleSection:Toggle({ Title = "Esp Innocent", Value = false, Callback = function(state) espInnocentEnabled = state end })

-- ====================================================================
-- COMBAT TAB SECTIONS & COMPONENTS (หมวดหมู่ ต่อสู้)
-- ====================================================================

-- --------------------------------------------------------------------
-- [SECTION 1] ฆาตกร
-- --------------------------------------------------------------------
local MurdererSection = CombatTab:Section({ Title = "ฆาตกร" })
local hitboxEnabled = false
local showHitboxEnabled = false
local hitboxSize = 15
local defaultHitboxSize = Vector3.new(2, 2, 1)

MurdererSection:Toggle({
    Title = "Hitbox Expander",
    Desc = "เปิดระบบขยาย Hitbox ศัตรู และถือมีดออโต้",
    Value = false,
    Callback = function(state)
        hitboxEnabled = state
        if not hitboxEnabled then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    hrp.Size = defaultHitboxSize
                    hrp.Transparency = 1
                    hrp.Color = Color3.fromRGB(163, 162, 165)
                    hrp.Material = Enum.Material.Plastic
                    hrp.CanCollide = true
                end
            end
        end
    end
})

MurdererSection:Toggle({
    Title = "Show hitbox",
    Desc = "แสดงกล่องแดง (ความใส 0.8) หรือซ่อนกล่องให้ล่องหน",
    Value = false,
    Callback = function(state)
        showHitboxEnabled = state
        if not showHitboxEnabled then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    v.Character.HumanoidRootPart.Transparency = 1
                end
            end
        end
    end
})

MurdererSection:Input({
    Title = "Hitbox Size (Studs)",
    Desc = "กรอกตัวเลขขนาดความกว้างกล่อง (ค่าเริ่มต้นคือ 15)",
    Value = "15",
    Placeholder = "พิมพ์ตัวเลขที่นี่...",
    Callback = function(text)
        local num = tonumber(text)
        if num then hitboxSize = num end
    end
})

-- --------------------------------------------------------------------
-- [SECTION 2] นายอำเภอ
-- --------------------------------------------------------------------
local SheriffSection = CombatTab:Section({ Title = "นายอำเภอ" })
local camLockEnabled = false
local lockSmoothness = 0.5
local camera = game:GetService("Workspace").CurrentCamera

SheriffSection:Toggle({
    Title = "ล็อกกล้องไปที่ฆาตกร",
    Desc = "หันกล้องตามตำแหน่งหัวฆาตกรอัตโนมัติ",
    Value = false,
    Callback = function(state) camLockEnabled = state end
})

SheriffSection:Slider({
    Title = "ความแรงล็อกฆาตกร",
    Desc = "ปรับความไวการล็อก (0 = ปิดล็อก, 0.5 = ปานกลาง, 1 = ล็อกติดทันที)",
    Value = { Min = 0, Max = 1, Default = 0.5, Decimal = 1 },
    Callback = function(value) lockSmoothness = value end
})

-- ====================================================================
-- TELEPORT TAB SECTIONS & COMPONENTS
-- ====================================================================
local RoleTpSection = TeleportTab:Section({ Title = "Role TP" })

RoleTpSection:Button({
    Title = "เทเลพอร์ตไปหาฆาตกร",
    Desc = "วาร์ปไปตำแหน่งของคนที่เป็นฆาตกรทันที",
    Callback = function()
        pcall(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= player and getPlayerRole(v) == "Murder" then
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            break
                        end
                    end
                end
            end
        end)
    end
})

RoleTpSection:Button({
    Title = "เทเลพอร์ตไปหานายอำเภอ",
    Desc = "วาร์ปไปตำแหน่งของคนที่เป็นนายอำเภอ (คนถือปืน) ทันที",
    Callback = function()
        pcall(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= player and getPlayerRole(v) == "Sheriff" then
                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 0)
                            break
                        end
                    end
                end
            end
        end)
    end
})

-- --------------------------------------------------------------------
-- [SECTION 2] Tp to Players (แก้ไขระบบแสดงผลรายชื่อผู้เล่นเรียบร้อย)
-- --------------------------------------------------------------------
local PlayerTpSection = TeleportTab:Section({ Title = "Tp to Players" })
local selectedPlayerName = "" 

-- ฟังก์ชันดึงรายชื่อผู้เล่นทุกคนในเซิร์ฟเวอร์แบบจัดรูปแบบตารางตรงตาม WindUI
local function getPlayerList()
    local tbl = {}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= player then 
            table.insert(tbl, tostring(v.Name))
        end
    end
    if #tbl == 0 then table.insert(tbl, "ไม่มีผู้เล่นอื่นในเซิร์ฟ") end
    return tbl
end

-- สร้าง Dropdown แสดงรายชื่อผู้เล่น (แก้ไขการดึงลิสต์ตัวแปรให้ตรงตามคู่มือ)
local PlayerDropdown = PlayerTpSection:Dropdown({
    Title = "เลือกผู้เล่นที่ต้องการ",
    Desc = "คลิกเพื่อเลือกชื่อผู้เล่นที่ต้องการเทเลพอร์ตไปหา",
    Multi = false,
    Options = getPlayerList(),
    Value = "",
    Callback = function(selected)
        selectedPlayerName = tostring(selected)
    end
})

-- ปุ่มกด "ตกลง" สำหรับทำงานร่วมกับ Dropdown
PlayerTpSection:Button({
    Title = "ตกลง",
    Desc = "กดเพื่อวาร์ปไปหาผู้เล่นที่เลือกใน Dropdown ด้านบน",
    Callback = function()
        pcall(function()
            if selectedPlayerName ~= "" and selectedPlayerName ~= "ไม่มีผู้เล่นอื่นในเซิร์ฟ" then
                local targetPlr = game:GetService("Players"):FindFirstChild(selectedPlayerName)
                if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.CFrame = targetPlr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                    end
                end
            end
        end)
    end
})

-- ลูปบังคับ Refresh รายชื่อผู้เล่นเข้าสู่หน้าต่าง UI ตลอดเวลาแบบ Realtime 100%
task.spawn(function()
    while true do
        task.wait(2) -- ตรวจสอบรายชื่อและดึงคนใหม่ๆ เข้าลิสต์ทุกๆ 2 วินาทีอัตโนมัติ
        pcall(function()
            PlayerDropdown:Refresh(getPlayerList())
        end)
    end
end)

-- ====================================================================
-- LOOPS PROCESSING SYSTEMS
-- ====================================================================

-- // LOOP ระบบฆาตกร (Hitbox & Auto Equip Knife)
task.spawn(function()
    while true do
        task.wait(0.1)
        if hitboxEnabled then
            pcall(function()
                if player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife") then
                    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:EquipTool(player.Backpack.Knife) end
                end

                for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = v.Character.HumanoidRootPart
                        local role = getPlayerRole(v)
                        
                        if role ~= "Murder" then
                            hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                            hrp.CanCollide = false
                            
                            if showHitboxEnabled then
                                hrp.Transparency = 0.8
                                hrp.Color = Color3.fromRGB(255, 0, 0)
                                hrp.Material = Enum.Material.Neon
                            else
                                hrp.Transparency = 1
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- // LOOP ระบบนายอำเภอ (Camera LookAt Head Murderer Only)
RunService.RenderStepped:Connect(function()
    if camLockEnabled and lockSmoothness > 0 then
        pcall(function()
            local targetMurdererHead = nil
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v ~= player and getPlayerRole(v) == "Murder" then
                    if v.Character and v.Character:FindFirstChild("Head") then
                        targetMurdererHead = v.Character.Head
                        break
                    end
                end
            end
            
            if targetMurdererHead then
                local targetPosition = targetMurdererHead.Position
                local currentCameraCFrame = camera.CFrame
                local targetCFrame = CFrame.new(currentCameraCFrame.Position, targetPosition)
                camera.CFrame = currentCameraCFrame:Lerp(targetCFrame, lockSmoothness)
            end
        end)
    end
end)
