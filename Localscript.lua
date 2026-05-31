-- ReaperHUB 💀 V0.8 | External Fling Loader + No Fly | Delta Optimized
task.spawn(function()
	repeat task.wait() until game:IsLoaded()

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local localPlayer = Players.LocalPlayer
	local playerGui = localPlayer:WaitForChild("PlayerGui", 10)
	if not playerGui then error("[ReaperHUB] PlayerGui ไม่พบ หรือถูกบล็อก") end

	-- === MAIN GUI CORE ===
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ReaperHUB_V08"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 999
	screenGui.Enabled = true
	screenGui.Parent = playerGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.fromOffset(290, 300)
	mainFrame.Position = UDim2.fromScale(0.5, 0.5)
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.BackgroundColor3 = Color3.fromRGB(18, 4, 4)
	mainFrame.BorderSizePixel = 0
	mainFrame.ClipsDescendants = true
	mainFrame.Parent = screenGui

	local shadow = Instance.new("Frame", mainFrame)
	shadow.Size = UDim2.new(1, 4, 1, 6)
	shadow.Position = UDim2.new(0, -2, 0, 0)
	shadow.BackgroundColor3 = Color3.new(0, 0, 0)
	shadow.BackgroundTransparency = 0.65
	shadow.BorderSizePixel = 0
	Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 12)

	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
	Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(225, 35, 35)
	Instance.new("UIGradient", mainFrame).Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 8, 8)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 12, 12))
	})

	-- === HEADER ===
	local header = Instance.new("Frame", mainFrame)
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundColor3 = Color3.fromRGB(32, 10, 10)
	header.BorderSizePixel = 0
	Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)
	Instance.new("UIGradient", header).Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 18, 18)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 8, 8))
	})

	local title = Instance.new("TextLabel", header)
	title.Size = UDim2.new(1, -85, 1, 0)
	title.Position = UDim2.new(0, 12, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "ReaperHUB 💀 V0.8"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 18
	title.Font = Enum.Font.GothamBold
	title.TextXAlignment = Enum.TextXAlignment.Left

	local minBtn = Instance.new("TextButton", header)
	minBtn.Size = UDim2.fromOffset(32, 28)
	minBtn.Position = UDim2.new(1, -75, 0, 6)
	minBtn.BackgroundColor3 = Color3.fromRGB(55, 16, 16)
	minBtn.BorderSizePixel = 0
	minBtn.Text = "-"
	minBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
	minBtn.TextSize = 22
	minBtn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)
	minBtn.Active = true

	local closeBtn = Instance.new("TextButton", header)
	closeBtn.Size = UDim2.fromOffset(32, 28)
	closeBtn.Position = UDim2.new(1, -38, 0, 6)
	closeBtn.BackgroundColor3 = Color3.fromRGB(210, 35, 35)
	closeBtn.BorderSizePixel = 0
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.TextSize = 20
	closeBtn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
	closeBtn.Active = true

	-- === SPLIT LAYOUT ===
	local splitContainer = Instance.new("Frame", mainFrame)
	splitContainer.Name = "SplitContainer"
	splitContainer.Size = UDim2.new(1, 0, 1, -40)
	splitContainer.Position = UDim2.new(0, 0, 0, 40)
	splitContainer.BackgroundColor3 = Color3.fromRGB(18, 4, 4)
	splitContainer.BorderSizePixel = 0
	splitContainer.Active = true

	local catScroll = Instance.new("ScrollingFrame", splitContainer)
	catScroll.Name = "CategoryList"
	catScroll.Size = UDim2.new(0, 100, 1, 0)
	catScroll.BackgroundTransparency = 1
	catScroll.BorderSizePixel = 0
	catScroll.ScrollBarThickness = 3
	catScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)
	catScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	catScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	catScroll.Active = true
	local catLayout = Instance.new("UIListLayout", catScroll)
	catLayout.Padding = UDim.new(0, 6)
	catLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	local contentScroll = Instance.new("ScrollingFrame", splitContainer)
	contentScroll.Name = "ContentArea"
	contentScroll.Size = UDim2.new(1, -105, 1, 0)
	contentScroll.Position = UDim2.new(0, 105, 0, 0)
	contentScroll.BackgroundTransparency = 1
	contentScroll.BorderSizePixel = 0
	contentScroll.ScrollBarThickness = 3
	contentScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)
	contentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	contentScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	contentScroll.Active = true
	local conLayout = Instance.new("UIListLayout", contentScroll)
	conLayout.Padding = UDim.new(0, 8)
	conLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	-- === ESP SYSTEM ===
	local espHighlights = {}
	local espActive = false
	local function toggleESP(state)
		espActive = state
		if state then
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= localPlayer and p.Character then
					local hl = Instance.new("Highlight")
					hl.Adornee = p.Character; hl.FillColor = Color3.fromRGB(255, 0, 0)
					hl.FillTransparency = 0; hl.OutlineTransparency = 1
					hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = p.Character
					espHighlights[p] = hl
				end
				p.CharacterAdded:Connect(function(char)
					task.wait(0.2)
					if espActive then
						local hl = Instance.new("Highlight")
						hl.Adornee = char; hl.FillColor = Color3.fromRGB(255, 0, 0)
						hl.FillTransparency = 0; hl.OutlineTransparency = 1
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = char
						espHighlights[p] = hl
					end
				end)
			end
		else
			for _, hl in pairs(espHighlights) do hl:Destroy() end; espHighlights = {}
		end
	end

	-- === INDEPENDENT TELEPORT GUI ===
	local tpScreenGui = Instance.new("ScreenGui")
	tpScreenGui.Name = "ReaperHUB_TP_V08"
	tpScreenGui.ResetOnSpawn = false
	tpScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	tpScreenGui.IgnoreGuiInset = true
	tpScreenGui.DisplayOrder = 1000
	tpScreenGui.Enabled = true
	tpScreenGui.Parent = playerGui

	local tpMainFrame = Instance.new("Frame")
	tpMainFrame.Name = "TPMainFrame"
	tpMainFrame.Size = UDim2.fromOffset(260, 320)
	tpMainFrame.Position = UDim2.fromScale(0.5, 0.6)
	tpMainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	tpMainFrame.BackgroundColor3 = Color3.fromRGB(20, 6, 6)
	tpMainFrame.BorderSizePixel = 0
	tpMainFrame.Visible = false
	tpMainFrame.Parent = tpScreenGui
	Instance.new("UICorner", tpMainFrame).CornerRadius = UDim.new(0, 10)
	Instance.new("UIStroke", tpMainFrame).Color = Color3.fromRGB(225, 35, 35)
	Instance.new("UIGradient", tpMainFrame).Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 8, 8)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 4, 4))
	})

	local tpHeader = Instance.new("Frame", tpMainFrame)
	tpHeader.Size = UDim2.new(1, 0, 0, 35)
	tpHeader.BackgroundColor3 = Color3.fromRGB(35, 10, 10)
	tpHeader.BorderSizePixel = 0
	tpHeader.Active = true
	Instance.new("UICorner", tpHeader).CornerRadius = UDim.new(0, 10)

	local tpTitle = Instance.new("TextLabel", tpHeader)
	tpTitle.Size = UDim2.new(0.85, 0, 1, 0)
	tpTitle.Position = UDim2.new(0.075, 0, 0, 0)
	tpTitle.BackgroundTransparency = 1
	tpTitle.Text = "📍 เลือกผู้เล่น"
	tpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpTitle.TextSize = 15
	tpTitle.Font = Enum.Font.GothamBold
	tpTitle.TextXAlignment = Enum.TextXAlignment.Center

	local tpClose = Instance.new("TextButton", tpHeader)
	tpClose.Size = UDim2.fromOffset(26, 22)
	tpClose.Position = UDim2.new(0.92, -18, 0, 6)
	tpClose.BackgroundColor3 = Color3.fromRGB(190, 35, 35)
	tpClose.BorderSizePixel = 0
	tpClose.Text = "X"
	tpClose.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpClose.TextSize = 14
	tpClose.Font = Enum.Font.GothamBold
	tpClose.Active = true
	Instance.new("UICorner", tpClose).CornerRadius = UDim.new(0, 4)
	tpClose.MouseButton1Click:Connect(function() tpMainFrame.Visible = false end)

	local tpScroll = Instance.new("ScrollingFrame", tpMainFrame)
	tpScroll.Size = UDim2.new(1, -10, 1, -85)
	tpScroll.Position = UDim2.new(0, 5, 0, 40)
	tpScroll.BackgroundTransparency = 1
	tpScroll.BorderSizePixel = 0
	tpScroll.ScrollBarThickness = 4
	tpScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)
	tpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tpScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	tpScroll.Active = true
	local tpListLayout = Instance.new("UIListLayout", tpScroll)
	tpListLayout.Padding = UDim.new(0, 6)
	tpListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	local tpConfirm = Instance.new("TextButton", tpMainFrame)
	tpConfirm.Size = UDim2.new(0.9, 0, 0, 38)
	tpConfirm.Position = UDim2.new(0.05, 0, 1, -45)
	tpConfirm.BackgroundColor3 = Color3.fromRGB(160, 25, 25)
	tpConfirm.BorderSizePixel = 0
	tpConfirm.Text = "ตกลง (Teleport)"
	tpConfirm.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpConfirm.TextSize = 15
	tpConfirm.Font = Enum.Font.GothamBold
	tpConfirm.Active = true
	Instance.new("UICorner", tpConfirm).CornerRadius = UDim.new(0, 7)

	local selectedTarget = nil
	local function openTPGui()
		tpMainFrame.Visible = true; selectedTarget = nil
		for _, c in pairs(tpScroll:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= localPlayer then
				local btn = Instance.new("TextButton", tpScroll)
				btn.Size = UDim2.new(0.95, 0, 0, 32); btn.BackgroundColor3 = Color3.fromRGB(45, 14, 14)
				btn.BorderSizePixel = 0; btn.Text = p.Name; btn.TextColor3 = Color3.fromRGB(210, 210, 210)
				btn.TextSize = 14; btn.Font = Enum.Font.GothamSemibold; btn.Active = true
				Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
				btn.MouseButton1Click:Connect(function()
					selectedTarget = p
					for _, b in pairs(tpScroll:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(45, 14, 14); b.TextColor3 = Color3.fromRGB(210, 210, 210) end end
					btn.BackgroundColor3 = Color3.fromRGB(220, 50, 50); btn.TextColor3 = Color3.fromRGB(255, 255, 255)
				end)
			end
		end
	end

	tpConfirm.MouseButton1Click:Connect(function()
		if selectedTarget and selectedTarget.Character and selectedTarget.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
			localPlayer.Character.HumanoidRootPart.CFrame = selectedTarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, -2)
		end
		tpMainFrame.Visible = false
	end)

	-- === SHOW HITBOX SYSTEM ===
	local hitboxActive = false
	local hitboxHighlights = {}
	local function toggleShowHitbox(state)
		hitboxActive = state
		local function applyVisualHitbox(char, state)
			if not char then return end
			if state then
				if not hitboxHighlights[char] then
					local hl = Instance.new("Highlight")
					hl.Adornee = char; hl.FillColor = Color3.fromRGB(255, 50, 50)
					hl.FillTransparency = 0.65; hl.OutlineColor = Color3.fromRGB(255, 255, 255)
					hl.OutlineTransparency = 0; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					hl.Parent = char; hitboxHighlights[char] = hl
				end
			else
				if hitboxHighlights[char] then hitboxHighlights[char]:Destroy(); hitboxHighlights[char] = nil end
			end
		end
		if state then
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= localPlayer and p.Character then applyVisualHitbox(p.Character, true) end
				p.CharacterAdded:Connect(function(char) applyVisualHitbox(char, hitboxActive) end)
			end
		else
			for _, hl in pairs(hitboxHighlights) do hl:Destroy() end; hitboxHighlights = {}
		end
	end

	-- === AIMLOCK SYSTEM ===
	local aimlockActive = false
	local aimlockConn = nil
	local camera = workspace.CurrentCamera
	local function toggleAimlock(state)
		aimlockActive = state
		if aimlockConn then aimlockConn:Disconnect(); aimlockConn = nil end
		if state then
			aimlockConn = RunService.RenderStepped:Connect(function()
				if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") or not camera then return end
				local params = RaycastParams.new()
				params.FilterDescendantsInstances = {localPlayer.Character}
				params.FilterType = Enum.RaycastFilterType.Exclude
				local closestDist, closestHead = math.huge, nil
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= localPlayer and p.Character and p.Character:FindFirstChild("Head") then
						local headPos = p.Character.Head.Position
						local dist = (localPlayer.Character.HumanoidRootPart.Position - headPos).Magnitude
						if dist < closestDist and dist < 150 then
							local dir = (headPos - camera.CFrame.Position).Unit * (dist + 5)
							local result = workspace:Raycast(camera.CFrame.Position, dir, params)
							if not result or result.Instance:IsDescendantOf(p.Character) then closestDist = dist; closestHead = headPos end
						end
					end
				end
				if closestHead then camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, closestHead), 0.35) end
			end)
		else
			camera.CameraType = Enum.CameraType.Custom
		end
	end

	-- === NOCLIP SYSTEM ===
	local noclipActive = false
	local noclipConn = nil
	local function toggleNoclip(state)
		noclipActive = state
		if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
		if state then
			noclipConn = RunService.Stepped:Connect(function()
				if localPlayer.Character then
					for _, part in ipairs(localPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
				end
			end)
		else
			if localPlayer.Character then
				for _, part in ipairs(localPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = true end end
			end
		end
	end

	-- === UI MANAGEMENT ===
	local function clearContent()
		for _, child in pairs(contentScroll:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
	end

	local function createToggleBtn(parent, text, onCol, offCol, callback)
		local btn = Instance.new("TextButton", parent)
		btn.Size = UDim2.new(0.95, 0, 0, 45)
		btn.BackgroundColor3 = offCol; btn.BorderSizePixel = 0
		btn.Text = text; btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 16; btn.Font = Enum.Font.GothamBold; btn.Active = true
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
		local active = false
		btn.MouseButton1Click:Connect(function()
			active = not active
			btn.Text = text:gsub("OFF", ""):gsub("ON", "") .. " " .. (active and "ON" or "OFF")
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = active and onCol or offCol}):Play()
			callback(active)
		end)
		return btn
	end

	local function createCatBtn(text)
		local btn = Instance.new("TextButton", catScroll)
		btn.Size = UDim2.new(0.9, 0, 0, 38)
		btn.BackgroundColor3 = Color3.fromRGB(40, 12, 12); btn.BorderSizePixel = 0
		btn.Text = text; btn.TextColor3 = Color3.fromRGB(200, 200, 200)
		btn.TextSize = 14; btn.Font = Enum.Font.GothamBold; btn.Active = true
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
		return btn
	end

	local btnGen = createCatBtn("ทั่วไป")
	local btnPlr = createCatBtn("👤 player")
	local btnGun = createCatBtn("🔫 ยิงปืน")
	local btnJoke = createCatBtn("🤡 แกล้ง")

	local function loadCategory(name)
		clearContent()
		btnGen.BackgroundColor3 = Color3.fromRGB(40, 12, 12); btnGen.TextColor3 = Color3.fromRGB(200, 200, 200)
		btnPlr.BackgroundColor3 = Color3.fromRGB(40, 12, 12); btnPlr.TextColor3 = Color3.fromRGB(200, 200, 200)
		btnGun.BackgroundColor3 = Color3.fromRGB(40, 12, 12); btnGun.TextColor3 = Color3.fromRGB(200, 200, 200)
		btnJoke.BackgroundColor3 = Color3.fromRGB(40, 12, 12); btnJoke.TextColor3 = Color3.fromRGB(200, 200, 200)
		
		if name == "ทั่วไป" then
			btnGen.BackgroundColor3 = Color3.fromRGB(60, 18, 18); btnGen.TextColor3 = Color3.fromRGB(255, 80, 80)
			local lbl = Instance.new("TextLabel", contentScroll)
			lbl.Size = UDim2.new(0.9, 0, 0, 60); lbl.BackgroundTransparency = 1
			lbl.Text = "หมวดหมู่ทั่วไป\n(กำลังพัฒนา)"
			lbl.TextColor3 = Color3.fromRGB(180, 180, 180); lbl.TextSize = 15; lbl.Font = Enum.Font.GothamSemibold; lbl.TextXAlignment = Enum.TextXAlignment.Center
		elseif name == "👤 player" then
			btnPlr.BackgroundColor3 = Color3.fromRGB(60, 18, 18); btnPlr.TextColor3 = Color3.fromRGB(255, 80, 80)
			createToggleBtn(contentScroll, "ESP 🔴 ", Color3.fromRGB(180, 30, 30), Color3.fromRGB(50, 15, 15), toggleESP)
			
			-- WalkSpeed
			local speedRow = Instance.new("Frame", contentScroll); speedRow.Size = UDim2.new(0.95, 0, 0, 42); speedRow.BackgroundTransparency = 1
			local sL = Instance.new("UIListLayout", speedRow); sL.FillDirection = Enum.FillDirection.Horizontal; sL.HorizontalAlignment = Enum.HorizontalAlignment.Center; sL.VerticalAlignment = Enum.VerticalAlignment.Center; sL.Padding = UDim.new(0, 8)
			local speedBox = Instance.new("TextBox", speedRow); speedBox.Size = UDim2.new(0.6, 0, 1, 0); speedBox.BackgroundColor3 = Color3.fromRGB(35, 10, 10); speedBox.BorderSizePixel = 0; speedBox.Text = "16"; speedBox.TextColor3 = Color3.fromRGB(255, 255, 255); speedBox.TextSize = 14; speedBox.Font = Enum.Font.GothamBold; speedBox.PlaceholderText = "WalkSpeed"; speedBox.ClearTextOnFocus = false; speedBox.Active = true; Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)
			speedBox:GetPropertyChangedSignal("Text"):Connect(function() local c = string.gsub(speedBox.Text, "%D", ""); if speedBox.Text ~= c then local p = speedBox.CursorPosition; speedBox.Text = c; speedBox.CursorPosition = math.min(p, #c + 1) end end)
			local speedBtn = Instance.new("TextButton", speedRow); speedBtn.Size = UDim2.new(0.35, 0, 1, 0); speedBtn.BackgroundColor3 = Color3.fromRGB(160, 25, 25); speedBtn.BorderSizePixel = 0; speedBtn.Text = "ตกลง"; speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255); speedBtn.TextSize = 14; speedBtn.Font = Enum.Font.GothamBold; speedBtn.Active = true; Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 6)
			speedBtn.MouseButton1Click:Connect(function() local v = tonumber(speedBox.Text); if v and v > 0 and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then localPlayer.Character.Humanoid.WalkSpeed = v; speedBtn.Text = "✅ สำเร็จ"; task.delay(1, function() if speedBtn then speedBtn.Text = "ตกลง" end end) else speedBtn.Text = "❌ ผิดพลาด"; task.delay(1, function() if speedBtn then speedBtn.Text = "ตกลง" end end) end end)

			-- JumpPower
			local jumpRow = Instance.new("Frame", contentScroll); jumpRow.Size = UDim2.new(0.95, 0, 0, 42); jumpRow.BackgroundTransparency = 1
			local jL = Instance.new("UIListLayout", jumpRow); jL.FillDirection = Enum.FillDirection.Horizontal; jL.HorizontalAlignment = Enum.HorizontalAlignment.Center; jL.VerticalAlignment = Enum.VerticalAlignment.Center; jL.Padding = UDim.new(0, 8)
			local jumpBox = Instance.new("TextBox", jumpRow); jumpBox.Size = UDim2.new(0.6, 0, 1, 0); jumpBox.BackgroundColor3 = Color3.fromRGB(35, 10, 10); jumpBox.BorderSizePixel = 0; jumpBox.Text = "50"; jumpBox.TextColor3 = Color3.fromRGB(255, 255, 255); jumpBox.TextSize = 14; jumpBox.Font = Enum.Font.GothamBold; jumpBox.PlaceholderText = "JumpPower"; jumpBox.ClearTextOnFocus = false; jumpBox.Active = true; Instance.new("UICorner", jumpBox).CornerRadius = UDim.new(0, 6)
			jumpBox:GetPropertyChangedSignal("Text"):Connect(function() local c = string.gsub(jumpBox.Text, "%D", ""); if jumpBox.Text ~= c then local p = jumpBox.CursorPosition; jumpBox.Text = c; jumpBox.CursorPosition = math.min(p, #c + 1) end end)
			local jumpBtn = Instance.new("TextButton", jumpRow); jumpBtn.Size = UDim2.new(0.35, 0, 1, 0); jumpBtn.BackgroundColor3 = Color3.fromRGB(160, 25, 25); jumpBtn.BorderSizePixel = 0; jumpBtn.Text = "ตกลง"; jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255); jumpBtn.TextSize = 14; jumpBtn.Font = Enum.Font.GothamBold; jumpBtn.Active = true; Instance.new("UICorner", jumpBtn).CornerRadius = UDim.new(0, 6)
			jumpBtn.MouseButton1Click:Connect(function() local v = tonumber(jumpBox.Text); if v and v > 0 and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then local h = localPlayer.Character.Humanoid; h.UseJumpPower = true; h.JumpPower = v; jumpBtn.Text = "✅ สำเร็จ"; task.delay(1, function() if jumpBtn then jumpBtn.Text = "ตกลง" end end) else jumpBtn.Text = "❌ ผิดพลาด"; task.delay(1, function() if jumpBtn then jumpBtn.Text = "ตกลง" end end) end end)

			createToggleBtn(contentScroll, "Noclip 🚶‍♂️", Color3.fromRGB(180, 30, 30), Color3.fromRGB(50, 15, 15), toggleNoclip)
			
			local tpBtn = Instance.new("TextButton", contentScroll); tpBtn.Size = UDim2.new(0.95, 0, 0, 45); tpBtn.BackgroundColor3 = Color3.fromRGB(45, 14, 14); tpBtn.BorderSizePixel = 0; tpBtn.Text = "📍 เปิดหน้าต่าง Teleport"; tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255); tpBtn.TextSize = 16; tpBtn.Font = Enum.Font.GothamBold; tpBtn.Active = true; Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8); tpBtn.MouseButton1Click:Connect(openTPGui)
		elseif name == "🔫 ยิงปืน" then
			btnGun.BackgroundColor3 = Color3.fromRGB(60, 18, 18); btnGun.TextColor3 = Color3.fromRGB(255, 80, 80)
			createToggleBtn(contentScroll, "แสดง Hitbox 👁️", Color3.fromRGB(180, 30, 30), Color3.fromRGB(50, 15, 15), toggleShowHitbox)
			createToggleBtn(contentScroll, "ล็อกหัวใกล้สุด (LOS)", Color3.fromRGB(180, 30, 30), Color3.fromRGB(50, 15, 15), toggleAimlock)
		elseif name == "🤡 แกล้ง" then
			btnJoke.BackgroundColor3 = Color3.fromRGB(60, 18, 18); btnJoke.TextColor3 = Color3.fromRGB(255, 80, 80)
			
			-- === EXTERNAL FLING BUTTON ===
			local flingBtn = Instance.new("TextButton", contentScroll)
			flingBtn.Size = UDim2.new(0.95, 0, 0, 45)
			flingBtn.BackgroundColor3 = Color3.fromRGB(50, 15, 15)
			flingBtn.BorderSizePixel = 0
			flingBtn.Text = "🚀 เปิด Fling GUI (ภายนอก)"
			flingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			flingBtn.TextSize = 15
			flingBtn.Font = Enum.Font.GothamBold
			flingBtn.Active = true
			Instance.new("UICorner", flingBtn).CornerRadius = UDim.new(0, 8)
			
			flingBtn.MouseButton1Click:Connect(function()
				flingBtn.Text = "⏳ กำลังโหลด..."
				flingBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
				task.spawn(function()
					pcall(function()
						loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Ultimate-fling-gui-228952"))()
					end)
					task.wait(1.5)
					if flingBtn and flingBtn.Parent then
						flingBtn.Text = "🚀 เปิด Fling GUI"
						flingBtn.BackgroundColor3 = Color3.fromRGB(50, 15, 15)
					end
				end)
			end)
			
			local note = Instance.new("TextLabel", contentScroll)
			note.Size = UDim2.new(0.95, 0, 0, 20); note.BackgroundTransparency = 1
			note.Text = "(ใช้ได้เฉพาะแมพที่ตัวชนกันได้)"
			note.TextColor3 = Color3.fromRGB(150, 150, 150); note.TextSize = 12; note.Font = Enum.Font.GothamSemibold
			note.TextXAlignment = Enum.TextXAlignment.Center; note.TextWrapped = true
		end
	end

	btnGen.MouseButton1Click:Connect(function() loadCategory("ทั่วไป") end)
	btnPlr.MouseButton1Click:Connect(function() loadCategory("👤 player") end)
	btnGun.MouseButton1Click:Connect(function() loadCategory("🔫 ยิงปืน") end)
	btnJoke.MouseButton1Click:Connect(function() loadCategory("🤡 แกล้ง") end)
	loadCategory("ทั่วไป")

	-- === DRAG LOGIC ===
	local dragging, dragStart, startPos = false, Vector2.new(), UDim2.new()
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = mainFrame.Position
			local connMove = UserInputService.InputChanged:Connect(function(inp)
				if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) and dragging then
					mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (inp.Position.X - dragStart.X), startPos.Y.Scale, startPos.Y.Offset + (inp.Position.Y - dragStart.Y))
				end
			end)
			local connEnd = UserInputService.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = false; connMove:Disconnect(); connEnd:Disconnect() end
			end)
		end
	end)

	local tpDragging, tpDragStart, tpStartPos = false, Vector2.new(), UDim2.new()
	tpHeader.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			tpDragging = true; tpDragStart = input.Position; tpStartPos = tpMainFrame.Position
			local connMove = UserInputService.InputChanged:Connect(function(inp)
				if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) and tpDragging then
					tpMainFrame.Position = UDim2.new(tpStartPos.X.Scale, tpStartPos.X.Offset + (inp.Position.X - tpDragStart.X), tpStartPos.Y.Scale, tpStartPos.Y.Offset + (inp.Position.Y - tpDragStart.Y))
				end
			end)
			local connEnd = UserInputService.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then tpDragging = false; connMove:Disconnect(); connEnd:Disconnect() end
			end)
		end
	end)

	-- === MINIMIZE & CLOSE ===
	local isMin = false
	minBtn.MouseButton1Click:Connect(function()
		isMin = not isMin; splitContainer.Visible = not isMin
		mainFrame:TweenSize(UDim2.fromOffset(290, isMin and 40 or 300), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
	end)
	closeBtn.MouseButton1Click:Connect(function()
		toggleESP(false); toggleShowHitbox(false); toggleAimlock(false); toggleNoclip(false)
		screenGui:Destroy(); tpScreenGui:Destroy()
	end)
	screenGui:GetPropertyChangedSignal("Parent"):Connect(function()
		if not screenGui.Parent then toggleESP(false); toggleShowHitbox(false); toggleAimlock(false); toggleNoclip(false) end
	end)

	print("[ReaperHUB 💀 V0.8] โหลดสำเร็จ | External Fling Loader | No Fly | Delta Optimized")
end)

