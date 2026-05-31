-- Pumpkitz Hub 🎃 V0.9.2 | Kill Aura External Loader + Delta Optimized
task.spawn(function()
	repeat task.wait() until game:IsLoaded()

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local localPlayer = Players.LocalPlayer
	local playerGui = localPlayer:WaitForChild("PlayerGui", 10)
	if not playerGui then error("[Pumpkitz Hub] PlayerGui ไม่พบ หรือถูกบล็อก") end

	-- === MAIN GUI FUNCTION ===
	local function loadMainGUI()
		if not playerGui or not playerGui.Parent then return end
		
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "PumpkitzHub_V09_2"
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
		mainFrame.BackgroundColor3 = Color3.fromRGB(20, 8, 2)
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
		Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(255, 140, 0)
		Instance.new("UIGradient", mainFrame).Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 10, 3)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 15, 5))
		})

		local header = Instance.new("Frame", mainFrame)
		header.Name = "Header"
		header.Size = UDim2.new(1, 0, 0, 40)
		header.BackgroundColor3 = Color3.fromRGB(35, 12, 4)
		header.BorderSizePixel = 0
		Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)
		Instance.new("UIGradient", header).Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 20, 6)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 10, 3))
		})

		local title = Instance.new("TextLabel", header)
		title.Size = UDim2.new(1, -85, 1, 0)
		title.Position = UDim2.new(0, 12, 0, 0)
		title.BackgroundTransparency = 1
		title.Text = "Pumpkitz Hub 🎃 V0.9.2"
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.TextSize = 18
		title.Font = Enum.Font.GothamBold
		title.TextXAlignment = Enum.TextXAlignment.Left

		local minBtn = Instance.new("TextButton", header)
		minBtn.Size = UDim2.fromOffset(32, 28)
		minBtn.Position = UDim2.new(1, -75, 0, 6)
		minBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 6)
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
		closeBtn.BackgroundColor3 = Color3.fromRGB(240, 120, 20)
		closeBtn.BorderSizePixel = 0
		closeBtn.Text = "X"
		closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeBtn.TextSize = 20
		closeBtn.Font = Enum.Font.GothamBold
		Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
		closeBtn.Active = true

		local splitContainer = Instance.new("Frame", mainFrame)
		splitContainer.Name = "SplitContainer"
		splitContainer.Size = UDim2.new(1, 0, 1, -40)
		splitContainer.Position = UDim2.new(0, 0, 0, 40)
		splitContainer.BackgroundColor3 = Color3.fromRGB(20, 8, 2)
		splitContainer.BorderSizePixel = 0
		splitContainer.Active = true

		local catScroll = Instance.new("ScrollingFrame", splitContainer)
		catScroll.Name = "CategoryList"
		catScroll.Size = UDim2.new(0, 100, 1, 0)
		catScroll.BackgroundTransparency = 1
		catScroll.BorderSizePixel = 0
		catScroll.ScrollBarThickness = 3
		catScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
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
		contentScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
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
						hl.Adornee = p.Character; hl.FillColor = Color3.fromRGB(255, 140, 0)
						hl.FillTransparency = 0; hl.OutlineTransparency = 1
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = p.Character
						espHighlights[p] = hl
					end
					p.CharacterAdded:Connect(function(char)
						task.wait(0.2)
						if espActive then
							local hl = Instance.new("Highlight")
							hl.Adornee = char; hl.FillColor = Color3.fromRGB(255, 140, 0)
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
		tpScreenGui.Name = "PumpkitzHub_TP_V09_2"
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
		tpMainFrame.BackgroundColor3 = Color3.fromRGB(25, 10, 3)
		tpMainFrame.BorderSizePixel = 0
		tpMainFrame.Visible = false
		tpMainFrame.Parent = tpScreenGui
		Instance.new("UICorner", tpMainFrame).CornerRadius = UDim.new(0, 10)
		Instance.new("UIStroke", tpMainFrame).Color = Color3.fromRGB(255, 140, 0)
		Instance.new("UIGradient", tpMainFrame).Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 12, 4)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 8, 2))
		})

		local tpHeader = Instance.new("Frame", tpMainFrame)
		tpHeader.Size = UDim2.new(1, 0, 0, 35)
		tpHeader.BackgroundColor3 = Color3.fromRGB(40, 14, 5)
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
		tpClose.BackgroundColor3 = Color3.fromRGB(220, 100, 20)
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
		tpScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
		tpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tpScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		tpScroll.Active = true
		local tpListLayout = Instance.new("UIListLayout", tpScroll)
		tpListLayout.Padding = UDim.new(0, 6)
		tpListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local tpConfirm = Instance.new("TextButton", tpMainFrame)
		tpConfirm.Size = UDim2.new(0.9, 0, 0, 38)
		tpConfirm.Position = UDim2.new(0.05, 0, 1, -45)
		tpConfirm.BackgroundColor3 = Color3.fromRGB(200, 90, 15)
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
					btn.Size = UDim2.new(0.95, 0, 0, 32); btn.BackgroundColor3 = Color3.fromRGB(45, 15, 5)
					btn.BorderSizePixel = 0; btn.Text = p.Name; btn.TextColor3 = Color3.fromRGB(210, 210, 210)
					btn.TextSize = 14; btn.Font = Enum.Font.GothamSemibold; btn.Active = true
					Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
					btn.MouseButton1Click:Connect(function()
						selectedTarget = p
						for _, b in pairs(tpScroll:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(45, 15, 5); b.TextColor3 = Color3.fromRGB(210, 210, 210) end end
						btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0); btn.TextColor3 = Color3.fromRGB(255, 255, 255)
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

		-- === SHOW HITBOX SYSTEM (Orange) ===
		local hitboxActive = false
		local hitboxHighlights = {}
		local function toggleShowHitbox(state)
			hitboxActive = state
			local function applyVisualHitbox(char, state)
				if not char then return end
				if state then
					if not hitboxHighlights[char] then
						local hl = Instance.new("Highlight")
						hl.Adornee = char; hl.FillColor = Color3.fromRGB(255, 165, 0)
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

		-- === INFINITE MULTI-JUMP ===
		local infJumpActive = false
		local infJumpConn = nil
		local jumpCount = 0
		local jumpDebounce = false
		local function toggleInfJump(state)
			infJumpActive = state; jumpCount = 0
			if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
			if state then
				infJumpConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if infJumpActive and (input.KeyCode == Enum.KeyCode.Space or input.UserInputType == Enum.UserInputType.Touch) then
						if jumpDebounce then return end; jumpDebounce = true
						task.delay(0.15, function() jumpDebounce = false end)
						if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
							local hum = localPlayer.Character.Humanoid; local hrp = localPlayer.Character.HumanoidRootPart
							if hum:GetState() == Enum.HumanoidStateType.Freefall then jumpCount = jumpCount + 1; hrp.Velocity = Vector3.new(hrp.Velocity.X, math.min(50 + (jumpCount * 12), 180), hrp.Velocity.Z) else jumpCount = 0 end
						end
					end
				end)
			else jumpDebounce = false end
		end

		-- === UI MANAGEMENT ===
		local function clearContent()
			for _, child in pairs(contentScroll:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
		end

		local function createToggleBtn(parent, text, onCol, offCol, callback)
			local btn = Instance.new("TextButton", parent)
			btn.Size = UDim2.new(0.95, 0, 0, 45); btn.BackgroundColor3 = offCol; btn.BorderSizePixel = 0
			btn.Text = text; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.TextSize = 16; btn.Font = Enum.Font.GothamBold; btn.Active = true
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
			btn.Size = UDim2.new(0.9, 0, 0, 38); btn.BackgroundColor3 = Color3.fromRGB(45, 15, 5); btn.BorderSizePixel = 0
			btn.Text = text; btn.TextColor3 = Color3.fromRGB(200, 200, 200); btn.TextSize = 14; btn.Font = Enum.Font.GothamBold; btn.Active = true
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
			return btn
		end

		local btnGen = createCatBtn("ทั่วไป")
		local btnPlr = createCatBtn("👤 player")
		local btnCombat = createCatBtn("⚔️ ต่อสู้")
		local btnJoke = createCatBtn("🤡 แกล้ง")
		local btnOther = createCatBtn("🌐 สคริปต์เกมอื่น")

		local function loadCategory(name)
			clearContent()
			for _, b in ipairs({btnGen, btnPlr, btnCombat, btnJoke, btnOther}) do
				b.BackgroundColor3 = Color3.fromRGB(45, 15, 5); b.TextColor3 = Color3.fromRGB(200, 200, 200)
			end
			
			if name == "ทั่วไป" then
				btnGen.BackgroundColor3 = Color3.fromRGB(65, 20, 6); btnGen.TextColor3 = Color3.fromRGB(255, 180, 80)
				local lbl = Instance.new("TextLabel", contentScroll)
				lbl.Size = UDim2.new(0.9, 0, 0, 60); lbl.BackgroundTransparency = 1
				lbl.Text = "หมวดหมู่ทั่วไป\n(กำลังพัฒนา)"
				lbl.TextColor3 = Color3.fromRGB(180, 180, 180); lbl.TextSize = 15; lbl.Font = Enum.Font.GothamSemibold; lbl.TextXAlignment = Enum.TextXAlignment.Center
			elseif name == "👤 player" then
				btnPlr.BackgroundColor3 = Color3.fromRGB(65, 20, 6); btnPlr.TextColor3 = Color3.fromRGB(255, 180, 80)
				createToggleBtn(contentScroll, "ESP 🟠 ", Color3.fromRGB(230, 120, 20), Color3.fromRGB(55, 18, 6), toggleESP)
				
				local speedRow = Instance.new("Frame", contentScroll); speedRow.Size = UDim2.new(0.95, 0, 0, 42); speedRow.BackgroundTransparency = 1
				local sL = Instance.new("UIListLayout", speedRow); sL.FillDirection = Enum.FillDirection.Horizontal; sL.HorizontalAlignment = Enum.HorizontalAlignment.Center; sL.VerticalAlignment = Enum.VerticalAlignment.Center; sL.Padding = UDim.new(0, 8)
				local speedBox = Instance.new("TextBox", speedRow); speedBox.Size = UDim2.new(0.6, 0, 1, 0); speedBox.BackgroundColor3 = Color3.fromRGB(35, 12, 4); speedBox.BorderSizePixel = 0; speedBox.Text = "16"; speedBox.TextColor3 = Color3.fromRGB(255, 255, 255); speedBox.TextSize = 14; speedBox.Font = Enum.Font.GothamBold; speedBox.PlaceholderText = "WalkSpeed"; speedBox.ClearTextOnFocus = false; speedBox.Active = true; Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)
				speedBox:GetPropertyChangedSignal("Text"):Connect(function() local c = string.gsub(speedBox.Text, "%D", ""); if speedBox.Text ~= c then local p = speedBox.CursorPosition; speedBox.Text = c; speedBox.CursorPosition = math.min(p, #c + 1) end end)
				local speedBtn = Instance.new("TextButton", speedRow); speedBtn.Size = UDim2.new(0.35, 0, 1, 0); speedBtn.BackgroundColor3 = Color3.fromRGB(200, 90, 15); speedBtn.BorderSizePixel = 0; speedBtn.Text = "ตกลง"; speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255); speedBtn.TextSize = 14; speedBtn.Font = Enum.Font.GothamBold; speedBtn.Active = true; Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 6)
				speedBtn.MouseButton1Click:Connect(function() local v = tonumber(speedBox.Text); if v and v > 0 and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then localPlayer.Character.Humanoid.WalkSpeed = v; speedBtn.Text = "✅ สำเร็จ"; task.delay(1, function() if speedBtn then speedBtn.Text = "ตกลง" end end) else speedBtn.Text = "❌ ผิดพลาด"; task.delay(1, function() if speedBtn then speedBtn.Text = "ตกลง" end end) end end)

				local jumpRow = Instance.new("Frame", contentScroll); jumpRow.Size = UDim2.new(0.95, 0, 0, 42); jumpRow.BackgroundTransparency = 1
				local jL = Instance.new("UIListLayout", jumpRow); jL.FillDirection = Enum.FillDirection.Horizontal; jL.HorizontalAlignment = Enum.HorizontalAlignment.Center; jL.VerticalAlignment = Enum.VerticalAlignment.Center; jL.Padding = UDim.new(0, 8)
				local jumpBox = Instance.new("TextBox", jumpRow); jumpBox.Size = UDim2.new(0.6, 0, 1, 0); jumpBox.BackgroundColor3 = Color3.fromRGB(35, 12, 4); jumpBox.BorderSizePixel = 0; jumpBox.Text = "50"; jumpBox.TextColor3 = Color3.fromRGB(255, 255, 255); jumpBox.TextSize = 14; jumpBox.Font = Enum.Font.GothamBold; jumpBox.PlaceholderText = "JumpPower"; jumpBox.ClearTextOnFocus = false; jumpBox.Active = true; Instance.new("UICorner", jumpBox).CornerRadius = UDim.new(0, 6)
				jumpBox:GetPropertyChangedSignal("Text"):Connect(function() local c = string.gsub(jumpBox.Text, "%D", ""); if jumpBox.Text ~= c then local p = jumpBox.CursorPosition; jumpBox.Text = c; jumpBox.CursorPosition = math.min(p, #c + 1) end end)
				local jumpBtn = Instance.new("TextButton", jumpRow); jumpBtn.Size = UDim2.new(0.35, 0, 1, 0); jumpBtn.BackgroundColor3 = Color3.fromRGB(200, 90, 15); jumpBtn.BorderSizePixel = 0; jumpBtn.Text = "ตกลง"; jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255); jumpBtn.TextSize = 14; jumpBtn.Font = Enum.Font.GothamBold; jumpBtn.Active = true; Instance.new("UICorner", jumpBtn).CornerRadius = UDim.new(0, 6)
				jumpBtn.MouseButton1Click:Connect(function() local v = tonumber(jumpBox.Text); if v and v > 0 and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then local h = localPlayer.Character.Humanoid; h.UseJumpPower = true; h.JumpPower = v; jumpBtn.Text = "✅ สำเร็จ"; task.delay(1, function() if jumpBtn then jumpBtn.Text = "ตกลง" end end) else jumpBtn.Text = "❌ ผิดพลาด"; task.delay(1, function() if jumpBtn then jumpBtn.Text = "ตกลง" end end) end end)

				createToggleBtn(contentScroll, "Noclip 🚶‍♂️", Color3.fromRGB(230, 120, 20), Color3.fromRGB(55, 18, 6), toggleNoclip)
				createToggleBtn(contentScroll, "กระโดดไม่จำกัด 🔄", Color3.fromRGB(230, 120, 20), Color3.fromRGB(55, 18, 6), toggleInfJump)
				
				local flyBtn = Instance.new("TextButton", contentScroll)
				flyBtn.Size = UDim2.new(0.95, 0, 0, 45); flyBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); flyBtn.BorderSizePixel = 0
				flyBtn.Text = "Fly (บิน)"; flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255); flyBtn.TextSize = 15; flyBtn.Font = Enum.Font.GothamBold; flyBtn.Active = true
				Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 8)
				flyBtn.MouseButton1Click:Connect(function()
					flyBtn.Text = "⏳ กำลังโหลด..."; flyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
					task.spawn(function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-universal-fly-111281"))() end); task.wait(1.5); if flyBtn and flyBtn.Parent then flyBtn.Text = "Fly (บิน)"; flyBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end)
				end)
				
				local tpBtn = Instance.new("TextButton", contentScroll); tpBtn.Size = UDim2.new(0.95, 0, 0, 45); tpBtn.BackgroundColor3 = Color3.fromRGB(45, 15, 5); tpBtn.BorderSizePixel = 0; tpBtn.Text = "📍 เปิดหน้าต่าง Teleport"; tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255); tpBtn.TextSize = 16; tpBtn.Font = Enum.Font.GothamBold; tpBtn.Active = true; Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8); tpBtn.MouseButton1Click:Connect(openTPGui)
				
			elseif name == "⚔️ ต่อสู้" then
				btnCombat.BackgroundColor3 = Color3.fromRGB(65, 20, 6); btnCombat.TextColor3 = Color3.fromRGB(255, 180, 80)
				createToggleBtn(contentScroll, "แสดง Hitbox 👁️", Color3.fromRGB(230, 120, 20), Color3.fromRGB(55, 18, 6), toggleShowHitbox)
				createToggleBtn(contentScroll, "ล็อกหัวใกล้สุด (LOS)", Color3.fromRGB(230, 120, 20), Color3.fromRGB(55, 18, 6), toggleAimlock)
				
				local hitboxExpBtn = Instance.new("TextButton", contentScroll)
				hitboxExpBtn.Size = UDim2.new(0.95, 0, 0, 45); hitboxExpBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); hitboxExpBtn.BorderSizePixel = 0
				hitboxExpBtn.Text = "ขยายhitbox"; hitboxExpBtn.TextColor3 = Color3.fromRGB(255, 255, 255); hitboxExpBtn.TextSize = 15; hitboxExpBtn.Font = Enum.Font.GothamBold; hitboxExpBtn.Active = true
				Instance.new("UICorner", hitboxExpBtn).CornerRadius = UDim.new(0, 8)
				hitboxExpBtn.MouseButton1Click:Connect(function()
					hitboxExpBtn.Text = "⏳ กำลังโหลด..."; hitboxExpBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
					task.spawn(function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Hitbox-Expander-224681"))() end); task.wait(1.5); if hitboxExpBtn and hitboxExpBtn.Parent then hitboxExpBtn.Text = "ขยายhitbox"; hitboxExpBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end)
				end)
				
				-- === KILL AURA BUTTON ===
				local killAuraBtn = Instance.new("TextButton", contentScroll)
				killAuraBtn.Size = UDim2.new(0.95, 0, 0, 45)
				killAuraBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6)
				killAuraBtn.BorderSizePixel = 0
				killAuraBtn.Text = "คิล ออร่า"
				killAuraBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				killAuraBtn.TextSize = 15
				killAuraBtn.Font = Enum.Font.GothamBold
				killAuraBtn.Active = true
				Instance.new("UICorner", killAuraBtn).CornerRadius = UDim.new(0, 8)
				
				killAuraBtn.MouseButton1Click:Connect(function()
					killAuraBtn.Text = "⏳ กำลังโหลด..."
					killAuraBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
					task.spawn(function()
						pcall(function()
							loadstring(game:HttpGet('https://raw.githubusercontent.com/amdzy088/Kill-aura-slect-universal/refs/heads/main/Kill%20aura%20select%20universal'))()
						end)
						task.wait(1.5)
						if killAuraBtn and killAuraBtn.Parent then
							killAuraBtn.Text = "คิล ออร่า"
							killAuraBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6)
						end
					end)
				end)
				
			elseif name == "🤡 แกล้ง" then
				btnJoke.BackgroundColor3 = Color3.fromRGB(65, 20, 6); btnJoke.TextColor3 = Color3.fromRGB(255, 180, 80)
				
				local flingBtn = Instance.new("TextButton", contentScroll)
				flingBtn.Size = UDim2.new(0.95, 0, 0, 45); flingBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); flingBtn.BorderSizePixel = 0
				flingBtn.Text = "🚀 เปิด Fling GUI (ภายนอก)"; flingBtn.TextColor3 = Color3.fromRGB(255, 255, 255); flingBtn.TextSize = 15; flingBtn.Font = Enum.Font.GothamBold; flingBtn.Active = true
				Instance.new("UICorner", flingBtn).CornerRadius = UDim.new(0, 8)
				flingBtn.MouseButton1Click:Connect(function()
					flingBtn.Text = "⏳ กำลังโหลด..."; flingBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
					task.spawn(function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Ultimate-fling-gui-228952"))() end); task.wait(1.5); if flingBtn and flingBtn.Parent then flingBtn.Text = "🚀 เปิด Fling GUI (ภายนอก)"; flingBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end)
				end)
				
				local unanchorBtn = Instance.new("TextButton", contentScroll)
				unanchorBtn.Size = UDim2.new(0.95, 0, 0, 45); unanchorBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); unanchorBtn.BorderSizePixel = 0
				unanchorBtn.Text = "ดึงพาร์ทที่ไม่ Anchor"; unanchorBtn.TextColor3 = Color3.fromRGB(255, 255, 255); unanchorBtn.TextSize = 15; unanchorBtn.Font = Enum.Font.GothamBold; unanchorBtn.Active = true
				Instance.new("UICorner", unanchorBtn).CornerRadius = UDim.new(0, 8)
				unanchorBtn.MouseButton1Click:Connect(function()
					unanchorBtn.Text = "⏳ กำลังโหลด..."; unanchorBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
					task.spawn(function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Natural-Disaster-Survival-Super-ring-V4-24296"))() end); task.wait(1.5); if unanchorBtn and unanchorBtn.Parent then unanchorBtn.Text = "ดึงพาร์ทที่ไม่ Anchor"; unanchorBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end)
				end)
				
				local note = Instance.new("TextLabel", contentScroll); note.Size = UDim2.new(0.95, 0, 0, 40); note.BackgroundTransparency = 1
				note.Text = "⚠️ ใช้ในเกมที่เกี่ยวข้องเท่านั้น:\n• Natural Disaster Survival\n• เกมที่มีพาร์ทไม่ Anchor\nหากกดแล้วไม่เกิดอะไรขึ้น อาจเป็นเพราะ:\n• ไม่ใช่เกมที่เหมาะสม\n• สคริปต์อัปเดตหรือล่ม"
				note.TextColor3 = Color3.fromRGB(150, 150, 150); note.TextSize = 11; note.Font = Enum.Font.GothamSemibold
				note.TextXAlignment = Enum.TextXAlignment.Left; note.TextWrapped = true
				
			elseif name == "🌐 สคริปต์เกมอื่น" then
				btnOther.BackgroundColor3 = Color3.fromRGB(65, 20, 6); btnOther.TextColor3 = Color3.fromRGB(255, 180, 80)
				local mm2Btn = Instance.new("TextButton", contentScroll); mm2Btn.Size = UDim2.new(0.95, 0, 0, 45); mm2Btn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); mm2Btn.BorderSizePixel = 0
				mm2Btn.Text = "MM2"; mm2Btn.TextColor3 = Color3.fromRGB(255, 255, 255); mm2Btn.TextSize = 15; mm2Btn.Font = Enum.Font.GothamBold; mm2Btn.Active = true; Instance.new("UICorner", mm2Btn).CornerRadius = UDim.new(0, 8)
				mm2Btn.MouseButton1Click:Connect(function() mm2Btn.Text = "⏳ กำลังโหลด..."; mm2Btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100); task.spawn(function() pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/M4VOWJ8IAKSR5WFRCCJ7AW5IW/ScrFr/refs/heads/main/MM2'))() end); task.wait(1.5); if mm2Btn and mm2Btn.Parent then mm2Btn.Text = "MM2"; mm2Btn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end) end)
				
				local zombieBtn = Instance.new("TextButton", contentScroll); zombieBtn.Size = UDim2.new(0.95, 0, 0, 45); zombieBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); zombieBtn.BorderSizePixel = 0
				zombieBtn.Text = "Survive zombie arena"; zombieBtn.TextColor3 = Color3.fromRGB(255, 255, 255); zombieBtn.TextSize = 15; zombieBtn.Font = Enum.Font.GothamBold; zombieBtn.Active = true; Instance.new("UICorner", zombieBtn).CornerRadius = UDim.new(0, 8)
				zombieBtn.MouseButton1Click:Connect(function() zombieBtn.Text = "⏳ กำลังโหลด..."; zombieBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100); task.spawn(function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VoidDeveloper67/Void-Hub/refs/heads/main/VoidHub.lua", true))() end); task.wait(1.5); if zombieBtn and zombieBtn.Parent then zombieBtn.Text = "Survive zombie arena"; zombieBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end) end)
				
				local bfBtn = Instance.new("TextButton", contentScroll); bfBtn.Size = UDim2.new(0.95, 0, 0, 45); bfBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); bfBtn.BorderSizePixel = 0
				bfBtn.Text = "BloxFruits"; bfBtn.TextColor3 = Color3.fromRGB(255, 255, 255); bfBtn.TextSize = 15; bfBtn.Font = Enum.Font.GothamBold; bfBtn.Active = true; Instance.new("UICorner", bfBtn).CornerRadius = UDim.new(0, 8)
				bfBtn.MouseButton1Click:Connect(function() bfBtn.Text = "⏳ กำลังโหลด..."; bfBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100); task.spawn(function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end); task.wait(1.5); if bfBtn and bfBtn.Parent then bfBtn.Text = "BloxFruits"; bfBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end) end)
				
				local nightsBtn = Instance.new("TextButton", contentScroll); nightsBtn.Size = UDim2.new(0.95, 0, 0, 45); nightsBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6); nightsBtn.BorderSizePixel = 0
				nightsBtn.Text = "99 nights"; nightsBtn.TextColor3 = Color3.fromRGB(255, 255, 255); nightsBtn.TextSize = 15; nightsBtn.Font = Enum.Font.GothamBold; nightsBtn.Active = true; Instance.new("UICorner", nightsBtn).CornerRadius = UDim.new(0, 8)
				nightsBtn.MouseButton1Click:Connect(function() nightsBtn.Text = "⏳ กำลังโหลด..."; nightsBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100); task.spawn(function() pcall(function() loadstring(game:HttpGet("https://foxname.top/loader"))() end); task.wait(1.5); if nightsBtn and nightsBtn.Parent then nightsBtn.Text = "99 nights"; nightsBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 6) end end) end)
				
				local note = Instance.new("TextLabel", contentScroll); note.Size = UDim2.new(0.95, 0, 0, 65); note.BackgroundTransparency = 1
				note.Text = "⚠️ ใช้ในเกมที่เกี่ยวข้องเท่านั้น:\n• 99 Nights (FoxLoader)\n• BloxFruits (QuantumOnyx)\n• MM2 / Survive Zombie Arena\nหากกดแล้วไม่เกิดอะไรขึ้น อาจเป็นเพราะ:\n• ไม่ใช่เกมที่เหมาะสม\n• สคริปต์อัปเดตหรือล่ม"
				note.TextColor3 = Color3.fromRGB(150, 150, 150); note.TextSize = 11; note.Font = Enum.Font.GothamSemibold
				note.TextXAlignment = Enum.TextXAlignment.Left; note.TextWrapped = true
			end
		end

		btnGen.MouseButton1Click:Connect(function() loadCategory("ทั่วไป") end)
		btnPlr.MouseButton1Click:Connect(function() loadCategory("👤 player") end)
		btnCombat.MouseButton1Click:Connect(function() loadCategory("⚔️ ต่อสู้") end)
		btnJoke.MouseButton1Click:Connect(function() loadCategory("🤡 แกล้ง") end)
		btnOther.MouseButton1Click:Connect(function() loadCategory("🌐 สคริปต์เกมอื่น") end)
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
			toggleESP(false); toggleShowHitbox(false); toggleAimlock(false); toggleNoclip(false); toggleInfJump(false)
			screenGui:Destroy(); tpScreenGui:Destroy()
		end)
		screenGui:GetPropertyChangedSignal("Parent"):Connect(function()
			if not screenGui.Parent then toggleESP(false); toggleShowHitbox(false); toggleAimlock(false); toggleNoclip(false); toggleInfJump(false) end
		end)

		print("[Pumpkitz Hub 🎃 V0.9.2] โหลดสำเร็จ | Kill Aura External Added | Delta Optimized")
	end

	-- === LOADING SCREEN ===
	local loadingGui = Instance.new("ScreenGui")
	loadingGui.Name = "PumpkitzHub_Loading"; loadingGui.ResetOnSpawn = false
	loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; loadingGui.IgnoreGuiInset = true
	loadingGui.DisplayOrder = 9999; loadingGui.Enabled = true; loadingGui.Parent = playerGui

	local loadingFrame = Instance.new("Frame"); loadingFrame.Name = "LoadingFrame"
	loadingFrame.Size = UDim2.fromScale(1, 1); loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 8, 2)
	loadingFrame.BorderSizePixel = 0; loadingFrame.Parent = loadingGui
	Instance.new("UIGradient", loadingFrame).Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 10, 3)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 15, 5))})

	local loadingLogo = Instance.new("TextLabel", loadingFrame)
	loadingLogo.Size = UDim2.new(1, 0, 0, 80); loadingLogo.Position = UDim2.fromScale(0.5, 0.3); loadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
	loadingLogo.BackgroundTransparency = 1; loadingLogo.Text = "Pumpkitz Hub 🎃"; loadingLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
	loadingLogo.TextSize = 32; loadingLogo.Font = Enum.Font.GothamBold; loadingLogo.TextXAlignment = Enum.TextXAlignment.Center

	local loadingVersion = Instance.new("TextLabel", loadingFrame)
	loadingVersion.Size = UDim2.new(1, 0, 0, 30); loadingVersion.Position = UDim2.fromScale(0.5, 0.42); loadingVersion.AnchorPoint = Vector2.new(0.5, 0.5)
	loadingVersion.BackgroundTransparency = 1; loadingVersion.Text = "V0.9.2 | Delta Optimized"; loadingVersion.TextColor3 = Color3.fromRGB(200, 200, 200)
	loadingVersion.TextSize = 16; loadingVersion.Font = Enum.Font.GothamSemibold; loadingVersion.TextXAlignment = Enum.TextXAlignment.Center

	local loadingBar = Instance.new("Frame", loadingFrame); loadingBar.Name = "LoadingBar"
	loadingBar.Size = UDim2.new(0.6, 0, 0, 8); loadingBar.Position = UDim2.fromScale(0.5, 0.55); loadingBar.AnchorPoint = Vector2.new(0.5, 0.5)
	loadingBar.BackgroundColor3 = Color3.fromRGB(55, 18, 6); loadingBar.BorderSizePixel = 0; Instance.new("UICorner", loadingBar).CornerRadius = UDim.new(0, 4)

	local loadingBarFill = Instance.new("Frame", loadingBar); loadingBarFill.Name = "LoadingBarFill"
	loadingBarFill.Size = UDim2.new(0, 0, 1, 0); loadingBarFill.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
	loadingBarFill.BorderSizePixel = 0; Instance.new("UICorner", loadingBarFill).CornerRadius = UDim.new(0, 4)

	local loadingStatus = Instance.new("TextLabel", loadingFrame)
	loadingStatus.Size = UDim2.new(1, 0, 0, 25); loadingStatus.Position = UDim2.fromScale(0.5, 0.65); loadingStatus.AnchorPoint = Vector2.new(0.5, 0.5)
	loadingStatus.BackgroundTransparency = 1; loadingStatus.Text = "กำลังโหลดทรัพยากร..."; loadingStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
	loadingStatus.TextSize = 14; loadingStatus.Font = Enum.Font.GothamSemibold; loadingStatus.TextXAlignment = Enum.TextXAlignment.Center

	local creditsFrame = Instance.new("Frame", loadingFrame)
	creditsFrame.Size = UDim2.new(1, 0, 0, 70); creditsFrame.Position = UDim2.fromScale(0.5, 0.85); creditsFrame.AnchorPoint = Vector2.new(0.5, 0.5); creditsFrame.BackgroundTransparency = 1

	local creditTitle = Instance.new("TextLabel", creditsFrame)
	creditTitle.Size = UDim2.new(1, 0, 0, 25); creditTitle.Position = UDim2.fromScale(0.5, 0.2); creditTitle.AnchorPoint = Vector2.new(0.5, 0.5); creditTitle.BackgroundTransparency = 1
	creditTitle.Text = "ทำโดย:Winning"; creditTitle.TextColor3 = Color3.fromRGB(255, 255, 255); creditTitle.TextSize = 15; creditTitle.Font = Enum.Font.GothamBold; creditTitle.TextXAlignment = Enum.TextXAlignment.Center

	local creditAssistant = Instance.new("TextLabel", creditsFrame)
	creditAssistant.Size = UDim2.new(1, 0, 0, 25); creditAssistant.Position = UDim2.fromScale(0.5, 0.6); creditAssistant.AnchorPoint = Vector2.new(0.5, 0.5); creditAssistant.BackgroundTransparency = 1
	creditAssistant.Text = "ผู้ช่วย:Qwen3.6-Plus"; creditAssistant.TextColor3 = Color3.fromRGB(200, 200, 200); creditAssistant.TextSize = 13; creditAssistant.Font = Enum.Font.GothamSemibold; creditAssistant.TextXAlignment = Enum.TextXAlignment.Center

	-- Loading Animation
	task.spawn(function()
		for i = 0, 1, 0.02 do loadingBarFill.Size = UDim2.new(i, 0, 1, 0); task.wait(0.03) end
		loadingStatus.Text = "เตรียมความพร้อม..."; task.wait(0.5)
		if loadingGui and loadingGui.Parent then loadingGui:Destroy() end
		loadMainGUI()
	end)
end)

