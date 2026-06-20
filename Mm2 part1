local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Window = WindUI:CreateWindow({
    Title = "MM2 By Pumpkitz",
    Theme = "Amber",
    Folder = "MM2Pumpkitz",
    Icon = "rbxassetid://75519083960535",
    NewElements = true,
    HideSearchBar = false,
    Topbar = { Height = 44, ButtonsType = "Mac" },
})

Window:Tag({
    Title = "V0.0.2",
    Color = Color3.fromRGB(255,200,0),
})

-- ============================================
-- TAB: Player Customize
-- ============================================
local CustomizeTab = Window:Tab({
    Title = "Player Customize",
    Desc = "ปรับแต่งผู้เล่น",
    Icon = "solar:user-bold",
    IconColor = Color3.fromHex("#f97316"),
    Border = true,
})

local LocalSection = CustomizeTab:Section({
    Title = "🧑 Local Player",
    Desc = "ตั้งค่าตัวละครของคุณ",
})

-- WalkSpeed
LocalSection:Slider({
    Title = "WalkSpeed",
    Value = { Min = 10, Max = 1000, Default = 16 },
    Step = 1,
    Callback = function(v)
        local lp = Players.LocalPlayer
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = v
        end
    end,
})

-- JumpPower
LocalSection:Slider({
    Title = "JumpPower",
    Value = { Min = 20, Max = 500, Default = 50 },
    Step = 5,
    Callback = function(v)
        local lp = Players.LocalPlayer
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.JumpPower = v
        end
    end,
})

-- Noclip
local noclipEnabled = false
LocalSection:Toggle({
    Title = "Noclip",
    Callback = function(v) noclipEnabled = v end,
})

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local lp = Players.LocalPlayer
        if lp.Character then
            for _, part in pairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

-- Fly
LocalSection:Button({
    Title = "Fly",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-goktug110gx-fly-gui-236664"))()
    end,
})

-- ============================================
-- TAB: ESP
-- ============================================
local EspTab = Window:Tab({
    Title = "ESP",
    Desc = "ฟังก์ชัน ESP",
    Icon = "solar:eye-bold",
    IconColor = Color3.fromHex("#f59e0b"),
    Border = true,
})

local EspSection = EspTab:Section({
    Title = "👁️ ESP Options",
    Desc = "Highlight ผู้เล่นทั้งหมด",
})

local highlightEnabled = false
local highlightColor = Color3.fromRGB(0,255,0)
local highlightTransparency = 0.4

local function applyHighlight(player, color)
    if player.Character then
        for _, obj in pairs(player.Character:GetChildren()) do
            if obj:IsA("Highlight") then obj:Destroy() end
        end
        local h = Instance.new("Highlight")
        h.FillColor = color or highlightColor
        h.FillTransparency = highlightTransparency
        h.OutlineColor = Color3.fromRGB(255,255,255)
        h.OutlineTransparency = 0.4
        h.Parent = player.Character
    end
end

EspSection:Toggle({
    Title = "Enable ESP",
    Callback = function(v) highlightEnabled = v end,
})

EspSection:Colorpicker({
    Title = "ESP Highlight Color",
    Default = highlightColor,
    Transparency = highlightTransparency,
    Callback = function(c,t)
        highlightColor = c
        highlightTransparency = t
    end,
})

-- Spacer
EspTab:Section({ Title = " ", Desc = " " })

-- ESP Role
local RoleSection = EspTab:Section({
    Title = "🔮 ESP Role",
    Desc = "แสดงอาชีพผู้เล่น",
})

local espMurderEnabled, espSheriffEnabled, espInnocentEnabled = false, false, false

RoleSection:Toggle({ Title = "ESP Murderer", Callback = function(v) espMurderEnabled = v end })
RoleSection:Toggle({ Title = "ESP Sheriff", Callback = function(v) espSheriffEnabled = v end })
RoleSection:Toggle({ Title = "ESP Innocent", Callback = function(v) espInnocentEnabled = v end })

RunService.Heartbeat:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            if highlightEnabled then applyHighlight(p, highlightColor) end
            local hasKnife = (p.Backpack and p.Backpack:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
            local hasGun = (p.Backpack and p.Backpack:FindFirstChild("Gun")) or p.Character:FindFirstChild("Gun")
            if espMurderEnabled and hasKnife then
                applyHighlight(p, Color3.fromRGB(255,0,0))
            elseif espSheriffEnabled and hasGun then
                applyHighlight(p, Color3.fromRGB(0,0,255))
            elseif espInnocentEnabled and not hasKnife and not hasGun then
                applyHighlight(p, Color3.fromRGB(0,255,0))
            end
        end
    end
end)
