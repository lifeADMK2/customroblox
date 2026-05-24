--// MOBILE CUSTOM CONTROLS

local Players = game:GetService("Players")
local CAS = game:GetService("ContextActionService")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Tắt nút mặc định mobile
pcall(function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)

local PlayerModule = require(player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()
Controls:Disable()

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MobileControls"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Nút Jump
local jump = Instance.new("ImageButton")
jump.Parent = gui
jump.Size = UDim2.new(0, 90, 0, 90)
jump.Position = UDim2.new(1, -120, 1, -140)
jump.BackgroundTransparency = 1
jump.Image = "rbxassetid://6031094678" -- đổi ảnh tại đây

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(1,0)
jumpCorner.Parent = jump

-- Joystick fake
local moveFrame = Instance.new("Frame")
moveFrame.Parent = gui
moveFrame.Size = UDim2.new(0, 140, 0, 140)
moveFrame.Position = UDim2.new(0, 40, 1, -180)
moveFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
moveFrame.BackgroundTransparency = 0.3

local moveCorner = Instance.new("UICorner")
moveCorner.CornerRadius = UDim.new(1,0)
moveCorner.Parent = moveFrame

local knob = Instance.new("Frame")
knob.Parent = moveFrame
knob.Size = UDim2.new(0, 60, 0, 60)
knob.Position = UDim2.new(0.5,-30,0.5,-30)
knob.BackgroundColor3 = Color3.fromRGB(170,0,255)

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1,0)
knobCorner.Parent = knob

-- Jump function
jump.MouseButton1Down:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Jump = true
    end
end)

-- Move joystick
local dragging = false

moveFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        knob.Position = UDim2.new(0.5,-30,0.5,-30)

        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:Move(Vector3.zero)
        end
    end
end)

UIS.TouchMoved:Connect(function(input)
    if dragging then
        local pos = input.Position
        local absPos = moveFrame.AbsolutePosition
        local absSize = moveFrame.AbsoluteSize

        local center = absPos + absSize/2
        local delta = Vector2.new(pos.X, pos.Y) - center

        local maxDist = 40
        if delta.Magnitude > maxDist then
            delta = delta.Unit * maxDist
        end

        knob.Position = UDim2.new(
            0.5, delta.X - 30,
            0.5, delta.Y - 30
        )

        local moveDir = Vector3.new(
            delta.X/maxDist,
            0,
            delta.Y/maxDist
        )

        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:Move(moveDir, true)
        end
    end
end)
print("done")
