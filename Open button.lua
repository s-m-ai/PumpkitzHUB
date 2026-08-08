-- ============================================================
-- Custom OpenButton (แยกโมดูล)
-- ============================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local function CreateOpenButton(Window, IconId)
    -- สร้าง ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "CustomOpenButton"
    ScreenGui.ResetOnSpawn = false

    local ViewportSize = Workspace.CurrentCamera.ViewportSize
    local isMobile = ViewportSize.X < 800
    local ButtonSize = isMobile and 45 or 50

    -- ปุ่มหลัก
    local OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.fromOffset(ButtonSize, ButtonSize)
    OpenButton.Position = UDim2.fromOffset(15, 15)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.BackgroundTransparency = 0
    OpenButton.BorderSizePixel = 0
    OpenButton.ClipsDescendants = true
    OpenButton.AutoButtonColor = false
    OpenButton.Parent = ScreenGui

    -- ขอบมน
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.2, 0)
    Corner.Parent = OpenButton

    -- UIStroke สีส้ม
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    UIStroke.Color = Color3.fromRGB(255, 140, 0)
    UIStroke.Thickness = 2
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = OpenButton

    -- รูปภาพ
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "ImageLabel"
    ImageLabel.Size = UDim2.fromScale(0.75, 0.75)
    ImageLabel.Position = UDim2.fromScale(0.125, 0.125)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = IconId or "rbxassetid://75519083960535"
    ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.Parent = OpenButton

    -- DragArea (สำหรับลาก)
    local DragArea = Instance.new("ImageButton")
    DragArea.Name = "DragArea"
    DragArea.Size = UDim2.fromOffset(ButtonSize * 2.5, ButtonSize * 2.5)
    DragArea.Position = UDim2.fromOffset(
        OpenButton.Position.X.Offset - (ButtonSize * 1.5 / 2),
        OpenButton.Position.Y.Offset - (ButtonSize * 1.5 / 2)
    )
    DragArea.BackgroundTransparency = 1
    DragArea.BorderSizePixel = 0
    DragArea.AutoButtonColor = false
    DragArea.Parent = ScreenGui

    local function UpdateDragAreaPosition()
        DragArea.Position = UDim2.fromOffset(
            OpenButton.Position.X.Offset - (ButtonSize * 0.75),
            OpenButton.Position.Y.Offset - (ButtonSize * 0.75)
        )
    end
    UpdateDragAreaPosition()

    -- ระบบลาก
    local isDragging = false
    local dragStart = nil
    local startPos = nil
    local touchStartTime = 0
    local hasMoved = false
    local WindowVisible = false
    local lastToggleTime = 0

    DragArea.InputBegan:Connect(function(input)
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

    -- ฟังก์ชันเปิด/ปิด
    function ToggleWindow()
        if tick() - lastToggleTime < 0.5 then
            return
        end
        lastToggleTime = tick()
        WindowVisible = not WindowVisible
        if WindowVisible then
            Window:Open()
            DragArea.Visible = false
        else
            Window:Close()
            DragArea.Visible = true
            OpenButton.Position = UDim2.fromOffset(
                ViewportSize.X - ButtonSize - 10,
                10
            )
            UpdateDragAreaPosition()
        end
    end

    -- ฟังก์ชันสำหรับปรับขนาด (ถ้าต้องการ)
    local function UpdateSize()
        local newSize = Workspace.CurrentCamera.ViewportSize
        local isMobileNew = newSize.X < 800
        local newButtonSize = isMobileNew and 45 or 50
        ButtonSize = newButtonSize
        OpenButton.Size = UDim2.fromOffset(newButtonSize, newButtonSize)
        DragArea.Size = UDim2.fromOffset(newButtonSize * 2.5, newButtonSize * 2.5)
        UpdateDragAreaPosition()
    end

    Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateSize)

    -- ลบปุ่ม WindUI เดิม
    task.wait(0.5)
    local function RemoveWindUIButtons()
        for _, gui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
            if gui.Name == "WindUI" or string.find(gui.Name, "WindUI") then
                for _, child in pairs(gui:GetDescendants()) do
                    if child:IsA("ImageButton") and child.Name == "OpenButton" then
                        child.Visible = false
                        child.Active = false
                    end
                    if child:IsA("ImageButton") and child.Name == "FullScreen" then
                        child.Visible = false
                        child.Active = false
                    end
                    if child:IsA("ImageButton") then
                        if child.Name == "Fullscreen" or child.Name == "Maximize" then
                            child.Visible = false
                            child.Active = false
                        end
                    end
                end
            end
        end
    end
    RemoveWindUIButtons()
    LocalPlayer.PlayerGui.ChildAdded:Connect(RemoveWindUIButtons)

    return {
        OpenButton = OpenButton,
        DragArea = DragArea,
        ToggleWindow = ToggleWindow,
        UpdateSize = UpdateSize
    }
end

return CreateOpenButton
