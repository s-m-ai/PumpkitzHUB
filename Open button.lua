-- ============================================================
-- ระบบ OpenButton (ไม่มีล็อก)
-- ============================================================
local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local ViewportSize = game:GetService("Workspace").CurrentCamera.ViewportSize

-- ตัวแปรหลัก (เฉพาะที่จำเป็น)
local OpenButton = nil
local DragArea = nil
local ScreenGui = nil
local ButtonSize = 45
local WindowVisible = false
local isDragging = false
local dragStart = nil
local startPos = nil
local lastClickTime = 0

-- ============================================================
-- สร้างปุ่ม (เวอร์ชันเรียบง่าย)
-- ============================================================
function CreateCustomButton()
    -- ลบของเก่า
    if ScreenGui then
        pcall(function() ScreenGui:Destroy() end)
        ScreenGui = nil
    end
    
    local playerGui = Player:FindFirstChild("PlayerGui")
    if not playerGui then
        playerGui = Player:WaitForChild("PlayerGui")
    end
    
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OpenButton"
    ScreenGui.Parent = playerGui
    ScreenGui.ResetOnSpawn = false
    
    -- ===== ปุ่มหลัก =====
    OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.fromOffset(ButtonSize, ButtonSize)
    OpenButton.Position = UDim2.fromOffset(20, 20)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.BorderSizePixel = 0
    OpenButton.AutoButtonColor = false
    OpenButton.ClipsDescendants = true
    OpenButton.Parent = ScreenGui
    
    -- ขอบมน
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.2, 0)
    Corner.Parent = OpenButton
    
    -- UIStroke สีส้ม
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255, 140, 0)
    Stroke.Thickness = 2
    Stroke.Parent = OpenButton
    
    -- รูป
    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.fromScale(0.75, 0.75)
    Icon.Position = UDim2.fromScale(0.125, 0.125)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://75519083960535"
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = OpenButton
    
    -- ===== DragArea (โปร่งใส) =====
    DragArea = Instance.new("ImageButton")
    DragArea.Name = "DragArea"
    DragArea.Size = UDim2.fromOffset(ButtonSize * 2.5, ButtonSize * 2.5)
    DragArea.Position = UDim2.fromOffset(
        OpenButton.Position.X.Offset - (ButtonSize * 0.75),
        OpenButton.Position.Y.Offset - (ButtonSize * 0.75)
    )
    DragArea.BackgroundTransparency = 1
    DragArea.BorderSizePixel = 0
    DragArea.AutoButtonColor = false
    DragArea.Parent = ScreenGui
    
    -- ===== Events (เรียบง่าย ไม่มีล็อก) =====
    
    -- กดเริ่ม
    DragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            isDragging = true
            dragStart = input.Position
            startPos = OpenButton.Position
            
            if input.UserInputType == Enum.UserInputType.Touch then
                input.StopPropagation()
            end
        end
    end)
    
    -- ปล่อย
    DragArea.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            isDragging = false
            
            -- เช็คว่าเป็นคลิกหรือลาก
            if startPos and OpenButton.Position then
                local dx = math.abs(OpenButton.Position.X.Offset - startPos.X.Offset)
                local dy = math.abs(OpenButton.Position.Y.Offset - startPos.Y.Offset)
                
                if dx < 10 and dy < 10 then
                    ToggleWindow()
                end
            end
        end
    end)
    
    -- ลาก
    UserInputService.InputChanged:Connect(function(input)
        if not isDragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and 
           input.UserInputType ~= Enum.UserInputType.Touch then return end
        
        local delta = input.Position - dragStart
        local newX = startPos.X.Offset + delta.X
        local newY = startPos.Y.Offset + delta.Y
        
        OpenButton.Position = UDim2.fromOffset(newX, newY)
        DragArea.Position = UDim2.fromOffset(
            newX - (ButtonSize * 0.75),
            newY - (ButtonSize * 0.75)
        )
    end)
    
    -- ซ่อนปุ่ม WindUI
    task.wait(0.1)
    RemoveWindUIButtons()
end

-- ============================================================
-- เปิด/ปิด GUI (ไม่มีล็อก)
-- ============================================================
function ToggleWindow()
    if tick() - lastClickTime < 0.3 then return end
    lastClickTime = tick()
    
    WindowVisible = not WindowVisible
    
    if WindowVisible then
        Window:Open()
    else
        Window:Close()
        -- ขยับไปชิดปุ่ม X
        OpenButton.Position = UDim2.fromOffset(
            ViewportSize.X - ButtonSize - 10,
            10
        )
        DragArea.Position = UDim2.fromOffset(
            ViewportSize.X - ButtonSize - 10 - (ButtonSize * 0.75),
            10 - (ButtonSize * 0.75)
        )
    end
end

-- ============================================================
-- ซ่อนปุ่ม WindUI
-- ============================================================
function RemoveWindUIButtons()
    for _, gui in pairs(Player.PlayerGui:GetChildren()) do
        if gui.Name == "WindUI" then
            for _, child in pairs(gui:GetDescendants()) do
                if child:IsA("ImageButton") and child.Name == "OpenButton" then
                    child.Visible = false
                    child.Active = false
                end
            end
        end
    end
end

-- ============================================================
-- ตรวจจับปุ่มหาย (เฉพาะกรณี)
-- ============================================================
local function MonitorButton()
    while true do
        task.wait(2)
        if not OpenButton or not OpenButton.Parent then
            CreateCustomButton()
        end
    end
end

-- ============================================================
-- เริ่มต้น
-- ============================================================
CreateCustomButton()
task.spawn(MonitorButton)

game:GetService("Workspace").CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    ViewportSize = game:GetService("Workspace").CurrentCamera.ViewportSize
    local newSize = ViewportSize.X < 800 and 45 or 50
    if OpenButton then
        ButtonSize = newSize
        OpenButton.Size = UDim2.fromOffset(newSize, newSize)
        DragArea.Size = UDim2.fromOffset(newSize * 2.5, newSize * 2.5)
    end
end)

print("✅ OpenButton พร้อมใช้งาน!")
