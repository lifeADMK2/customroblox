--// CUSTOM MOBILE CONTROLS
--// SMOOTH SIZE SLIDER VERSION (DRAGGABLE SLIDERS + HIDE/SHOW BUTTON)
--// DELTA MOBILE + POTASSIUM PC

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--========================
-- DISABLE DEFAULT CONTROLS
--========================

pcall(function()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)

pcall(function()
	local PlayerModule = require(
		player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
	)
	local Controls = PlayerModule:GetControls()
	Controls:Disable()
end)

--========================
-- GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Name = "MobileControls"
gui.ResetOnSpawn = false

pcall(function()
	gui.Parent = game.CoreGui
end)

if not gui.Parent then
	gui.Parent = player:WaitForChild("PlayerGui")
end

--========================
-- JUMP BUTTON
--========================

local jump = Instance.new("ImageButton")
jump.Parent = gui

jump.Size = UDim2.new(0,90,0,90)
jump.Position = UDim2.new(1,-120,1,-140)

jump.BackgroundTransparency = 1
jump.Image = "rbxassetid://6031094678"

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(1,0)
jumpCorner.Parent = jump

--========================
-- JOYSTICK BASE
--========================

local moveFrame = Instance.new("Frame")
moveFrame.Parent = gui

moveFrame.Size = UDim2.new(0,140,0,140)
moveFrame.Position = UDim2.new(0,40,1,-180)

moveFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
moveFrame.BackgroundTransparency = 0.3
moveFrame.BorderSizePixel = 0

local moveCorner = Instance.new("UICorner")
moveCorner.CornerRadius = UDim.new(1,0)
moveCorner.Parent = moveFrame

--========================
-- JOYSTICK KNOB
--========================

local knob = Instance.new("Frame")
knob.Parent = moveFrame

knob.Size = UDim2.new(0,60,0,60)
knob.Position = UDim2.new(0.5,-30,0.5,-30)

knob.BackgroundColor3 = Color3.fromRGB(170,0,255)
knob.BorderSizePixel = 0

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1,0)
knobCorner.Parent = knob

--================================================
-- MENU MANAGEMENT (Quản lý cụm nút điều khiển ẩn/hiện)
--================================================

local editMode = false
local menuVisible = true

-- Khung chứa các nút điều khiển để dễ quản lý ẩn hiện
local menuContainer = Instance.new("Frame")
menuContainer.Parent = gui
menuContainer.Size = UDim2.new(0, 240, 0, 40)
menuContainer.Position = UDim2.new(0.5, -120, 0, 20)
menuContainer.BackgroundTransparency = 1

-- Nút EDIT chính
local editButton = Instance.new("TextButton")
editButton.Parent = menuContainer
editButton.Size = UDim2.new(0, 130, 1, 0)
editButton.Position = UDim2.new(0, 0, 0, 0)
editButton.Text = "EDIT : OFF"
editButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
editButton.TextColor3 = Color3.new(1,1,1)
editButton.Font = Enum.Font.SourceSansBold
editButton.TextSize = 16

local editCorner = Instance.new("UICorner")
editCorner.CornerRadius = UDim.new(0,10)
editCorner.Parent = editButton

-- Nút ẨN MENU cài đặt
local hideButton = Instance.new("TextButton")
hideButton.Parent = menuContainer
hideButton.Size = UDim2.new(0, 100, 1, 0)
hideButton.Position = UDim2.new(0, 140, 0, 0)
hideButton.Text = "HIDE UI"
hideButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
hideButton.TextColor3 = Color3.new(1,1,1)
hideButton.Font = Enum.Font.SourceSansBold
hideButton.TextSize = 16

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0,10)
hideCorner.Parent = hideButton

-- Nút HIỆN MENU (Nút nhỏ xuất hiện ở góc khi menu bị ẩn)
local showButton = Instance.new("TextButton")
showButton.Parent = gui
showButton.Size = UDim2.new(0, 40, 0, 40)
showButton.Position = UDim2.new(0, 10, 0, 10) -- Nằm gọn ở góc trên cùng bên trái
showButton.Text = "⚙️"
showButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
showButton.BackgroundTransparency = 0.2
showButton.TextColor3 = Color3.new(1, 1, 1)
showButton.TextSize = 20
showButton.Visible = false

local showCorner = Instance.new("UICorner")
showCorner.CornerRadius = UDim.new(0, 10)
showCorner.Parent = showButton

--================================================
-- FUNCTION TO CREATE SLIDERS
--================================================

local function createSlider(name, positionXOffset)
	local sizeBar = Instance.new("Frame")
	sizeBar.Name = name .. "Bar"
	sizeBar.Parent = gui
	sizeBar.Size = UDim2.new(0, 16, 0, 180)
	sizeBar.Position = UDim2.new(0.5, positionXOffset, 0, 100)
	sizeBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	sizeBar.Active = true
	sizeBar.Visible = false

	local sizeBarCorner = Instance.new("UICorner")
	sizeBarCorner.CornerRadius = UDim.new(1, 0)
	sizeBarCorner.Parent = sizeBar

	local label = Instance.new("TextLabel")
	label.Parent = sizeBar
	label.Size = UDim2.new(0, 80, 0, 20)
	label.Position = UDim2.new(0.5, -40, 0, -25)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextSize = 12

	local sizeSlider = Instance.new("Frame")
	sizeSlider.Name = name .. "Slider"
	sizeSlider.Parent = sizeBar
	sizeSlider.Size = UDim2.new(0, 26, 0, 26)
	sizeSlider.Position = UDim2.new(0.5, -13, 0.5, -13)
	sizeSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local sizeSliderCorner = Instance.new("UICorner")
	sizeSliderCorner.CornerRadius = UDim.new(1, 0)
	sizeSliderCorner.Parent = sizeSlider

	return sizeBar, sizeSlider
end

local joyBar, joySlider = createSlider("JOYSTICK", -70)
local jumpBar, jumpSlider = createSlider("JUMP", 50)

--========================
-- INTERACTION TOGGLES (Xử lý bật/tắt UI)
--========================

-- Tắt mở chế độ chỉnh sửa (EDIT MODE)
editButton.MouseButton1Click:Connect(function()
	editMode = not editMode

	if editMode then
		editButton.Text = "EDIT : ON"
		editButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
		joyBar.Visible = true
		jumpBar.Visible = true
	else
		editButton.Text = "EDIT : OFF"
		editButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
		joyBar.Visible = false
		jumpBar.Visible = false
	end
end)

-- Bấm ẩn toàn bộ cụm menu cài đặt
hideButton.MouseButton1Click:Connect(function()
	-- Trước khi ẩn, ép tắt luôn chế độ Edit nếu nó đang bật
	editMode = false
	editButton.Text = "EDIT : OFF"
	editButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
	joyBar.Visible = false
	jumpBar.Visible = false
	
	-- Ẩn menu chính, hiện nút bánh răng nhỏ
	menuContainer.Visible = false
	showButton.Visible = true
end)

-- Bấm hiển thị lại cụm menu cài đặt
showButton.MouseButton1Click:Connect(function()
	menuContainer.Visible = true
	showButton.Visible = false
end)

--========================
-- JUMP BUTTON CLICK
--========================

jump.MouseButton1Down:Connect(function()
	if editMode then return end
	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.Jump = true
	end
end)

--========================
-- JOYSTICK LOGIC
--========================

local dragging = false
local currentInput = nil

moveFrame.InputBegan:Connect(function(input)
	if editMode then return end
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		currentInput = input
	end
end)

UIS.InputEnded:Connect(function(input)
	if input == currentInput then
		dragging = false
		currentInput = nil
		local knobSize = knob.Size.X.Offset / 2
		knob.Position = UDim2.new(0.5, -knobSize, 0.5, -knobSize)
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid:Move(Vector3.zero, true)
		end
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging then
		local pos = UIS:GetMouseLocation()
		local absPos = moveFrame.AbsolutePosition
		local absSize = moveFrame.AbsoluteSize
		local center = absPos + absSize/2
		local delta = Vector2.new(pos.X, pos.Y) - center
		local maxDist = moveFrame.Size.X.Offset / 2.5

		if delta.Magnitude > maxDist then
			delta = delta.Unit * maxDist
		end

		local knobSize = knob.Size.X.Offset / 2
		knob.Position = UDim2.new(0.5, delta.X - knobSize, 0.5, delta.Y - knobSize)

		local moveDir = Vector3.new(delta.X/maxDist, 0, delta.Y/maxDist)
		local char = player.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid:Move(moveDir, true)
		end
	end
end)

--================================================
-- UNIVERSAL DRAG POSITION SYSTEM
--================================================

local draggingUI = nil
local dragStart
local startPos

local function setupDrag(guiObject)
	guiObject.InputBegan:Connect(function(input)
		if not editMode then return end
		
		if guiObject == joyBar and input.Target == joySlider then return end
		if guiObject == jumpBar and input.Target == jumpSlider then return end

		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingUI = guiObject
			dragStart = UIS:GetMouseLocation()
			startPos = guiObject.Position
		end
	end)
end

setupDrag(jump)
setupDrag(moveFrame)
setupDrag(joyBar)
setupDrag(jumpBar)

UIS.InputChanged:Connect(function(input)
	if draggingUI and editMode then
		local currentPos = UIS:GetMouseLocation()
		local delta = currentPos - dragStart
		draggingUI.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingUI = nil
	end
end)

--================================================
-- INDEPENDENT SMOOTH SLIDER LOGIC
--================================================

local draggingJoySize = false
local draggingJumpSize = false

local targetJoyPercent = 0.2
local currentJoyPercent = 0.2

local targetJumpPercent = 0.2
local currentJumpPercent = 0.2

joySlider.InputBegan:Connect(function(input)
	if not editMode then return end
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingJoySize = true
	end
end)

jumpSlider.InputBegan:Connect(function(input)
	if not editMode then return end
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingJumpSize = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingJoySize = false
		draggingJumpSize = false
	end
end)

UIS.InputChanged:Connect(function(input)
	local mousePos = UIS:GetMouseLocation()
	
	if draggingJoySize then
		local barY = joyBar.AbsolutePosition.Y
		local barHeight = joyBar.AbsoluteSize.Y
		targetJoyPercent = math.clamp((mousePos.Y - barY) / barHeight, 0, 1)
	end
	
	if draggingJumpSize then
		local barY = jumpBar.AbsolutePosition.Y
		local barHeight = jumpBar.AbsoluteSize.Y
		targetJumpPercent = math.clamp((mousePos.Y - barY) / barHeight, 0, 1)
	end
end)

-- Cập nhật kích thước mượt mà theo từng Frame
RunService.RenderStepped:Connect(function()
	currentJoyPercent += (targetJoyPercent - currentJoyPercent) * 0.2
	currentJumpPercent += (targetJumpPercent - currentJumpPercent) * 0.2

	joySlider.Position = UDim2.new(0.5, -13, currentJoyPercent, -13)
	jumpSlider.Position = UDim2.new(0.5, -13, currentJumpPercent, -13)

	-- 1. CẬP NHẬT KÍCH THƯỚC PHÍM JOYSTICK
	local joySize = 80 + (280 * currentJoyPercent)
	moveFrame.Size = UDim2.new(0, joySize, 0, joySize)
	
	local knobSize = joySize / 2.3
	knob.Size = UDim2.new(0, knobSize, 0, knobSize)
	if not dragging then
		knob.Position = UDim2.new(0.5, -knobSize/2, 0.5, -knobSize/2)
	end

	-- 2. CẬP NHẬT KÍCH THƯỚC PHÍM JUMP
	local jumpSize = 40 + (220 * currentJumpPercent)
	jump.Size = UDim2.new(0, jumpSize, 0, jumpSize)
end)

print("done")
