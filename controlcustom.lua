--// MOBILE CONTROL EDITOR

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

--========================
-- SETTINGS
--========================

local jumpSize = 90
local joystickSize = 140

--========================
-- JUMP BUTTON
--========================

local jump = Instance.new("TextButton")
jump.Parent = gui
jump.Size = UDim2.new(0, jumpSize, 0, jumpSize)
jump.Position = UDim2.new(1, -120, 1, -140)
jump.Text = "JUMP"
jump.TextScaled = true
jump.BackgroundColor3 = Color3.fromRGB(170,0,255)

local jc = Instance.new("UICorner")
jc.CornerRadius = UDim.new(1,0)
jc.Parent = jump

--========================
-- JOYSTICK
--========================

local joystick = Instance.new("Frame")
joystick.Parent = gui
joystick.Size = UDim2.new(0, joystickSize, 0, joystickSize)
joystick.Position = UDim2.new(0, 40, 1, -180)
joystick.BackgroundColor3 = Color3.fromRGB(50,50,50)

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(1,0)
cc.Parent = joystick

--========================
-- EDIT PANEL
--========================

local panel = Instance.new("Frame")
panel.Parent = gui
panel.Size = UDim2.new(0, 220, 0, 170)
panel.Position = UDim2.new(0.5,-110,0.1,0)
panel.BackgroundColor3 = Color3.fromRGB(20,20,20)

local pc = Instance.new("UICorner")
pc.CornerRadius = UDim.new(0,15)
pc.Parent = panel

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = panel
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "CONTROL EDITOR"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

--========================
-- JUMP SIZE BUTTONS
--========================

local jumpPlus = Instance.new("TextButton")
jumpPlus.Parent = panel
jumpPlus.Size = UDim2.new(0,90,0,40)
jumpPlus.Position = UDim2.new(0,10,0,40)
jumpPlus.Text = "Jump +"

local jumpMinus = Instance.new("TextButton")
jumpMinus.Parent = panel
jumpMinus.Size = UDim2.new(0,90,0,40)
jumpMinus.Position = UDim2.new(0,120,0,40)
jumpMinus.Text = "Jump -"

--========================
-- JOYSTICK SIZE BUTTONS
--========================

local joyPlus = Instance.new("TextButton")
joyPlus.Parent = panel
joyPlus.Size = UDim2.new(0,90,0,40)
joyPlus.Position = UDim2.new(0,10,0,95)
joyPlus.Text = "Joy +"

local joyMinus = Instance.new("TextButton")
joyMinus.Parent = panel
joyMinus.Size = UDim2.new(0,90,0,40)
joyMinus.Position = UDim2.new(0,120,0,95)
joyMinus.Text = "Joy -"

--========================
-- FUNCTIONS
--========================

jumpPlus.MouseButton1Click:Connect(function()
	jumpSize += 10
	jump.Size = UDim2.new(0, jumpSize, 0, jumpSize)
end)

jumpMinus.MouseButton1Click:Connect(function()
	jumpSize -= 10

	if jumpSize < 40 then
		jumpSize = 40
	end

	jump.Size = UDim2.new(0, jumpSize, 0, jumpSize)
end)

joyPlus.MouseButton1Click:Connect(function()
	joystickSize += 10
	joystick.Size = UDim2.new(0, joystickSize, 0, joystickSize)
end)

joyMinus.MouseButton1Click:Connect(function()
	joystickSize -= 10

	if joystickSize < 60 then
		joystickSize = 60
	end

	joystick.Size = UDim2.new(0, joystickSize, 0, joystickSize)
end)
