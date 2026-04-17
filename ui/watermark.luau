local tws: any = cloneref(game:GetService('TweenService'))
local startTime: number = os.time()
local startClock: number = os.clock()
local CoreGui: PlayerGui = (gethui and gethui())
	or (get_hidden_gui and get_hidden_gui())
	or cloneref(game:FindFirstChild("CoreGui"))
	or cloneref(game.Players.LocalPlayer.PlayerGui)

local drag: any = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/refs/heads/main/library/mercury/trash.lua"))()

---------/// Watermark UI ///---------

local watermark: Instance = Instance.new("ScreenGui")
local Frame: Instance = Instance.new("Frame")
local UICorner: Instance = Instance.new("UICorner")
local line: Instance = Instance.new("Frame")
local UIGradient: Instance = Instance.new("UIGradient")
local hub: Instance = Instance.new("TextLabel")
local time: Instance = Instance.new("TextLabel")
local network: Instance = Instance.new("TextLabel")

watermark.Name = "watermark"
watermark.Parent = CoreGui
watermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
watermark.Enabled = false
watermark.ResetOnSpawn = false

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

network.Name = "network"
network.Parent = Frame
network.AnchorPoint = Vector2.new(0.5, 0.5)
network.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
network.BackgroundTransparency = 1.000
network.BorderColor3 = Color3.fromRGB(0, 0, 0)
network.BorderSizePixel = 0
network.Position = UDim2.new(0.5, 0, 0.400000006, 0)
network.Size = UDim2.new(1, 0, 0, 18)
network.Font = Enum.Font.GothamBold
network.Text = "PING: <font color=\"#00ff84\">0</font><font color=\"#c2c2c2\">ms</font> FPS: <font color=\"#00ff84\">999</font>"
network.TextColor3 = Color3.fromRGB(255, 255, 255)
network.TextSize = 12.000
network.RichText = true

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(23, 23, 23)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 132)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(23, 23, 23))
};UIGradient.Parent = line

---------/// Watermark Function ///---------

local openUI: () -> nil = function()
    watermark.Enabled = true
    tws:Create(Frame, TweenInfo.new(2), {Position = UDim2.new(0.5, 0, 0, -45)}):Play()
end

local closeUI: () -> nil = function()
    Frame.Position = UDim2.new(0.5, 0, 0, -200)
end

local crossToName: () -> nil = function()
    tws:Create(hub, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    tws:Create(time, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    tws:Create(network, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
end

local crossToTime: () -> nil = function()
    tws:Create(hub, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    tws:Create(time, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    tws:Create(network, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
end

local crossToNetwork: () -> nil = function()
    tws:Create(hub, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    tws:Create(time, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    tws:Create(network, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
end

---------/// Check Time ///---------

local formatTime: (seconds: number) -> string = function(seconds: number)
    local minutes: number = math.floor(seconds / 60)
    local hours: number = math.floor(minutes / 60)
    minutes = minutes % 60
    seconds = seconds % 60
    return string.format(
        "<font color=\"#00ff84\">%d</font><font color=\"#c2c2c2\">Hours</font> <font color=\"#00ff84\">%d</font><font color=\"#c2c2c2\">Minutes</font> <font color=\"#00ff84\">%d</font><font color=\"#c2c2c2\">Seconds</font>",
        hours, minutes, seconds
    )
end

---------/// Lerp Color ///---------

local lerp: (a: number, b: number, t: number) -> number = function(a: number, b: number, t: number) return a + (b - a) * t end
local colorLerp: (c1: Color3, c2: Color3, t: any) -> Color3 = function(c1: Color3, c2: Color3, t: any) return Color3.new(lerp(c1.R, c2.R, t), lerp(c1.G, c2.G, t), lerp(c1.B, c2.B, t)) end

local colorToHex: (color: Color3) -> string = function(color: Color3)
    return string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
end

---------/// Check Ping ///---------

local getPingColor: (ping: number) -> string = function(ping: number)
    if ping < 100 then ping = 0 end

    local minPing: number = 0
    local maxPing: number = 300
    
    local t: number = math.clamp(ping, minPing, maxPing) / maxPing

    local green: Color3 = Color3.fromRGB(0, 255, 132)
    local yellow: Color3 = Color3.fromRGB(255, 255, 0)
    local red: Color3 = Color3.fromRGB(255, 102, 102)

    local color;
    if t < 0.5 then
        color = colorLerp(green, yellow, t * 2)
    else
        color = colorLerp(yellow, red, (t - 0.5) * 2)
    end

    return (color and colorToHex(color))
end

---------/// Check FPS ///---------

local getFpsColor: (fps: number) -> string = function(fps: number)
    local minFPS: number = 0
    local maxFPS: number = 60
    
    local t: number = 1 - math.clamp(fps, minFPS, maxFPS) / maxFPS

    local green: Color3 = Color3.fromRGB(0, 255, 132)
    local yellow: Color3 = Color3.fromRGB(255, 255, 0)
    local red: Color3 = Color3.fromRGB(255, 102, 102)

    local color;
    if t < 0.5 then
        color = colorLerp(green, yellow, t * 2)
    else
        color = colorLerp(yellow, red, (t - 0.5) * 2)
    end

    return (color and colorToHex(color))
end

local fpsVar: number = 60
local frames: {} = {}

cloneref(game:GetService("RunService")).PostSimulation:Connect(function()
    local updateClock = os.clock()
    for i = #frames, 1, -1 do
        frames[i + 1] = frames[i] >= updateClock - 1 and frames[i] or nil
    end
    frames[1] = updateClock
    fpsVar = (os.clock() - startClock >= 1 and #frames or #frames / (os.clock() - startClock))
end)

---------/// Start Watermark ///---------

local Client: Instance = cloneref(game:GetService('Players')).LocalPlayer

task.spawn(function()
	while true do task.wait()
        local pings: number = math.floor(Client:GetNetworkPing() * 1000)
		time.Text = "RUNTIME: " .. formatTime(os.time() - startTime)
        network.Text = "PING: <font color=\"" .. getPingColor(pings) .. "\">" .. tostring(pings) .. "</font><font color=\"#c2c2c2\">ms</font> FPS: <font color=\"" .. getFpsColor(fpsVar) .. "\">" .. tostring(fpsVar) .. "</font>"
	end
end)

task.spawn(function()
	while true do task.wait()
        crossToName();task.wait(0.3 + 2.5)
        crossToTime();task.wait(0.3 + 8)
        crossToNetwork();task.wait(0.3 + 5)
    end
end)

closeUI();crossToTime();task.wait(0.4);openUI()
drag(Frame, Frame)
