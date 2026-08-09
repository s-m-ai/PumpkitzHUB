-- ============================================================
-- ระบบสร้างปุ่ม OpenButton (ป้องกันการกดซ้ำ)
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
local buttonActive = true
local isProcessingToggle = false  -- กันการกดซ้ำระหว่างกำลังทำงาน

-- ============================================================
-- ฟังก์ชัน Hard Reset
-- ============================================================
function HardResetButton()
    buttonActive = false
    isProcessingToggle = false
    
    if ScreenGui then
        pcall(function() 
            ScreenGui:Destroy() 
            ScreenGui = nil
        end)
    end
    
    OpenButton = nil
    DragArea = nil
    ImageLabel = nil
    UIStroke = nil
    
    task.wait(0.2)
    
    buttonActive = true
    isCreating = false
    CreateCustomButton()
end

-- ============================================================
-- ฟังก์ชันสร้างปุ่ม
-- ============================================================
function CreateCustomButton()
    if isCreating then return end
    isCreating = true
    
    if ScreenGui then
        pcall(function() 
            ScreenGui:Destroy() 
            ScreenGui = nil
        end)
    end
    
    task.wait(0.1)
    
    local playerGui = Player:FindFirstChild("PlayerGui")
    if not playerGui then
        task.wait(0.5)
        playerGui = Player:WaitForChild("PlayerGui")
    end
    
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomOpenButton"
    ScreenGui.Parent = playerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Enabled = true
    
    local camera = game:GetService("Workspace").CurrentCamera
    if camera then
        ViewportSize = camera.ViewportSize
    end
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
    OpenButton.Active = true
    OpenButton.Visible = true
    OpenButton.Interactable = true
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
    
    -- รูปภาพ
    ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "ImageLabel"
    ImageLabel.Size = UDim2.fromScale(0.75, 0.75)
    ImageLabel.Position = UDim2.fromScale(0.125, 0.125)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://75519083960535"
    ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.ZIndex = 999
    ImageLabel.Parent = OpenButton
    
    -- ========== DragArea ==========
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
    DragArea.ZIndex = 998
    DragArea.Active = true
    DragArea.Visible = true
    DragArea.Interactable = true
    DragArea.Parent = ScreenGui
    
    -- ========== เชื่อมต่อ Events ==========
    local function UpdateDragAreaPosition()
        if not OpenButton or not DragArea then return end
        DragArea.Position = UDim2.fromOffset(
            OpenButton.Position.X.Offset - (ButtonSize * 0.75),
            OpenButton.Position.Y.Offset - (ButtonSize * 0.75)
        )
    end
    
    DragArea.InputBegan:Connect(function(input)
        if not OpenButton or not buttonActive or isProcessingToggle then return end
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
        if not OpenButton or not buttonActive or isProcessingToggle then return end
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
        if not OpenButton or not DragArea or not buttonActive or isProcessingToggle then return end
        if isDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
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
    
    OpenButton:GetPropertyChangedSignal("Position"):Connect(function()
        UpdateDragAreaPosition()
    end)
    
    task.wait(0.2)
    RemoveWindUIButtons()
    
    isCreating = false
end

-- ============================================================
-- ฟังก์ชันเปิด/ปิดหน้าต่าง (ป้องกันการกดซ้ำ)
-- ============================================================
function ToggleWindow()
    -- ถ้ากำลังทำงานอยู่ ให้ข้าม
    if isProcessingToggle then
        return
    end
    
    -- กันการกดเร็วเกินไป
    if tick() - lastToggleTime < 0.5 then
        return
    end
    
    -- ตรวจสอบปุ่ม
    if not OpenButton or not OpenButton.Parent then
        HardResetButton()
        return
    end
    
    -- ล็อคไม่ให้กดซ้ำ
    isProcessingToggle = true
    lastToggleTime = tick()
    
    -- ปิดการโต้ตอบชั่วคราว (กันการค้าง)
    if DragArea then
        DragArea.Interactable = false
    end
    
    -- เปลี่ยนสถานะ
    WindowVisible = not WindowVisible
    
    if WindowVisible then
        Window:Open()
        if DragArea then 
            DragArea.Visible = false 
            DragArea.Active = false
        end
    else
        Window:Close()
        if DragArea then 
            DragArea.Visible = true 
            DragArea.Active = true
        end
        if OpenButton then
            OpenButton.Position = UDim2.fromOffset(
                ViewportSize.X - ButtonSize - 10,
                10
            )
        end
    end
    
    -- ปลดล็อคหลังจากทำงานเสร็จ (รอให้ GUI โหลด)
    task.wait(0.15)
    if DragArea then
        DragArea.Interactable = true
    end
    isProcessingToggle = false
end

-- ============================================================
-- ซ่อนปุ่ม WindUI
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
                            child.Interactable = false
                        end)
                    end
                end
            end
        end
    end
end

-- ============================================================
-- ระบบตรวจจับและกู้คืน
-- ============================================================

Player.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "CustomOpenButton" then
        return
    end
    task.wait(0.5)
    if not OpenButton or not OpenButton.Parent then
        CreateCustomButton()
    end
end)

local function MonitorButton()
    while true do
        task.wait(1.5)
        if not isCreating and buttonActive then
            local needReset = false
            
            if not OpenButton or not OpenButton.Parent then
                needReset = true
            elseif not DragArea or not DragArea.Parent then
                needReset = true
            elseif OpenButton and not OpenButton.Interactable then
                needReset = true
            end
            
            if needReset then
                HardResetButton()
            end
        end
    end
end

local function MonitorWindow()
    while true do
        task.wait(0.5)
        if Window and Window.Visible == false and WindowVisible == true then
            WindowVisible = false
            isProcessingToggle = false
            if DragArea then 
                DragArea.Visible = true 
                DragArea.Active = true
                DragArea.Interactable = true
            end
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
-- คำสั่งรีเซ็ต (F5)
-- ============================================================
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F5 and input.UserInputType == Enum.UserInputType.Keyboard then
        isProcessingToggle = false
        HardResetButton()
    end
end)

-- ============================================================
-- เริ่มต้นระบบ
-- ============================================================
CreateCustomButton()
task.spawn(MonitorButton)
task.spawn(MonitorWindow)

game:GetService("Workspace").CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local camera = game:GetService("Workspace").CurrentCamera
    if camera then
        ViewportSize = camera.ViewportSize
    end
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
