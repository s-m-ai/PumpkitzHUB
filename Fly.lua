local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
end)

local gui = Instance.new("ScreenGui")
gui.Name = "FlyGUIV3"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,300,0,120)
frame.Position = UDim2.new(0.35,0,0.3,0)
frame.BackgroundColor3 = Color3.new(0,0,0)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local function Button(text,color,pos,size)
	local b = Instance.new("TextButton")
	b.Text = text
	b.BackgroundColor3 = color
	b.Position = pos
	b.Size = size
	b.TextScaled = true
	b.Font = Enum.Font.SourceSansBold
	b.TextColor3 = Color3.new(0,0,0)
	b.BorderSizePixel = 2
	b.Parent = frame
	return b
end

local closeBtn = Button(
	"X",
	Color3.fromRGB(255,0,0),
	UDim2.new(0,0,0,0),
	UDim2.new(0,60,0,40)
)

local hideBtn = Button(
	"-",
	Color3.fromRGB(255,120,255),
	UDim2.new(0,60,0,0),
	UDim2.new(0,60,0,40)
)

local upBtn = Button(
	"UP",
	Color3.fromRGB(100,255,200),
	UDim2.new(0,0,0,40),
	UDim2.new(0,60,0,40)
)

local plusBtn = Button(
	"+",
	Color3.fromRGB(80,120,255),
	UDim2.new(0,60,0,40),
	UDim2.new(0,60,0,40)
)

local title = Instance.new("TextLabel")
title.Text = "Pumpkitz FLY"
title.Size = UDim2.new(0,180,0,40)
title.Position = UDim2.new(0,120,0,40)
title.BackgroundColor3 = Color3.fromRGB(255,0,255)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.new(0,0,0)
title.BorderSizePixel = 2
title.Parent = frame

local downBtn = Button(
	"DOWN",
	Color3.fromRGB(255,255,0),
	UDim2.new(0,0,0,80),
	UDim2.new(0,60,0,40)
)

local minusBtn = Button(
	"-",
	Color3.fromRGB(100,255,255),
	UDim2.new(0,60,0,80),
	UDim2.new(0,60,0,40)
)

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0,90,0,40)
speedLabel.Position = UDim2.new(0,120,0,80)
speedLabel.BackgroundColor3 = Color3.fromRGB(255,100,0)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.SourceSansBold
speedLabel.TextColor3 = Color3.new(0,0,0)
speedLabel.BorderSizePixel = 2
speedLabel.Parent = frame

local flyBtn = Button(
	"fly",
	Color3.fromRGB(255,255,0),
	UDim2.new(0,210,0,80),
	UDim2.new(0,90,0,40)
)

local flying = false
local speed = 1
local vertical = 0

speedLabel.Text = tostring(speed)

local bv
local bg

plusBtn.MouseButton1Click:Connect(function()
	speed += 1
	speedLabel.Text = tostring(speed)
end)

minusBtn.MouseButton1Click:Connect(function()
	speed = math.max(1, speed - 1)
	speedLabel.Text = tostring(speed)
end)

upBtn.MouseButton1Down:Connect(function()
	vertical = 1
end)

upBtn.MouseButton1Up:Connect(function()
	vertical = 0
end)

downBtn.MouseButton1Down:Connect(function()
	vertical = -1
end)

downBtn.MouseButton1Up:Connect(function()
	vertical = 0
end)

local hidden = false
hideBtn.MouseButton1Click:Connect(function()
	hidden = not hidden
	for _,v in pairs(frame:GetChildren()) do
		if v ~= hideBtn and v ~= closeBtn then
			v.Visible = not hidden
		end
	end
	if hidden then
		hideBtn.Text = "+"
		frame.Size = UDim2.new(0,120,0,40)
	else
		hideBtn.Text = "-"
		frame.Size = UDim2.new(0,300,0,120)
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		flyBtn.Text = "unfly"
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
		bv.Velocity = Vector3.zero
		bv.Parent = hrp
		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
		bg.P = 10000
		bg.Parent = hrp
		humanoid.PlatformStand = true
	else
		flyBtn.Text = "fly"
		if bv then
			bv:Destroy()
		end
		if bg then
			bg:Destroy()
		end
		humanoid.PlatformStand = false
	end
end)

RunService.RenderStepped:Connect(function()
	if flying and hrp and humanoid and bv and bg then
		local cam = workspace.CurrentCamera
		local move = humanoid.MoveDirection
		local localMove = hrp.CFrame:VectorToObjectSpace(move)
		local velocity =
			(hrp.CFrame.LookVector * -localMove.Z) +
			(hrp.CFrame.RightVector * localMove.X)
		velocity += Vector3.new(0, vertical, 0)
		if velocity.Magnitude > 0 then
			velocity = velocity.Unit
		end
		bv.Velocity = velocity * (speed * 20)
		bg.CFrame = cam.CFrame
	end
end)
