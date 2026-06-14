--https://docs.sirius.menu/rayfield

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local camera = workspace.CurrentCamera

local Window = Rayfield:CreateWindow({
   Name = "Pumpkitz V0.0.2",
   Icon = 75519083960535, 
   LoadingTitle = "Pumpkitz V0.0.2",
   LoadingSubtitle = "by Pumpkitz hub",
   ShowText = "Pumpkitz",
   Theme = "AmberGlow",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Pumpkitz",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
})

-- ตัวแปรสถานะ Global เพื่อให้คงอยู่ตลอด
_G.NoclipEnabled = false
_G.ESPEnabled = false
_G.AimbotEnabled = false
_G.AimbotStrength = 0.5 -- เปลี่ยนชื่อจาก Smoothness เป็น Strength

local noclipConnection = nil
local espHighlights = {}
local playerAddedConn = nil
local playerRemovingConn = nil
local aimbotConnection = nil

-- ฟังก์ชันช่วยใส่ Noclip ให้ตัวละครทันที
local function applyNoclipToCharacter()
    if _G.NoclipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- ดักจับการเกิดใหม่ของตัวละครมึง เพื่อให้ Noclip ติดทันที 0 วิ
player.CharacterAdded:Connect(applyNoclipToCharacter)

-- ฟังก์ชันหาผู้เล่นที่ใกล้ที่สุด
local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = 100000
    
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("HumanoidRootPart") then
            if plr.Character.Humanoid.Health > 0 then
                local distance = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = plr
                end
            end
        end
    end
    
    return closestPlayer
end

-- ฟังก์ชันเช็คว่ามีกำแพงกั้นไหม
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

-- Tab 1: หน้าหลัก
local HomeTab = Window:CreateTab("หน้าหลัก", 4483362458)

HomeTab:CreateSlider({
   Name = "ปรับ FOV",
   Range = {10, 120},
   Increment = 1,
   Suffix = " FOV",
   CurrentValue = 70,
   Flag = "FOVSlider",
   Callback = function(Value)
      workspace.CurrentCamera.FieldOfView = Value
   end,
})

HomeTab:CreateButton({
   Name = "รีเซ็ท FOV",
   Callback = function()
      workspace.CurrentCamera.FieldOfView = 70
   end,
})

HomeTab:CreateToggle({
   Name = "Remove Fog (ลบหมอก)",
   CurrentValue = false,
   Flag = "RemoveFog",
   Callback = function(Value)
      if Value then
         Lighting.FogEnd = 1000000
         Lighting.FogStart = 0
      else
         Lighting.FogEnd = 100000
         Lighting.FogStart = 0
      end
   end,
})

-- Tab 2: ผู้เล่น
local PlayerTab = Window:CreateTab("ผู้เล่น", 4483362458)

PlayerTab:CreateSlider({
   Name = "ปรับ WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "ปรับ JumpPower",
   Range = {50, 500},
   Increment = 1,
   Suffix = "",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      if player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.JumpPower = Value
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Fly (บินได้)",
   Callback = function()
      loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-gui-V3-II-REDUX-224789"))()
   end,
})

PlayerTab:CreateToggle({
   Name = "Noclip (ทะลุกำแพง)",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      _G.NoclipEnabled = Value
      
      if Value then
         noclipConnection = RunService.Stepped:Connect(function()
            applyNoclipToCharacter()
         end)
         applyNoclipToCharacter()
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
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "ESP (Highlight สีส้ม)",
   CurrentValue = false,
   Flag = "EspToggle",
   Callback = function(Value)
      _G.ESPEnabled = Value
      
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

      if Value then
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
      else
         if playerAddedConn then playerAddedConn:Disconnect() end
         if playerRemovingConn then playerRemovingConn:Disconnect() end
         
         for _, highlight in pairs(espHighlights) do
            highlight:Destroy()
         end
         espHighlights = {}
      end
   end,
})

-- Tab 3: เซิฟเวอร์
local ServerTab = Window:CreateTab("เซิฟเวอร์", 4483362458)

ServerTab:CreateToggle({
   Name = "Fullbright (สว่างตลอด)",
   CurrentValue = false,
   Flag = "FullbrightToggle",
   Callback = function(Value)
      if Value then
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
   end,
})

-- Tab 4: FPS
local FPSTab = Window:CreateTab("FPS", 4483362458)

FPSTab:CreateToggle({
   Name = "ล็อกหัว (Aimbot)",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      _G.AimbotEnabled = Value
      
      if Value then
         aimbotConnection = RunService.RenderStepped:Connect(function()
            if not _G.AimbotEnabled then return end
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            
            local target = getClosestPlayer()
            if target and not hasWallBetween(target) then
               local targetHead = target.Character.Head
               local targetPos = targetHead.Position
               local currentCF = camera.CFrame
               local targetCF = CFrame.new(currentCF.Position, targetPos)
               
               -- แก้แล้ว! strength = 1 คือดูดแรงสุด, strength = 0 คือไม่ขยับ
               local strength = _G.AimbotStrength
               camera.CFrame = currentCF:Lerp(targetCF, strength)
            end
         end)
      else
         if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
         end
      end
   end,
})

FPSTab:CreateSlider({
   Name = "ความแรงล็อกหัว",
   Range = {0, 1},
   Increment = 0.01,
   Suffix = "",
   CurrentValue = 0.5,
   Flag = "AimbotStrength",
   Callback = function(Value)
      _G.AimbotStrength = Value
   end,
})

-- Tab 5: สคริปต์อื่นๆ
local ScriptsTab = Window:CreateTab("สคริปต์อื่นๆ", 4483362458)

ScriptsTab:CreateButton({
   Name = "เสกของ",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/s-m-ai/Sekloso/refs/heads/main/Sekloso.lua"))()
   end,
})

Rayfield:Notify({
   Title = "Pumpkitz V0.0.2",
   Content = "แก้ความแรงล็อกหัวแล้ว! 1 = ดูดแรงสุด 0 = นุ่มสุด",
   Duration = 5,
   Image = "home",
})

