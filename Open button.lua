-- แก้ไขเฉพาะส่วนที่เกี่ยวข้อง

function CreateCustomButton()
    -- ... (โค้ดสร้างปุ่มเหมือนเดิม) ...

    OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.fromOffset(ButtonSize, ButtonSize)
    OpenButton.Position = UDim2.fromOffset(20, 20)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.BorderSizePixel = 0
    OpenButton.AutoButtonColor = false
    OpenButton.ClipsDescendants = true
    OpenButton.ZIndex = 999999
    OpenButton.Visible = true  -- ✅ ตั้งให้แสดงเสมอตอนสร้าง
    OpenButton.Parent = ScreenGui

    -- ... (โค้ดอื่นๆ) ...
end

function ToggleWindow()
    if tick() - lastClickTime < 0.3 then return end
    lastClickTime = tick()

    if not OpenButton then return end  -- ✅ ตรวจสอบก่อนใช้

    WindowState = not WindowState
    WindowVisible = WindowState

    if WindowState then
        Window:Open()
        OpenButton.Visible = false   -- ซ่อน
    else
        Window:Close()
        OpenButton.Visible = true    -- แสดง
        -- ไม่ขยับตำแหน่ง (คงเดิม)
    end
end
