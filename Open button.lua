-- ============================================================
-- ระบบ OpenButton (แก้ไขตามคำแนะนำ)
-- ============================================================
local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

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
local dragInput = nil  -- สำหรับเช็ค Touch เดิม

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
-- สร้างปุ่ม
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
    
    -- ===== DragArea =====
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
    
    -- ===== ตรวจจับ OpenButton ขยับ (จุดที่ 2) =====
    OpenButton:GetPropertyChangedSignal("Position"):Connect(function()
        UpdateDragAreaPosition()
    end)
    
    -- ===== Events =====
    
    -- กดเริ่ม (จุดที่ 4: เก็บ Touch เดิม)
    DragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            
            isDragging = true
            dragStart = input.Position
            startPos = OpenButton.Position
            dragInput = input  -- เก็บ Touch Object
            
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
    
    -- ลาก (จุดที่ 4: เช็ค Touch เดิม)
    UserInputService.InputChanged:Connect(function(input)
        if not isDragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and 
           input.UserInputType ~= Enum.UserInputType.Touch then return end
        
        -- เช็คว่าเป็น Touch เดิมหรือไม่
        if input.UserInputType == Enum.UserInputType.Touch and input ~= dragInput then
            return
        end
        
        local delta = input.Position - dragStart
        local currentSize = Workspace.CurrentCamera.ViewportSize
        
        -- จุดที่ 7: Clamp ไม่ให้หลุดจอ
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
        -- DragArea จะอัปเดตอัตโนมัติผ่าน GetPropertyChangedSignal
    end)
    
    -- ซ่อนปุ่ม WindUI
    task.wait(0.1)
    RemoveWindUIButtons()
end

-- ============================================================
-- เปิด/ปิด GUI (จุดที่ 1: ใช้ ViewportSize ปัจจุบัน)
-- ============================================================
function ToggleWindow()
    if tick() - lastClickTime < 0.3 then return end
    lastClickTime = tick()
    
    WindowVisible = not WindowVisible
    
    if WindowVisible then
        Window:Open()
    else
        Window:Close()
        -- ใช้ ViewportSize ปัจจุบัน
        local currentSize = Workspace.CurrentCamera.ViewportSize
        local newX = math.clamp(currentSize.X - ButtonSize - 10, 0, currentSize.X - ButtonSize)
        local newY = math.clamp(10, 0, currentSize.Y - ButtonSize)
        
        OpenButton.Position = UDim2.fromOffset(newX, newY)
        -- DragArea จะอัปเดตอัตโนมัติ
    end
end

-- ============================================================
-- ซ่อนปุ่ม WindUI (จุดที่ 3: สแกนเฉพาะเมื่อมี WindUI)
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
-- ตรวจจับปุ่มหาย
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

-- จุดที่ 5: เช็คสถานะ WindUI ว่ากำลังเปิดอยู่หรือไม่
task.wait(0.5)
if Window and Window.Visible then
    WindowVisible = true
    if DragArea then
        DragArea.Visible = false
    end
end

CreateCustomButton()
task.spawn(MonitorButton)

-- จุดที่ 3: สแกนเฉพาะ GUI ที่ชื่อ WindUI
Player.PlayerGui.ChildAdded:Connect(function(gui)
    if string.find(gui.Name, "WindUI") then
        task.wait(0.2)
        RemoveWindUIButtons()
    end
end)

-- จุดที่ 1: อัปเดตเมื่อเปลี่ยนขนาดหน้าจอ
Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local currentSize = Workspace.CurrentCamera.ViewportSize
    local newSize = currentSize.X < 800 and 45 or 50
    
    if OpenButton then
        ButtonSize = newSize
        OpenButton.Size = UDim2.fromOffset(newSize, newSize)
        DragArea.Size = UDim2.fromOffset(newSize * 2.5, newSize * 2.5)
        
        -- ป้องกันปุ่มหลุดจอ
        local currentPos = OpenButton.Position
        local clampedX = math.clamp(currentPos.X.Offset, 0, currentSize.X - newSize)
        local clampedY = math.clamp(currentPos.Y.Offset, 0, currentSize.Y - newSize)
        OpenButton.Position = UDim2.fromOffset(clampedX, clampedY)
    end
end)

print("✅ OpenButton พร้อมใช้งาน (แก้ไขครบทุกจุด)!")
