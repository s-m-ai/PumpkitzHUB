-- ReaperHUB 💀 V0.4 | Scrollable TP GUI + Instant Close | Delta Optimized
task.spawn(function()
	pcall(function()
		repeat task.wait() until game:IsLoaded()

		local Players = game:GetService("Players")
		local UserInputService = game:GetService("UserInputService")
		local TweenService = game:GetService("TweenService")
		local localPlayer = Players.LocalPlayer
		local playerGui = localPlayer:WaitForChild("PlayerGui", 10)
		if not playerGui then error("[ReaperHUB] PlayerGui ไม่พบ หรือถูกบล็อก") end

		-- === MAIN GUI CORE ===
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "ReaperHUB_V04"
		screenGui.ResetOnSpawn = false
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.IgnoreGuiInset = true
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
		title.Text = "ReaperHUB 💀 V0.4"
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

		-- === SPLIT LAYOUT ===
		local splitContainer = Instance.new("Frame", mainFrame)
		splitContainer.Name = "SplitContainer"
		splitContainer.Size = UDim2.new(1, 0, 1, -40)
		splitContainer.Position = UDim2.new(0, 0, 0, 40)
		splitContainer.BackgroundColor3 = Color3.fromRGB(18, 4, 4)
		splitContainer.BorderSizePixel = 0

		local catScroll = Instance.new("ScrollingFrame", splitContainer)
		catScroll.Name = "CategoryList"
		catScroll.Size = UDim2.new(0, 100, 1, 0)
		catScroll.BackgroundTransparency = 1
		catScroll.BorderSizePixel = 0
		catScroll.ScrollBarThickness = 3
		catScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)
		catScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		catScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
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
		local conLayout = Instance.new("UIListLayout", contentScroll)
		conLayout.Padding = UDim.new(0, 8)
		conLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		-- === ESP SYSTEM (Solid Human) ===
		local espHighlights = {}
		local espActive = false
		local function toggleESP(state)
			espActive = state
			if state then
				for _, p in ipairs(Players:GetPlayers()) do
					if p ~= localPlayer and p.Character then
						local hl = Instance.new("Highlight")
						hl.Adornee = p.Character
						hl.FillColor = Color3.fromRGB(255, 0, 0)
						hl.FillTransparency = 0
						hl.OutlineTransparency = 1
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						hl.Parent = p.Character
						espHighlights[p] = hl
					end
					p.CharacterAdded:Connect(function(char)
						task.wait(0.2)
						if espActive then
							local hl = Instance.new("Highlight")
							hl.Adornee = char
							hl.FillColor = Color3.fromRGB(255, 0, 0)
							hl.FillTransparency = 0
							hl.OutlineTransparency = 1
							hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							hl.Parent = char
							espHighlights[p] = hl
						end
					end)
				end
			else
				for _, hl in pairs(espHighlights) do hl:Destroy() end
				espHighlights = {}
			end
		end

		-- === TELEPORT GUI (Scrollable) ===
		local tpGui = Instance.new("Frame", screenGui)
		tpGui.Name = "TeleportGUI"
		tpGui.Size = UDim2.fromOffset(260, 320)
		tpGui.Position = UDim2.fromScale(0.5, 0.5)
		tpGui.AnchorPoint = Vector2.new(0.5, 0.5)
		tpGui.BackgroundColor3 = Color3.fromRGB(20, 6, 6)
		tpGui.BorderSizePixel = 0
		tpGui.Visible = false
		tpGui.ZIndex = 100
		Instance.new("UICorner", tpGui).CornerRadius = UDim.new(0, 10)
		Instance.new("UIStroke", tpGui).Color = Color3.fromRGB(225, 35, 35)
		Instance.new("UIGradient", tpGui).Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 8, 8)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 4, 4))
		})

		local tpHeader = Instance.new("Frame", tpGui)
		tpHeader.Size = UDim2.new(1, 0, 0, 35)
		tpHeader.BackgroundColor3 = Color3.fromRGB(35, 10, 10)
		tpHeader.BorderSizePixel = 0
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
		Instance.new("UICorner", tpClose).CornerRadius = UDim.new(0, 4)
		tpClose.MouseButton1Click:Connect(function() tpGui.Visible = false end)

		local tpScroll = Instance.new("ScrollingFrame", tpGui)
		tpScroll.Size = UDim2.new(1, -10, 1, -85)
		tpScroll.Position = UDim2.new(0, 5, 0, 40)
		tpScroll.BackgroundTransparency = 1
		tpScroll.BorderSizePixel = 0
		tpScroll.ScrollBarThickness = 4
		tpScroll.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)
		tpScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tpScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		local tpListLayout = Instance.new("UIListLayout", tpScroll)
		tpListLayout.Padding = UDim.new(0, 6)
		tpListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local tpConfirm = Instance.new("TextButton", tpGui)
		tpConfirm.Size = UDim2.new(0.9, 0, 0, 38)
		tpConfirm.Position = UDim2.new(0.05, 0, 1, -45)
		tpConfirm.BackgroundColor3 = Color3.fromRGB(160, 25, 25)
		tpConfirm.BorderSizePixel = 0
		tpConfirm.Text = "ตกลง (Teleport)"
		tpConfirm.TextColor3 = Color3.fromRGB(255, 255, 255)
		tpConfirm.TextSize = 15
		tpConfirm.Font = Enum.Font.GothamBold
		Instance.new("UICorner", tpConfirm).CornerRadius = UDim.new(0, 7)

		local selectedTarget = nil
		local function openTPGui()
			tpGui.Visible = true
			selectedTarget = nil
			for _, c in pairs(tpScroll:GetChildren()) do if c:IsA("GuiObject") then c:Destroy() end end
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= localPlayer then
					local btn = Instance.new("TextButton", tpScroll)
					btn.Size = UDim2.new(0.95, 0, 0, 32)
					btn.BackgroundColor3 = Color3.fromRGB(45, 14, 14)
					btn.BorderSizePixel = 0
					btn.Text = p.Name
					btn.TextColor3 = Color3.fromRGB(210, 210, 210)
					btn.TextSize = 14
					btn.Font = Enum.Font.GothamSemibold
					Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
					btn.MouseButton1Click:Connect(function()
						selectedTarget = p
						for _, b in pairs(tpScroll:GetChildren()) do
							if b:IsA("TextButton") then
								b.BackgroundColor3 = Color3.fromRGB(45, 14, 14)
								b.TextColor3 = Color3.fromRGB(210, 210, 210)
							end
						end
						btn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
						btn.TextColor3 = Color3.fromRGB(255, 255, 255)
					end)
				end
			end
		end

		tpConfirm.MouseButton1Click:Connect(function()
			if selectedTarget and selectedTarget.Character and selectedTarget.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
				localPlayer.Character.HumanoidRootPart.CFrame = selectedTarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, -2)
			end
			tpGui.Visible = false
		end)

		-- === UI MANAGEMENT ===
		local function clearContent()
			for _, child in pairs(contentScroll:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
		end

		local function createToggleBtn(parent, text, onCol, offCol, callback)
			local btn = Instance.new("TextButton", parent)
			btn.Size = UDim2.new(0.95, 0, 0, 45)
			btn.BackgroundColor3 = offCol
			btn.BorderSizePixel = 0
			btn.Text = text
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.TextSize = 16
			btn.Font = Enum.Font.GothamBold
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
			btn.BackgroundColor3 = Color3.fromRGB(40, 12, 12)
			btn.BorderSizePixel = 0
			btn.Text = text
			btn.TextColor3 = Color3.fromRGB(200, 200, 200)
			btn.TextSize = 14
			btn.Font = Enum.Font.GothamBold
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
			return btn
		end

		local btnGen = createCatBtn("ทั่วไป")
		local btnPlr = createCatBtn("👤 player")

		local function loadCategory(name)
			clearContent()
			btnGen.BackgroundColor3 = Color3.fromRGB(40, 12, 12); btnGen.TextColor3 = Color3.fromRGB(200, 200, 200)
			btnPlr.BackgroundColor3 = Color3.fromRGB(40, 12, 12); btnPlr.TextColor3 = Color3.fromRGB(200, 200, 200)
			if name == "ทั่วไป" then
				btnGen.BackgroundColor3 = Color3.fromRGB(60, 18, 18); btnGen.TextColor3 = Color3.fromRGB(255, 80, 80)
				local lbl = Instance.new("TextLabel", contentScroll)
				lbl.Size = UDim2.new(0.9, 0, 0, 60)
				lbl.BackgroundTransparency = 1
				lbl.Text = "หมวดหมู่ทั่วไป\n(กำลังพัฒนา)"
				lbl.TextColor3 = Color3.fromRGB(180, 180, 180); lbl.TextSize = 15; lbl.Font = Enum.Font.GothamSemibold; lbl.TextXAlignment = Enum.TextXAlignment.Center
			elseif name == "👤 player" then
				btnPlr.BackgroundColor3 = Color3.fromRGB(60, 18, 18); btnPlr.TextColor3 = Color3.fromRGB(255, 80, 80)
				createToggleBtn(contentScroll, "ESP 🔴 ", Color3.fromRGB(180, 30, 30), Color3.fromRGB(50, 15, 15), toggleESP)
				local tpBtn = Instance.new("TextButton", contentScroll)
				tpBtn.Size = UDim2.new(0.95, 0, 0, 45)
				tpBtn.BackgroundColor3 = Color3.fromRGB(45, 14, 14)
				tpBtn.BorderSizePixel = 0
				tpBtn.Text = "📍 Teleport to Player"
				tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				tpBtn.TextSize = 16
				tpBtn.Font = Enum.Font.GothamBold
				Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8)
				tpBtn.MouseButton1Click:Connect(openTPGui)
			end
		end

		btnGen.MouseButton1Click:Connect(function() loadCategory("ทั่วไป") end)
		btnPlr.MouseButton1Click:Connect(function() loadCategory("👤 player") end)
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
					if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
						dragging = false; connMove:Disconnect(); connEnd:Disconnect()
					end
				end)
			end
		end)

		-- === MINIMIZE ===
		local isMin = false
		minBtn.MouseButton1Click:Connect(function()
			isMin = not isMin
			splitContainer.Visible = not isMin
			mainFrame:TweenSize(UDim2.fromOffset(290, isMin and 40 or 300), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.25, true)
		end)

		-- === CLOSE (INSTANT DESTROY) ===
		closeBtn.MouseButton1Click:Connect(function()
			toggleESP(false)
			screenGui:Destroy()
		end)

		-- Auto Cleanup
		screenGui:GetPropertyChangedSignal("Parent"):Connect(function()
			if not screenGui.Parent then toggleESP(false) end
		end)

		print("[ReaperHUB 💀 V0.4] โหลดสำเร็จ | TP GUI เลื่อนได้ | ESP ทึบ | ปิดทันที")
	end)
end)

