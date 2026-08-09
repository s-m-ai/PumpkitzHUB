-- ============================================================
-- ระบบสร้างปุ่ม OpenButton (แยกเป็นฟังก์ชันให้เรียกซ้ำได้)
-- ============================================================
local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local ViewportSize = game:GetService("Workspace").CurrentCamera.ViewportSize

local OpenButton = nil
local DragArea = nil
local ImageLabel = nil
local UIStroke = nil
local ScreenGui = nil
local ButtonSize = 0
local WindowVisible = false
local lastToggleTime = 0
local isDragging = false
local dragStart = nil
local startPos = nil
local touchStartTime = 0
local hasMoved = false
local isCreating = false

function CreateCustomButton()
    if isCreating then return end
    isCreating = true
    
    -- ลบของเก่า
    if ScreenGui then
        pcall(function() ScreenGui:Destroy() end)
        ScreenGui = nil
    end
    
    task.wait(0.3)
    
    -- สร้าง ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomOpenButton"
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    
    local isMobile = ViewportSize.X < 800
    ButtonSize = isMobile and 45 or 50
    
    -- ========== ปุ่มหลัก ==========
    OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.fromOffset(ButtonSize, ButtonSize)
    OpenButton.Position = UDim2.fromOffset(15, 15)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.BackgroundTransparency = 0
    OpenButton.BorderSizePixel = 0
    OpenButton.ClipsDescendants = true
    OpenButton.AutoButtonColor = false
    OpenButton.ZIndex = 999
    OpenButton.Parent = ScreenGui
    
    -- ขอบมน
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.2, 0)
    Corner.Parent = OpenButton
    
    -- UIStroke สีส้ม
    UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.Color = Color3.fromRGB(255, 140, 0)
    UIStroke.Thickness = 2
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = OpenButton
    
    -- รูปภาพ (ใหญ่ขึ้น)
    ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "ImageLabel"
    ImageLabel.Size = UDim2.fromScale(0.75, 0.75)
    ImageLabel.Position = UDim2.fromScale(0.125, 0.125)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://75519083960535"
    ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.ZIndex = 999
    ImageLabel.Parent = OpenButton
    
    -- ========== DragArea (พื้นที่ลาก) ==========
    DragArea = Instance.new("ImageButton")
    DragArea.Name = "DragArea"
    DragArea.Size = UDim2.fromOffset(ButtonSize * 2.5, ButtonSize * 2.5)
    DragArea.Position = UDim2.fromOffset(
        OpenButton.Position.X.Offset - (ButtonSize * 1.5 / 2),
        OpenButton.Position.Y.Offset - (ButtonSize * 1.5 / 2)
    )
    DragArea.BackgroundTransparency = 1
    DragArea.BorderSizePixel = 0
    DragArea.AutoButtonColor = false
    DragArea.ZIndex = 998
    DragArea.Parent = ScreenGui
    
    -- ========== ฟังก์ชันอัปเดตตำแหน่ง DragArea ==========
    local function UpdateDragAreaPosition()
        if not OpenButton or not DragArea then return end
        DragArea.Position = UDim2.fromOffset(
            OpenButton.Position.X.Offset - (ButtonSize * 0.75),
            OpenButton.Position.Y.Offset - (ButtonSize * 0.75)
        )
    end
    
    -- ========== Events DragArea ==========
    DragArea.InputBegan:Connect(function(input)
        if not OpenButton then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
            touchStartTime = tick()
            hasMoved = false
        elseif input.UserInputType == Enum.UserInputType.Touch then
            touchStartTime = tick()
            hasMoved = false
            isDragging = true
            dragStart = input.Position
            startPos = OpenButton.Position
        end
    end)
    
    DragArea.InputEnded:Connect(function(input)
        if not OpenButton then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
            if not hasMoved then
                ToggleWindow()
            end
        elseif input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
            if not hasMoved and (tick() - touchStartTime) < 0.3 then
                ToggleWindow()
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if not OpenButton or not DragArea then return end
        if isDragging and (input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local distance = delta.Magnitude
            
            if distance > 10 then
                hasMoved = true
            end
            
            local newX = startPos.X.Offset + delta.X
            local newY = startPos.Y.Offset + delta.Y
            
            OpenButton.Position = UDim2.fromOffset(newX, newY)
            DragArea.Position = UDim2.fromOffset(
                newX - (ButtonSize * 0.75),
                newY - (ButtonSize * 0.75)
            )
        end
    end)
    
    -- อัปเดต DragArea เมื่อ OpenButton ขยับ
    OpenButton:GetPropertyChangedSignal("Position"):Connect(function()
        UpdateDragAreaPosition()
    end)
    
    -- ซ่อนปุ่ม WindUI
    task.wait(0.1)
    RemoveWindUIButtons()
    
    isCreating = false
    print("✅ สร้างปุ่ม Custom เรียบร้อย!")
end

-- ============================================================
-- ฟังก์ชันเปิด/ปิดหน้าต่าง
-- ============================================================
function ToggleWindow()
    if tick() - lastToggleTime < 0.5 then
        return
    end
    lastToggleTime = tick()
    
    WindowVisible = not WindowVisible
    if WindowVisible then
        Window:Open()
        if DragArea then DragArea.Visible = false end
    else
        Window:Close()
        if DragArea then DragArea.Visible = true end
        if OpenButton then
            OpenButton.Position = UDim2.fromOffset(
                ViewportSize.X - ButtonSize - 10,
                10
            )
        end
    end
end

-- ============================================================
-- ซ่อนปุ่มวงกลมและ FullScreen ของ WindUI
-- ============================================================
function RemoveWindUIButtons()
    for _, gui in pairs(Player.PlayerGui:GetChildren()) do
        if gui.Name == "WindUI" or string.find(gui.Name, "WindUI") then
            for _, child in pairs(gui:GetDescendants()) do
                if child:IsA("ImageButton") then
                    if child.Name == "OpenButton" or 
                       child.Name == "FullScreen" or 
                       child.Name == "Fullscreen" or 
                       child.Name == "Maximize" then
                        pcall(function()
                            child.Visible = false
                            child.Active = false
                        end)
                    end
                end
            end
        end
    end
end

-- ============================================================
-- ระบบตรวจจับและกู้คืนปุ่มอัตโนมัติ
-- ============================================================

-- ตรวจจับเมื่อ PlayerGui เปลี่ยน
Player.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "CustomOpenButton" then
        return
    end
    task.wait(0.5)
    CreateCustomButton()
end)

-- ตรวจจับเมื่อปุ่มหายไป
local function MonitorButton()
    while true do
        task.wait(2)
        if not isCreating and (not OpenButton or not OpenButton.Parent) then
            print("⚠️ ตรวจพบปุ่มหายไป กำลังสร้างใหม่...")
            CreateCustomButton()
        end
    end
end

-- ตรวจจับเมื่อ Window ถูกปิดโดยวิธีอื่น
local function MonitorWindow()
    while true do
        task.wait(1)
        if Window and Window.Visible == false and WindowVisible == true then
            WindowVisible = false
            if DragArea then DragArea.Visible = true end
            if OpenButton then
                OpenButton.Position = UDim2.fromOffset(
                    ViewportSize.X - ButtonSize - 10,
                    10
                )
            end
        end
    end
end

-- ============================================================
-- เริ่มต้นระบบ
-- ============================================================
CreateCustomButton()
task.spawn(MonitorButton)
task.spawn(MonitorWindow)

-- ปรับขนาดตามหน้าจอ
game:GetService("Workspace").CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    ViewportSize = game:GetService("Workspace").CurrentCamera.ViewportSize
    local isMobileNew = ViewportSize.X < 800
    local newButtonSize = isMobileNew and 45 or 50
    
    if OpenButton then
        ButtonSize = newButtonSize
        OpenButton.Size = UDim2.fromOffset(newButtonSize, newButtonSize)
        if DragArea then
            DragArea.Size = UDim2.fromOffset(newButtonSize * 2.5, newButtonSize * 2.5)
        end
    end
end)
