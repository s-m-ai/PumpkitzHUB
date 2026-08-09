local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PumpkitzOpenButton"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = Player.PlayerGui

local OpenButton = Instance.new("ImageButton")
OpenButton.Size = UDim2.fromOffset(55,55)
OpenButton.Position = UDim2.fromOffset(15,120)
OpenButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
OpenButton.BorderSizePixel = 0
OpenButton.Image = "rbxassetid://75519083960535"
OpenButton.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,14)
Corner.Parent = OpenButton

local dragging = false
local dragStart
local startPos

OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPos = OpenButton.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then

        local delta = input.Position - dragStart

        OpenButton.Position = UDim2.fromOffset(
            startPos.X.Offset + delta.X,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

OpenButton.MouseButton1Click:Connect(function()
    if Window then
        Window:Toggle()
    end
end)
