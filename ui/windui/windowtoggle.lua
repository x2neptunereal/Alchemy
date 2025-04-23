local createAlchemyToggle = function()
    local ioToggle = Instance.new("ScreenGui")
    local ImageButton = Instance.new("ImageButton")
    local UICorner = Instance.new("UICorner")

    local pgui = protectgui or (syn and syn.protect_gui) or function() end

    ioToggle.Name = "Alchemy"
    ioToggle.Parent = gethui and gethui() or game.CoreGui
    ioToggle.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    pgui(ioToggle)

    ImageButton.Parent = ioToggle
    ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ImageButton.BackgroundTransparency = 0.3
    ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageButton.BorderSizePixel = 0
    ImageButton.Position = UDim2.new(0.5, 0, 0.104474165, 0)
    ImageButton.Size = UDim2.new(0, 50, 0, 50)
    ImageButton.Image = "rbxassetid://84221975933832"

    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = ImageButton

    ImageButton.MouseButton1Down:connect(function()
		game:GetService("VirtualInputManager"):SendKeyEvent(true, 305, false, game)
		game:GetService("VirtualInputManager"):SendKeyEvent(false, 305, false, game)
        game:GetService('TweenService'):Create(ImageButton, TweenInfo.new(0.4), {
            Position = MainPos,
            Size = UDim2.new(0, 60, 0, 60)
        }):Play();
    end)

    ImageButton.MouseButton1Up:connect(function()
        game:GetService('TweenService'):Create(ImageButton, TweenInfo.new(0.4), {
            Size = UDim2.new(0, 50, 0, 50)
        }):Play();
    end)

    function dragify(Frame, object)
        dragToggle = nil
        dragSpeed = 0
        dragInput = nil
        dragStart = nil
        dragPos = nil
        function updateInput(input)
            Delta = input.Position - dragStart
            Position =
                UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale,
                    startPos.Y.Offset + Delta.Y)
            game:GetService("TweenService"):Create(object, TweenInfo.new(dragSpeed), { Position = Position }):Play()
        end

        Frame.InputBegan:Connect(
            function(input)
                if
                    (input.UserInputType == Enum.UserInputType.MouseButton1 or
                        input.UserInputType == Enum.UserInputType.Touch)
                then
                    dragToggle = true
                    dragStart = input.Position
                    startPos = object.Position
                    input.Changed:Connect(
                        function()
                            if (input.UserInputState == Enum.UserInputState.End) then
                                dragToggle = false
                            end
                        end
                    )
                end
            end
        )
        Frame.InputChanged:Connect(
            function(input)
                if
                    (input.UserInputType == Enum.UserInputType.MouseMovement or
                        input.UserInputType == Enum.UserInputType.Touch)
                then
                    dragInput = input
                end
            end
        )
        game:GetService("UserInputService").InputChanged:Connect(
            function(input)
                if (input == dragInput and dragToggle) then
                    updateInput(input)
                end
            end
        )
    end

    dragify(ImageButton, ImageButton)
end

return createAlchemyToggle
