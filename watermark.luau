local tws: any = game:GetService('TweenService')
local startTime: number = os.time()

local watermark: Instance = Instance.new("ScreenGui")
local Frame: Instance = Instance.new("Frame")
local UICorner: Instance = Instance.new("UICorner")
local line: Instance = Instance.new("Frame")
local UIGradient: Instance = Instance.new("UIGradient")
local hub: Instance = Instance.new("TextLabel")
local time: Instance = Instance.new("TextLabel")

watermark.Name = "watermark"
watermark.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
watermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
watermark.Enabled = false
Frame.Parent = watermark
Frame.AnchorPoint = Vector2.new(0.5, 0)
Frame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 0, 10)
Frame.Size = UDim2.new(0, 280, 0, 25)
UICorner.CornerRadius = UDim.new(100, 100)
UICorner.Parent = Frame
line.Name = "line"
line.Parent = Frame
line.AnchorPoint = Vector2.new(0.5, 1)
line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line.BorderColor3 = Color3.fromRGB(0, 0, 0)
line.BorderSizePixel = 0
line.Position = UDim2.new(0.5, 0, 1, -3)
line.Size = UDim2.new(0, 252, 0, 2)
hub.Name = "hub"
hub.Parent = Frame
hub.AnchorPoint = Vector2.new(0.5, 0.5)
hub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hub.BackgroundTransparency = 1.000
hub.BorderColor3 = Color3.fromRGB(0, 0, 0)
hub.BorderSizePixel = 0
hub.Position = UDim2.new(0.5, 0, 0.400000006, 0)
hub.Size = UDim2.new(1, 0, 0, 18)
hub.Visible = true
hub.Font = Enum.Font.GothamBold
hub.Text = "ALCHEMY <font color=\"#00ff84\">HUB</font>"
hub.TextColor3 = Color3.fromRGB(255, 255, 255)
hub.TextSize = 14.000
hub.RichText = true
time.Name = "time"
time.Parent = Frame
time.AnchorPoint = Vector2.new(0.5, 0.5)
time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
time.BackgroundTransparency = 1.000
time.BorderColor3 = Color3.fromRGB(0, 0, 0)
time.BorderSizePixel = 0
time.Position = UDim2.new(0.5, 0, 0.400000006, 0)
time.Size = UDim2.new(1, 0, 0, 18)
time.Font = Enum.Font.GothamBold
time.Text = "RUNTIME: <font color=\"#00ff84\">0</font><font color=\"#c2c2c2\">Hours</font> <font color=\"#00ff84\">0</font><font color=\"#c2c2c2\">Minutes</font> <font color=\"#00ff84\">0</font><font color=\"#c2c2c2\">Seconds</font>"
time.TextColor3 = Color3.fromRGB(255, 255, 255)
time.TextSize = 12.000
time.RichText = true
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(23, 23, 23)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 132)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(23, 23, 23))
};UIGradient.Parent = line


local openUI: () -> nil = function()
    watermark.Enabled = true
    tws:Create(Frame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, 0, 0, -45)}):Play()
end

local closeUI: () -> nil = function()
    Frame.Position = UDim2.new(0.5, 0, 0, -200)
end

local crossToName: () -> nil = function()
    tws:Create(hub, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    tws:Create(time, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
end

local crossToTime: () -> nil = function()
    tws:Create(hub, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    tws:Create(time, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
end

local formatTime: (seconds: number) -> string = function(seconds: number)
    local minutes = math.floor(seconds / 60)
    local hours = math.floor(minutes / 60)
    minutes = minutes % 60
    seconds = seconds % 60
    return string.format(
        "<font color=\"#00ff84\">%d</font><font color=\"#c2c2c2\">Hours</font> <font color=\"#00ff84\">%d</font><font color=\"#c2c2c2\">Minutes</font> <font color=\"#00ff84\">%d</font><font color=\"#c2c2c2\">Seconds</font>",
        hours, minutes, seconds
    )
end

task.spawn(function()
	while true do task.wait()
		time.Text = "RUNTIME: " .. formatTime(os.time() - startTime)
	end
end)

task.spawn(function()
	while true do task.wait()
        crossToName();task.wait(0.3 + 2.5)
        crossToTime();task.wait(0.3 + 8)
    end
end)

closeUI();crossToTime();task.wait(0.4);openUI()

