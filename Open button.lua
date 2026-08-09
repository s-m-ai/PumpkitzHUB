-- ============================================================
-- ระบบ OpenButton (แก้ไขตามคำแนะนำครบทุกจุด)
-- ============================================================
local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- ตัวแปรหลัก
local OpenButton = nil
local DragArea = nil
local ScreenGui = nil
local ButtonSize = 45
local WindowVisible = false
local isDragging = false
local dragStart = nil
local startPos = nil
local lastClickTime = 0
local dragInput = nil
local buttonReady = false

-- ============================================================
-- ระบบ Debug (จุดที่ 1: ตรวจจับ isDragging ค้าง)
-- ============================================================
task.spawn(function()
    while true do
        task.wait(10)
        if buttonReady then
            -- print("🔍 isDragging:", isDragging, " | WindowVisible:", WindowVisible)
        end
    end
end)

-- ============================================================
-- ฟังก์ชัน Emergency Unlock (กันค้าง)
-- ============================================================
local function EmergencyUnlock()
    if isDragging then
        isDragging = false
        dragInput = nil
        if DragArea then
            DragArea.Active = true
            DragArea.Visible = true
        end
        if OpenButton then
            OpenButton.Active = true
        end
    end
end

-- ============================================================
-- ฟังก์ชันอัปเดตตำแหน่ง DragArea
-- ============================================================
local function UpdateDragAreaPosition()
    if not OpenButton or not DragArea then return end
    DragArea.Position = UDim2.fromOffset(
        OpenButton.Position.X.Offset - (ButtonSize * 0.75),
        OpenButton.Position.Y.Offset - (ButtonSize * 0.75)
    )
end

-- ============================================================
-- สร้างปุ่ม (DisplayOrder สูงมาก)
-- ============================================================
function CreateCustomButton()
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
    ScreenGui.DisplayOrder = 999999  -- จุดที่ 2: อยู่บนสุดตลอด
    
    -- ===== ปุ่มหลัก =====
    OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.fromOffset(ButtonSize, ButtonSize)
    OpenButton.Position = UDim2.fromOffset(20, 20)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.BorderSizePixel = 0
    OpenButton.AutoButtonColor = false
    OpenButton.ClipsDescendants = true
    OpenButton.ZIndex = 999999
    OpenButton.Parent = ScreenGui
    
    -- ขอบมน
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.2, 0)
    Corner.Parent = OpenButton
    
    -- UIStroke
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
    Icon.ZIndex = 999999
    Icon.Parent = OpenButton
    
    -- ===== DragArea (โปร่งใส ใหญ่กว่า) =====
    DragArea = Instance.new("ImageButton")
    DragArea.Name = "DragArea"
    DragArea.Size = UDim2.fromOffset(ButtonSize * 3, ButtonSize * 3)  -- ขยายให้ใหญ่ขึ้น
    DragArea.Position = UDim2.fromOffset(
        OpenButton.Position.X.Offset - (ButtonSize * 1),
        OpenButton.Position.Y.Offset - (ButtonSize * 1)
    )
    DragArea.BackgroundTransparency = 1
    DragArea.BorderSizePixel = 0
    DragArea.AutoButtonColor = false
    DragArea.ZIndex = 999998
    DragArea.Active = true
    DragArea.Visible = true
    DragArea.Parent = ScreenGui
    
    -- ===== ตรวจจับ OpenButton ขยับ =====
    OpenButton:GetPropertyChangedSignal("Position"):Connect(function()
        UpdateDragAreaPosition()
    end)
    
    -- ===== Events พร้อม Emergency Unlock =====
    
    -- กดเริ่ม
    DragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            EmergencyUnlock()  -- เคลียร์ค้างก่อน
            isDragging = true
            dragStart = input.Position
            startPos = OpenButton.Position
            dragInput = input
            
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
            dragInput = nil
            
            if startPos and OpenButton.Position then
                local dx = math.abs(OpenButton.Position.X.Offset - startPos.X.Offset)
                local dy = math.abs(OpenButton.Position.Y.Offset - startPos.Y.Offset)
                
                if dx < 10 and dy < 10 then
                    ToggleWindow()
                end
            end
        end
    end)
    
    -- ลาก (เช็ค Touch เดิม)
    UserInputService.InputChanged:Connect(function(input)
        if not isDragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and 
           input.UserInputType ~= Enum.UserInputType.Touch then return end
        
        if input.UserInputType == Enum.UserInputType.Touch and input ~= dragInput then
            return
        end
        
        local delta = input.Position - dragStart
        local currentSize = Workspace.CurrentCamera.ViewportSize
        
        local newX = math.clamp(
            startPos.X.Offset + delta.X,
            0,
            currentSize.X - ButtonSize
        )
        local newY = math.clamp(
            startPos.Y.Offset + delta.Y,
            0,
            currentSize.Y - ButtonSize
        )
        
        OpenButton.Position = UDim2.fromOffset(newX, newY)
    end)
    
    buttonReady = true
    task.wait(0.1)
    RemoveWindUIButtons()
end

-- ============================================================
-- เปิด/ปิด GUI
-- ============================================================
function ToggleWindow()
    if tick() - lastClickTime < 0.3 then return end
    lastClickTime = tick()
    
    EmergencyUnlock()  -- เคลียร์ค้างก่อน
    
    WindowVisible = not WindowVisible
    
    if WindowVisible then
        Window:Open()
    else
        Window:Close()
        local currentSize = Workspace.CurrentCamera.ViewportSize
        local newX = math.clamp(currentSize.X - ButtonSize - 10, 0, currentSize.X - ButtonSize)
        local newY = math.clamp(10, 0, currentSize.Y - ButtonSize)
        
        OpenButton.Position = UDim2.fromOffset(newX, newY)
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
-- ระบบตรวจจับและกู้คืน (จุดที่ 1: กันค้าง)
-- ============================================================
local function MonitorButton()
    while true do
        task.wait(3)
        
        -- จุดที่ 1: ตรวจจับ isDragging ค้าง
        if isDragging and dragInput then
            local inputType = dragInput.UserInputType
            if inputType == Enum.UserInputType.Touch then
                -- ถ้าค้างเกิน 30 วินาที ให้ปลด
                if tick() - lastClickTime > 30 then
                    EmergencyUnlock()
                end
            end
        end
        
        -- ตรวจจับปุ่มหาย
        if not OpenButton or not OpenButton.Parent then
            CreateCustomButton()
        end
    end
end

-- ============================================================
-- จุดที่ 3: ตรวจจับ Memory Leak
-- ============================================================
task.spawn(function()
    local lastMemory = 0
    while true do
        task.wait(300)  -- ทุก 5 นาที
        local currentMemory = collectgarbage("count")
        local diff = currentMemory - lastMemory
        -- print(string.format("📊 Memory: %.2f KB (Δ%.2f KB)", currentMemory, diff))
        lastMemory = currentMemory
    end
end)

-- ============================================================
-- เริ่มต้น
-- ============================================================

-- เช็คสถานะ WindUI
task.wait(0.5)
if Window and Window.Visible then
    WindowVisible = true
end

CreateCustomButton()
task.spawn(MonitorButton)

-- เฉพาะ WindUI เท่านั้น
Player.PlayerGui.ChildAdded:Connect(function(gui)
    if string.find(gui.Name, "WindUI") then
        task.wait(0.2)
        RemoveWindUIButtons()
    end
end)

-- ปรับขนาดหน้าจอ
Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local currentSize = Workspace.CurrentCamera.ViewportSize
    local newSize = currentSize.X < 800 and 45 or 50
    
    if OpenButton then
        ButtonSize = newSize
        OpenButton.Size = UDim2.fromOffset(newSize, newSize)
        DragArea.Size = UDim2.fromOffset(newSize * 3, newSize * 3)
        
        local currentPos = OpenButton.Position
        local clampedX = math.clamp(currentPos.X.Offset, 0, currentSize.X - newSize)
        local clampedY = math.clamp(currentPos.Y.Offset, 0, currentSize.Y - newSize)
        OpenButton.Position = UDim2.fromOffset(clampedX, clampedY)
    end
end)

-- ============================================================
-- คำสั่งแก้ไขฉุกเฉิน (พิมพ์ใน Console)
-- ============================================================
_G.FixOpenButton = function()
    EmergencyUnlock()
    if WindowVisible then
        Window:Close()
        WindowVisible = false
    end
    CreateCustomButton()
    print("✅ OpenButton กู้คืนแล้ว!")
end

print("✅ OpenButton พร้อมใช้งาน!")
print("🔧 ถ้าค้าง พิมพ์ _G.FixOpenButton() ใน Console")
