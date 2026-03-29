local tws: any = game:GetService('TweenService')
local CoreGui: PlayerGui = (gethui and gethui())
	or (get_hidden_gui and get_hidden_gui())
	or cloneref(game:FindFirstChild("CoreGui"))
	or cloneref(game.LocalPlayer.PlayerGui);

local Advertise: Instance = Instance.new("ScreenGui")
Advertise.Name = "Advertise"
Advertise.Parent = CoreGui
Advertise.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Advertise.ResetOnSpawn = false

local getFileName: (name: string) -> string = function(name: string)
    local real = name:gsub('[\\/:*?"<>|]', '')
    real = real:match("^%s*(.-)%s*$")
    return real
end

local getImage: (link: string) -> any = function(link: string)
	if getcustomasset and writefile and isfile then
        local filename = getFileName(link)
        if isfile(filename) then
            return getcustomasset(filename)
        else
            writefile(
                filename,
                game:HttpGet(link)
            )
            return getcustomasset(filename)
        end
	else
		return ""
	end
end

return {
    create = function(img: string)
        local ImageLabel: Instance = Instance.new("ImageLabel")
        local UICorner: Instance = Instance.new("UICorner")
        local TextButton: Instance = Instance.new("TextButton")

        ImageLabel.Name = tostring(math.random(10000, 99999))
        ImageLabel.Parent = Advertise
        ImageLabel.AnchorPoint = Vector2.new(0.5, 1)
        ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ImageLabel.BorderSizePixel = 0
        ImageLabel.Position = UDim2.new(0.5, 0, 1.5, -40)
        ImageLabel.Size = UDim2.new(0.0999999866, 500, 0.0504173823, 125)
        ImageLabel.Image = getImage(img)
        UICorner.CornerRadius = UDim.new(0, 7)
        UICorner.Parent = ImageLabel
        TextButton.Parent = ImageLabel
        TextButton.AnchorPoint = Vector2.new(1, 0)
        TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.BackgroundTransparency = 1.000
        TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextButton.BorderSizePixel = 0
        TextButton.Position = UDim2.new(1, 0, 0, 0)
        TextButton.Size = UDim2.new(0, 30, 0, 30)
        TextButton.Font = Enum.Font.FredokaOne
        TextButton.Text = "X"
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.TextSize = 18.000
        TextButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.TextTransparency = 1

        local popUp: () -> nil = function() tws:Create(ImageLabel, TweenInfo.new(0.5), {Position = UDim2.new(0.5, 0, 1, -40)}):Play() end
        local fadeOut: () -> nil = function() tws:Create(ImageLabel, TweenInfo.new(0.5), {Position = UDim2.new(0.5, 0, 1.5, -40)}):Play() end

        popUp();task.wait(0.6);tws:Create(TextButton, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

        TextButton.MouseButton1Down:connect(function()
            fadeOut();task.wait(0.6)
            ImageLabel.Visible = false
        end)
    end
}
