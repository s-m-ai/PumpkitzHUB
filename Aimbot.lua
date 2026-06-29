local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

---------------------------------------------------
-- ระบบ Localization ของ WindUI
---------------------------------------------------

WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    Translations = {
        ["th"] = {
            ["WINDOW_TITLE"] = "AIMBOT+",
            ["WINDOW_TAG"] = "เวอร์ชั่น 0.0.6",
            ["PLAYERS"] = "ผู้เล่น",
            ["VISUAL"] = "ภาพ",
            ["AIMBOT"] = "เล็งอัตโนมัติ",
            ["TELEPORT"] = "ย้ายตำแหน่ง",
            ["SETTINGS"] = "ตั้งค่า",
            ["CHARACTER_MODS"] = "ปรับแต่งตัวละคร",
            ["WALK_SPEED"] = "ความเร็วเดิน",
            ["JUMP_POWER"] = "พลังกระโดด",
            ["NOCLIP"] = "เดินทะลุ",
            ["ESP"] = "ESP",
            ["ESP_COLOR"] = "สี ESP",
            ["ESP_TRANSPARENCY"] = "ความโปร่งใส",
            ["AIMBOT_SETTINGS"] = "ตั้งค่าเล็งอัตโนมัติ",
            ["AIM_STRENGTH"] = "ความแรงเล็ง",
            ["CHECK_TEAM"] = "ตรวจสอบทีม",
            ["TELEPORT_TO_PLAYER"] = "ย้ายไปหาผู้เล่น",
            ["SELECT_PLAYER"] = "เลือกผู้เล่น",
            ["REFRESH_LIST"] = "รีเฟรชรายชื่อ",
            ["CONFIRM_TELEPORT"] = "ยืนยันการย้าย",
            ["THEME"] = "ธีม",
            ["LANGUAGE"] = "ภาษา",
            ["NO_PLAYERS"] = "ไม่มีผู้เล่น",
            ["ERROR"] = "ข้อผิดพลาด",
            ["SUCCESS"] = "สำเร็จ",
            ["PLEASE_SELECT_PLAYER"] = "กรุณาเลือกผู้เล่นก่อน!",
            ["TARGET_NOT_FOUND"] = "ไม่พบผู้เล่นเป้าหมาย!",
            ["TELEPORTED_TO"] = "ย้ายไปหา",
            ["LOADED"] = "โหลดเสร็จ!",
            ["ESP_SETTINGS"] = "ตั้งค่า ESP",
            ["LANG_THAI"] = "ไทย",
            ["LANG_ENGLISH"] = "English",
            ["LANG_JAPANESE"] = "日本",
            ["LANG_CHINESE"] = "中國",
        },
        ["en"] = {
            ["WINDOW_TITLE"] = "AIMBOT+",
            ["WINDOW_TAG"] = "Version 0.0.6",
            ["PLAYERS"] = "Players",
            ["VISUAL"] = "Visual",
            ["AIMBOT"] = "Aimbot",
            ["TELEPORT"] = "Teleport",
            ["SETTINGS"] = "Settings",
            ["CHARACTER_MODS"] = "Character Mods",
            ["WALK_SPEED"] = "Walk Speed",
            ["JUMP_POWER"] = "Jump Power",
            ["NOCLIP"] = "Noclip",
            ["ESP"] = "ESP",
            ["ESP_COLOR"] = "ESP Color",
            ["ESP_TRANSPARENCY"] = "Transparency",
            ["AIMBOT_SETTINGS"] = "Aimbot Settings",
            ["AIM_STRENGTH"] = "Aim Strength",
            ["CHECK_TEAM"] = "Check Team",
            ["TELEPORT_TO_PLAYER"] = "Teleport to Player",
            ["SELECT_PLAYER"] = "Select Player",
            ["REFRESH_LIST"] = "Refresh List",
            ["CONFIRM_TELEPORT"] = "Confirm Teleport",
            ["THEME"] = "Theme",
            ["LANGUAGE"] = "Language",
            ["NO_PLAYERS"] = "No players",
            ["ERROR"] = "Error",
            ["SUCCESS"] = "Success",
            ["PLEASE_SELECT_PLAYER"] = "Please select a player first!",
            ["TARGET_NOT_FOUND"] = "Target player not found!",
            ["TELEPORTED_TO"] = "Teleported to",
            ["LOADED"] = "Loaded!",
            ["ESP_SETTINGS"] = "ESP Settings",
            ["LANG_THAI"] = "ไทย",
            ["LANG_ENGLISH"] = "English",
            ["LANG_JAPANESE"] = "日本",
            ["LANG_CHINESE"] = "中國",
        },
        ["ja"] = {
            ["WINDOW_TITLE"] = "AIMBOT+",
            ["WINDOW_TAG"] = "バージョン 0.0.6",
            ["PLAYERS"] = "プレイヤー",
            ["VISUAL"] = "ビジュアル",
            ["AIMBOT"] = "エイムボット",
            ["TELEPORT"] = "テレポート",
            ["SETTINGS"] = "設定",
            ["CHARACTER_MODS"] = "キャラクター設定",
            ["WALK_SPEED"] = "歩行速度",
            ["JUMP_POWER"] = "ジャンプ力",
            ["NOCLIP"] = "ノークリップ",
            ["ESP"] = "ESP",
            ["ESP_COLOR"] = "ESPカラー",
            ["ESP_TRANSPARENCY"] = "透明度",
            ["AIMBOT_SETTINGS"] = "エイムボット設定",
            ["AIM_STRENGTH"] = "エイム強度",
            ["CHECK_TEAM"] = "チームチェック",
            ["TELEPORT_TO_PLAYER"] = "プレイヤーにテレポート",
            ["SELECT_PLAYER"] = "プレイヤーを選択",
            ["REFRESH_LIST"] = "リストを更新",
            ["CONFIRM_TELEPORT"] = "テレポート確認",
            ["THEME"] = "テーマ",
            ["LANGUAGE"] = "言語",
            ["NO_PLAYERS"] = "プレイヤーがいません",
            ["ERROR"] = "エラー",
            ["SUCCESS"] = "成功",
            ["PLEASE_SELECT_PLAYER"] = "プレイヤーを選択してください！",
            ["TARGET_NOT_FOUND"] = "ターゲットプレイヤーが見つかりません！",
            ["TELEPORTED_TO"] = "テレポートしました:",
            ["LOADED"] = "読み込み完了！",
            ["ESP_SETTINGS"] = "ESP設定",
            ["LANG_THAI"] = "ไทย",
            ["LANG_ENGLISH"] = "English",
            ["LANG_JAPANESE"] = "日本",
            ["LANG_CHINESE"] = "中國",
        },
        ["zh"] = {
            ["WINDOW_TITLE"] = "AIMBOT+",
            ["WINDOW_TAG"] = "版本 0.0.6",
            ["PLAYERS"] = "玩家",
            ["VISUAL"] = "视觉",
            ["AIMBOT"] = "自动瞄准",
            ["TELEPORT"] = "传送",
            ["SETTINGS"] = "设置",
            ["CHARACTER_MODS"] = "角色修改",
            ["WALK_SPEED"] = "步行速度",
            ["JUMP_POWER"] = "跳跃力",
            ["NOCLIP"] = "穿墙",
            ["ESP"] = "ESP",
            ["ESP_COLOR"] = "ESP颜色",
            ["ESP_TRANSPARENCY"] = "透明度",
            ["AIMBOT_SETTINGS"] = "自动瞄准设置",
            ["AIM_STRENGTH"] = "瞄准强度",
            ["CHECK_TEAM"] = "检查队伍",
            ["TELEPORT_TO_PLAYER"] = "传送到玩家",
            ["SELECT_PLAYER"] = "选择玩家",
            ["REFRESH_LIST"] = "刷新列表",
            ["CONFIRM_TELEPORT"] = "确认传送",
            ["THEME"] = "主题",
            ["LANGUAGE"] = "语言",
            ["NO_PLAYERS"] = "没有玩家",
            ["ERROR"] = "错误",
            ["SUCCESS"] = "成功",
            ["PLEASE_SELECT_PLAYER"] = "请先选择玩家！",
            ["TARGET_NOT_FOUND"] = "找不到目标玩家！",
            ["TELEPORTED_TO"] = "已传送到",
            ["LOADED"] = "加载完成！",
            ["ESP_SETTINGS"] = "ESP设置",
            ["LANG_THAI"] = "ไทย",
            ["LANG_ENGLISH"] = "English",
            ["LANG_JAPANESE"] = "日本",
            ["LANG_CHINESE"] = "中國",
        },
    }
})

WindUI:SetLanguage("en")

---------------------------------------------------
-- SETTINGS (ค่าเริ่มต้น)
---------------------------------------------------

local ESPEnabled = false
local ESPColor = Color3.fromRGB(255, 191, 0)
local ESPTransparency = 0.5

local SpeedValue = 16
local JumpPowerValue = 50
local NoclipEnabled = false

local AimbotEnabled = false
local AimStrength = 0.5
local CheckTeamEnabled = false

local CurrentTheme = "Amber"

---------------------------------------------------
-- WINDOW
---------------------------------------------------

local Window = WindUI:CreateWindow({
    Title = "loc:WINDOW_TITLE",
    Icon = "rbxassetid://75519083960535",
    Author = "By Pumpkitz",
    Folder = "AIMBOTPlus",
    Size = UDim2.fromOffset(700, 520),
    Transparent = true,
    Theme = CurrentTheme,
    SideBarWidth = 220,
    Resizable = true,
    IconSize = 48,
    TopbarHeight = 48
})

Window:Tag({
    Title = "loc:WINDOW_TAG",
    Color = Color3.fromRGB(255, 191, 0)
})

---------------------------------------------------
-- HELPER FUNCTIONS
---------------------------------------------------

local function UpdateCharacterSettings(character)
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = SpeedValue
        humanoid.JumpPower = JumpPowerValue
    end
end

LocalPlayer.CharacterAdded:Connect(UpdateCharacterSettings)
if LocalPlayer.Character then
    UpdateCharacterSettings(LocalPlayer.Character)
end

local noclipConnection
local function ToggleNoclip(state)
    NoclipEnabled = state
    if state then
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function ApplyESP(character)
    pcall(function()
        if character:FindFirstChild("Highlight") then
            character.Highlight:Destroy()
        end
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "Highlight"
        Highlight.FillColor = ESPColor
        Highlight.OutlineColor = ESPColor
        Highlight.FillTransparency = ESPTransparency
        Highlight.OutlineTransparency = 0
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.Parent = character
    end)
end

local function CreateESP(player)
    if player == LocalPlayer then return end
    if player.Character then ApplyESP(player.Character) end
    player.CharacterAdded:Connect(function(character)
        if ESPEnabled then
            task.wait(1)
            ApplyESP(character)
        end
    end)
end

local function RemoveESP()
    for _, player in pairs(Players:GetPlayers()) do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Highlight") then
                player.Character.Highlight:Destroy()
            end
        end)
    end
end

local function UpdateESP()
    RemoveESP()
    if ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            CreateESP(player)
        end
    end
end

---------------------------------------------------
-- PLAYERS TAB
---------------------------------------------------

local PlayersTab = Window:Tab({ Title = "loc:PLAYERS", Icon = "users" })
local PlayerModSection = PlayersTab:Section({ Title = "loc:CHARACTER_MODS" })

PlayerModSection:Slider({
    Title = "loc:WALK_SPEED",
    Value = { Min = 16, Max = 200, Default = SpeedValue },
    Step = 1,
    Callback = function(value)
        SpeedValue = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

PlayerModSection:Slider({
    Title = "loc:JUMP_POWER",
    Value = { Min = 50, Max = 300, Default = JumpPowerValue },
    Step = 5,
    Callback = function(value)
        JumpPowerValue = value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end
})

PlayerModSection:Toggle({
    Title = "loc:NOCLIP",
    Default = NoclipEnabled,
    Callback = function(state)
        ToggleNoclip(state)
    end
})

---------------------------------------------------
-- VISUAL TAB
---------------------------------------------------

local VisualTab = Window:Tab({ Title = "loc:VISUAL", Icon = "eye" })
local VisualSection = VisualTab:Section({ Title = "loc:ESP_SETTINGS" })

VisualSection:Toggle({
    Title = "loc:ESP",
    Default = ESPEnabled,
    Callback = function(state)
        ESPEnabled = state
        UpdateESP()
    end
})

VisualSection:Colorpicker({
    Title = "loc:ESP_COLOR",
    Default = ESPColor,
    Transparency = ESPTransparency,
    Callback = function(color, transparency)
        ESPColor = color
        ESPTransparency = transparency
        if ESPEnabled then UpdateESP() end
    end
})

---------------------------------------------------
-- AIMBOT TAB
---------------------------------------------------

local AimbotTab = Window:Tab({ Title = "loc:AIMBOT", Icon = "crosshair" })
local AimbotSection = AimbotTab:Section({ Title = "loc:AIMBOT_SETTINGS" })

AimbotSection:Toggle({
    Title = "loc:AIMBOT",
    Default = AimbotEnabled,
    Callback = function(state)
        AimbotEnabled = state
    end
})

AimbotSection:Slider({
    Title = "loc:AIM_STRENGTH",
    Value = { Min = 0, Max = 1, Default = AimStrength },
    Step = 0.1,
    Callback = function(value)
        AimStrength = value
    end
})

local TeamSection = AimbotTab:Section({ Title = "loc:CHECK_TEAM" })
TeamSection:Toggle({
    Title = "loc:CHECK_TEAM",
    Default = CheckTeamEnabled,
    Callback = function(state)
        CheckTeamEnabled = state
    end
})

---------------------------------------------------
-- TELEPORT TAB
---------------------------------------------------

local TeleportTab = Window:Tab({ Title = "loc:TELEPORT", Icon = "map-pin" })
local TeleportSection = TeleportTab:Section({ Title = "loc:TELEPORT_TO_PLAYER" })

local SelectedPlayer = nil

local function GetPlayerNames()
    local names = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    if #names == 0 then table.insert(names, "loc:NO_PLAYERS") end
    return names
end

local PlayerDropdown = TeleportSection:Dropdown({
    Title = "loc:SELECT_PLAYER",
    Values = GetPlayerNames(),
    Value = "loc:NO_PLAYERS",
    Callback = function(Value)
        SelectedPlayer = Value
    end
})

TeleportSection:Button({
    Title = "loc:REFRESH_LIST",
    Callback = function()
        local names = GetPlayerNames()
        PlayerDropdown.Values = names
        PlayerDropdown.Value = names[1]
        if names[1] ~= "loc:NO_PLAYERS" then SelectedPlayer = names[1] end
    end
})

TeleportSection:Button({
    Title = "loc:CONFIRM_TELEPORT",
    Callback = function()
        if not SelectedPlayer or SelectedPlayer == "loc:NO_PLAYERS" then
            WindUI:Notify({ Title = "loc:ERROR", Content = "loc:PLEASE_SELECT_PLAYER", Duration = 3 })
            return
        end

        local targetPlayer = Players:FindFirstChild(SelectedPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                WindUI:Notify({ Title = "loc:SUCCESS", Content = "loc:TELEPORTED_TO" .. " " .. SelectedPlayer, Duration = 3 })
            end
        else
            WindUI:Notify({ Title = "loc:ERROR", Content = "loc:TARGET_NOT_FOUND", Duration = 3 })
        end
    end
})

---------------------------------------------------
-- SETTINGS TAB
---------------------------------------------------

local SettingsTab = Window:Tab({ Title = "loc:SETTINGS", Icon = "settings" })

-- Theme Dropdown
local themeNames = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeNames, themeName)
end
table.sort(themeNames)

SettingsTab:Dropdown({
    Title = "loc:THEME",
    Values = themeNames,
    Value = CurrentTheme,
    Callback = function(value)
        CurrentTheme = value
        WindUI:SetTheme(value)
        WindUI:Notify({
            Title = "loc:THEME",
            Content = "Changed to " .. value,
            Duration = 2
        })
    end
})

-- Language Dropdown (แสดงชื่อภาษาเต็ม)
SettingsTab:Dropdown({
    Title = "loc:LANGUAGE",
    Values = {"loc:LANG_THAI", "loc:LANG_ENGLISH", "loc:LANG_JAPANESE", "loc:LANG_CHINESE"},
    Value = "loc:LANG_ENGLISH",
    Callback = function(value)
        local langMap = {
            ["loc:LANG_THAI"] = "th",
            ["loc:LANG_ENGLISH"] = "en",
            ["loc:LANG_JAPANESE"] = "ja",
            ["loc:LANG_CHINESE"] = "zh"
        }
        local langCode = langMap[value] or "en"
        WindUI:SetLanguage(langCode)
        
        local displayNames = {
            ["th"] = "ไทย",
            ["en"] = "English",
            ["ja"] = "日本",
            ["zh"] = "中國"
        }
        WindUI:Notify({
            Title = "loc:LANGUAGE",
            Content = "Changed to " .. (displayNames[langCode] or langCode),
            Duration = 2
        })
    end
})

---------------------------------------------------
-- AIMBOT SYSTEM
---------------------------------------------------

local function IsVisible(targetHead)
    local origin = Camera.CFrame.Position
    local direction = (targetHead.Position - origin).Unit
    local distance = (targetHead.Position - origin).Magnitude

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {
        LocalPlayer.Character,
        targetHead.Parent
    }

    local result = Workspace:Raycast(origin, direction * distance, params)
    return result == nil
end

local function GetClosestPlayer()
    local ClosestPlayer = nil
    local ClosestDistance = math.huge
    local MyTeam = LocalPlayer.Team

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then
        elseif not player.Character or not player.Character:FindFirstChild("Head") then
        else
            local shouldSkip = false

            if CheckTeamEnabled then
                if MyTeam and player.Team and MyTeam == player.Team then
                    shouldSkip = true
                end
            end

            if not shouldSkip then
                local Head = player.Character.Head
                local ScreenPos, Visible = Camera:WorldToViewportPoint(Head.Position)

                if Visible and IsVisible(Head) then
                    local Distance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude

                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        ClosestPlayer = player
                    end
                end
            end
        end
    end

    return ClosestPlayer
end

RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local Target = GetClosestPlayer()

        if Target and Target.Character and Target.Character:FindFirstChild("Head") then
            local Head = Target.Character.Head
            Camera.CFrame = Camera.CFrame:Lerp(
                CFrame.new(Camera.CFrame.Position, Head.Position),
                AimStrength
            )
        end
    end
end)

---------------------------------------------------
-- INITIALIZATION
---------------------------------------------------

Players.PlayerAdded:Connect(function(player)
    if ESPEnabled then CreateESP(player) end
end)

if ESPEnabled then UpdateESP() end
if NoclipEnabled then ToggleNoclip(true) end

WindUI:Notify({
    Title = "loc:WINDOW_TITLE",
    Content = "loc:LOADED",
    Duration = 3
})

print("✅ AIMBOT+ Loaded! Language:", WindUI:GetLanguage() or "en")
