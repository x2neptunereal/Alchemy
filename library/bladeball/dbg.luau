local Console = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

Console.Name = "Console"
Console.Parent = gethui and gethui() or game:FindFirstChild('CoreGui') or game.Players.LocalPlayer:WaitForChild("PlayerGui");
Console.ResetOnSpawn = false;
Console.Enabled = false;
Console.ZIndexBehavior = Enum.ZIndexBehavior.Global;

Frame.Parent = Console
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 5, 0, 5)
Frame.Size = UDim2.new(0, 100, 0, 100)

UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

return {
	visible = function(v)
		Console.Enabled = v;
	end,
	
	add = function(text)
		local dbg = Instance.new("TextLabel")

		dbg.Name = "dbg"
		dbg.Parent = Frame
		dbg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		dbg.BackgroundTransparency = 1.000
		dbg.BorderColor3 = Color3.fromRGB(0, 0, 0)
		dbg.BorderSizePixel = 0
		dbg.Size = UDim2.new(0, 300, 0, 20)
		dbg.Font = Enum.Font.Gotham
		dbg.Text = text or ""
		dbg.TextColor3 = Color3.fromRGB(255, 255, 255)
		dbg.TextSize = 14.000
		dbg.TextStrokeTransparency = 0.800
		dbg.TextXAlignment = Enum.TextXAlignment.Left
		
		return {
			visible = function(e)
				dbg.Visible = e;
			end,
			
			text = function(t)
				dbg.Text = t;
			end,
			
			color = function(color)
				dbg.TextColor3 = color or Color3.fromRGB(255, 255, 255)
			end,
		}
	end,
};
