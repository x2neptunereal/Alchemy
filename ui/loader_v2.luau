
export type cloneref = (target: Instance) -> Instance;
export type gethui = () -> Instance;
export type Buttons = {
    {
        Text : string,
        Icon : string,
        Callback : () -> any
    }?
};

local cloneref: cloneref = cloneref or function(f) return f end;
local gethui: gethui = gethui or function(f) return f end;

local Gui = (gethui and gethui()) or cloneref(game:FindFirstChild('CoreGui') or game:GetService('Players').LocalPlayer.PlayerGui);
local TweenService: TweenService = cloneref(game:GetService("TweenService"));
local TextService: TextService = cloneref(game:GetService("TextService"));

local Loader = {};

function Loader.input(Frame : Frame , Callback : () -> ()) : TextButton
    local Button = Instance.new('TextButton',Frame);

    Button.ZIndex = Frame.ZIndex + 10;
    Button.Size = UDim2.fromScale(1,1);
    Button.BackgroundTransparency = 1;
    Button.TextTransparency = 1;

    if Callback then
        Button.MouseButton1Click:Connect(Callback);
    end;

    return Button;
end;

function Loader.animate(instance: Instance, properties: {[string]: any}, duration: number, easingStyle: Enum.EasingStyle, easingDirection: Enum.EasingDirection, delayTime: number)
    easingStyle = easingStyle or Enum.EasingStyle.Quad;
    easingDirection = easingDirection or Enum.EasingDirection.InOut;
    duration = duration or 0.5;
    delayTime = delayTime or 0;

    local TweenInfo = TweenInfo.new(duration, easingStyle, easingDirection, 0, false, delayTime);
    local Tween = TweenService:Create(instance, TweenInfo, properties);
    Tween:Play();
    return Tween;
end;

function Loader.new()
    LoaderContent = LoaderContent or "alchemy";
    TitleContent = TitleContent or "../gateway.luau";

    local Payback = {};
    local LoaderManager = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local LoaderName = Instance.new("TextLabel")
    local UIStroke = Instance.new("UIStroke")
    local InterfaceFrame = Instance.new("Frame")
    local SmoothFrame = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    local ObjectFrame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    LoaderManager.Name = "LoaderManager?t="..tostring(tick());
    LoaderManager.Parent = Gui;
    LoaderManager.IgnoreGuiInset = true;
    LoaderManager.ResetOnSpawn = false;
    LoaderManager.ZIndexBehavior = Enum.ZIndexBehavior.Global;

    MainFrame.ClipsDescendants = true;
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = LoaderManager
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 0, 0, 37)

    Loader.animate(MainFrame,{
        Size = UDim2.new(0, 300, 0, 37)
    },0.5);

    task.delay(0.45,Loader.animate , MainFrame,{
        Size = UDim2.new(0, 300, 0, 200)
    },0.5);

    UICorner.Parent = MainFrame

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.AnchorPoint = Vector2.new(1, 0)
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(1, -10, 0, 10)
    Title.Size = UDim2.new(1, 0, 0, 15)
    Title.ZIndex = 15
    Title.Font = Enum.Font.GothamBold
    Title.Text = TitleContent
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14.000
    Title.TextTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Right

    task.delay(0.7,Loader.animate , Title,{
        TextTransparency = 0.750
    },0.5);

    LoaderName.Name = "LoaderName"
    LoaderName.Parent = MainFrame
    LoaderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LoaderName.BackgroundTransparency = 1.000
    LoaderName.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LoaderName.BorderSizePixel = 0
    LoaderName.Position = UDim2.new(0, 10, 0, 10)
    LoaderName.Size = UDim2.new(1, 0, 0, 15)
    LoaderName.ZIndex = 15
    LoaderName.Font = Enum.Font.GothamBold
    LoaderName.Text = LoaderContent
    LoaderName.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoaderName.TextSize = 14.000
    LoaderName.TextTransparency = 1
    LoaderName.TextXAlignment = Enum.TextXAlignment.Left

    task.delay(0.3,Loader.animate , LoaderName,{
        TextTransparency = 0.100
    },0.5);

    UIStroke.Thickness = 3.000
    UIStroke.Transparency = 0.950
    UIStroke.Parent = MainFrame

    InterfaceFrame.Name = "InterfaceFrame"
    InterfaceFrame.Parent = MainFrame
    InterfaceFrame.AnchorPoint = Vector2.new(0.5, 0)
    InterfaceFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InterfaceFrame.BackgroundTransparency = 1.000
    InterfaceFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InterfaceFrame.BorderSizePixel = 0
    InterfaceFrame.ClipsDescendants = true
    InterfaceFrame.Position = UDim2.new(0.5, 0, 0, 35)
    InterfaceFrame.Size = UDim2.new(1, -15, 1, -50)
    InterfaceFrame.ZIndex = 5

    SmoothFrame.Name = "SmoothFrame"
    SmoothFrame.Parent = InterfaceFrame
    SmoothFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    SmoothFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SmoothFrame.BorderSizePixel = 0
    SmoothFrame.Size = UDim2.new(1, 0, 0.699999988, 0)
    SmoothFrame.ZIndex = 15

    UIGradient.Rotation = 90
    UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.47, 0.16), NumberSequenceKeypoint.new(1.00, 1.00)}
    UIGradient.Parent = SmoothFrame

    ObjectFrame.Name = "ObjectFrame"
    ObjectFrame.Parent = InterfaceFrame
    ObjectFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ObjectFrame.BackgroundTransparency = 1.000
    ObjectFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ObjectFrame.BorderSizePixel = 0
    ObjectFrame.Size = UDim2.new(1, 0, 1, 0)
    ObjectFrame.ZIndex = 5

    UIListLayout.Parent = ObjectFrame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

    Payback.Type = {
        Error = Color3.fromRGB(255, 90, 93),
        Success = Color3.fromRGB(120, 255, 129),
        Warning = Color3.fromRGB(255, 239, 114),
        Info = Color3.fromRGB(213, 213, 213),
    };

    function Payback:AddLabel(Content: string , Type: string)
        local LabelFrame = Instance.new("Frame")
        local StatusFrame = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local UIStroke = Instance.new("UIStroke")
        local LabelMain = Instance.new("TextLabel")

        LabelFrame.Name = "LabelFrame"
        LabelFrame.Parent = ObjectFrame
        LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelFrame.BackgroundTransparency = 1.000
        LabelFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LabelFrame.BorderSizePixel = 0
        LabelFrame.ClipsDescendants = true
        LabelFrame.Size = UDim2.new(1, 0, 0, 0)

        StatusFrame.Name = "StatusFrame"
        StatusFrame.Parent = LabelFrame
        StatusFrame.AnchorPoint = Vector2.new(0, 0.5)
        StatusFrame.BackgroundColor3 = Payback.Type[Type] or Payback.Type.Success;
        StatusFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        StatusFrame.BorderSizePixel = 0
        StatusFrame.Position = UDim2.new(0, 15, 0.5, 0)
        StatusFrame.Size = UDim2.new(0, 0, 0, 0)

        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = StatusFrame

        UIStroke.Thickness = 0;
        UIStroke.Transparency = 1;
        UIStroke.Color = Color3.fromRGB(255, 255, 255)
        UIStroke.Parent = StatusFrame

        LabelMain.Name = "LabelMain"
        LabelMain.Parent = LabelFrame
        LabelMain.AnchorPoint = Vector2.new(0, 0.5)
        LabelMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelMain.BackgroundTransparency = 1.000
        LabelMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LabelMain.BorderSizePixel = 0
        LabelMain.Position = UDim2.new(0, 45, 0.5, 0)
        LabelMain.Size = UDim2.new(0, 200, 0, 15)
        LabelMain.ZIndex = 6
        LabelMain.Font = Enum.Font.GothamBold
        LabelMain.Text = Content;
        LabelMain.TextColor3 = Color3.fromRGB(255, 255, 255)
        LabelMain.TextSize = 12.000
        LabelMain.TextTransparency = 1
        LabelMain.TextXAlignment = Enum.TextXAlignment.Left

        Loader.animate(LabelFrame,{
            Size = UDim2.new(1, 0, 0, 25)
        },0.25);

        Loader.animate(LabelMain,{
            TextTransparency = 0.400,
            Position = UDim2.new(0, 35, 0.5, 0)
        },0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut);

        Loader.animate(UIStroke,{
            Thickness = 2,
            Transparency = 0.9,
        },0.6,nil,nil,0.1);

        Loader.animate(StatusFrame,{
            Size = UDim2.new(0, 12, 0, 12),
            Position = UDim2.new(0, 10, 0.5, 0)
        },0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut);

        return {
            change_type = function(new_type: string)
                Loader.animate(StatusFrame,{
                    BackgroundColor3 = Payback.Type[new_type] or Payback.Type.Success;
                },0.5);
            end,
        };
    end;

    function Payback:AddInput(Placeholder: string , Type: string)
        local InputFrame = Instance.new("Frame")
        local StatusFrame = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local UIStroke = Instance.new("UIStroke")
        local InputBackground = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local TextBox = Instance.new("TextBox")
        local UIGradient = Instance.new("UIGradient")
        local SendButton = Instance.new("TextButton")
        local UICorner_3 = Instance.new("UICorner")

        InputFrame.Name = "InputFrame"
        InputFrame.Parent = ObjectFrame
        InputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        InputFrame.BackgroundTransparency = 1.000
        InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InputFrame.BorderSizePixel = 0
        InputFrame.ClipsDescendants = true
        InputFrame.Size = UDim2.new(1, 0, 0, 0)

        StatusFrame.Name = "StatusFrame"
        StatusFrame.Parent = InputFrame
        StatusFrame.AnchorPoint = Vector2.new(0, 0.5)
        StatusFrame.BackgroundColor3 = Payback.Type[Type] or Payback.Type.Success;
        StatusFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        StatusFrame.BorderSizePixel = 0
        StatusFrame.Position = UDim2.new(0, 10, 0.5, 0)
        StatusFrame.Size = UDim2.new(0, 0, 0, 0)

        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = StatusFrame

        UIStroke.Thickness = 0
        UIStroke.Transparency = 1
        UIStroke.Color = Color3.fromRGB(255, 255, 255)
        UIStroke.Parent = StatusFrame

        InputBackground.Name = "InputBackground"
        InputBackground.Parent = InputFrame
        InputBackground.AnchorPoint = Vector2.new(0, 0.5)
        InputBackground.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        InputBackground.BackgroundTransparency = 0.600
        InputBackground.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InputBackground.BorderSizePixel = 0
        InputBackground.ClipsDescendants = true
        InputBackground.Position = UDim2.new(0, 30, 0.5, 0)
        InputBackground.Size = UDim2.new(1, -75, 0, 20)
        InputBackground.ZIndex = 5

        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = InputBackground

        TextBox.Parent = InputBackground
        TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
        TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.BackgroundTransparency = 1.000
        TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextBox.BorderSizePixel = 0
        TextBox.Position = UDim2.new(0.5, 15, 0.5, 0)
        TextBox.Size = UDim2.new(1, -10, 1, 0)
        TextBox.ZIndex = 7
        TextBox.ClearTextOnFocus = false
        TextBox.Font = Enum.Font.GothamBold
        TextBox.PlaceholderText = Placeholder
        TextBox.Text = ""
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 12.000
        TextBox.TextTransparency = 1
        TextBox.TextXAlignment = Enum.TextXAlignment.Left

        UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.01, 0.00), NumberSequenceKeypoint.new(0.99, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
        UIGradient.Parent = TextBox

        SendButton.Name = "SendButton"
        SendButton.Parent = InputFrame
        SendButton.AnchorPoint = Vector2.new(1, 0.5)
        SendButton.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        SendButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SendButton.BorderSizePixel = 0
        SendButton.Position = UDim2.new(1, -1, 0.5, 0)
        SendButton.Size = UDim2.new(0, 40, 0, 20)
        SendButton.Font = Enum.Font.GothamBold
        SendButton.Text = "Send"
        SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        SendButton.TextSize = 10.000
        SendButton.TextTransparency = 0.500

        UICorner_3.CornerRadius = UDim.new(0, 4)
        UICorner_3.Parent = SendButton

        Loader.animate(InputFrame,{
            Size = UDim2.new(1, 0, 0, 25)
        },0.25);

        Loader.animate(TextBox,{
            TextTransparency = 0.400,
            Position = UDim2.new(0.5, 0, 0.5, 0)
        },0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut);

        Loader.animate(UIStroke,{
            Thickness = 2,
            Transparency = 0.9,
        },0.6,nil,nil,0.1);

        Loader.animate(StatusFrame,{
            Size = UDim2.new(0, 12, 0, 12),
            Position = UDim2.new(0, 10, 0.5, 0)
        },0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut);

        SendButton.MouseButton1Click:Wait();

        TextBox.TextEditable = false;

        return TextBox.Text , {
            change_type = function(new_type: string)
                Loader.animate(StatusFrame,{
                    BackgroundColor3 = Payback.Type[new_type] or Payback.Type.Success;
                },0.5);
            end,
        };
    end;
    
    do
        local WhitelistFrame = Instance.new("Frame")
        local InputFrame = Instance.new("Frame")
        local TextBox = Instance.new("TextBox")
        local UIGradient = Instance.new("UIGradient")
        local UIStroke = Instance.new("UIStroke")
        local UICorner = Instance.new("UICorner")
        local ButtonsFrame = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")

        WhitelistFrame.Name = "WhitelistFrame"
        WhitelistFrame.Parent = MainFrame
        WhitelistFrame.AnchorPoint = Vector2.new(0.5, 0)
        WhitelistFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
        WhitelistFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        WhitelistFrame.BorderSizePixel = 0
        WhitelistFrame.Position = UDim2.new(1.5, 0, 0, 35)
        WhitelistFrame.Size = UDim2.new(1, -10, 1, -40)
        WhitelistFrame.ZIndex = 15

        InputFrame.Name = "InputFrame"
        InputFrame.Parent = WhitelistFrame
        InputFrame.AnchorPoint = Vector2.new(0.5, 0)
        InputFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        InputFrame.BackgroundTransparency = 0.600
        InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        InputFrame.BorderSizePixel = 0
        InputFrame.Position = UDim2.new(0.5, 0, 0, 10)
        InputFrame.Size = UDim2.new(1, -15, 0, 25)
        InputFrame.ZIndex = 16

        TextBox.Parent = InputFrame
        TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
        TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.BackgroundTransparency = 1.000
        TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextBox.BorderSizePixel = 0
        TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextBox.Size = UDim2.new(1, -10, 1, 0)
        TextBox.ZIndex = 17
        TextBox.ClearTextOnFocus = false
        TextBox.Font = Enum.Font.GothamBold
        TextBox.PlaceholderText = "License Key"
        TextBox.Text = "";
        
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 12.000
        TextBox.TextTransparency = 0.400
        TextBox.TextXAlignment = Enum.TextXAlignment.Left

        UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.01, 0.00), NumberSequenceKeypoint.new(0.99, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
        UIGradient.Parent = TextBox

        UIStroke.Transparency = 0.910
        UIStroke.Color = Color3.fromRGB(255, 255, 255)
        UIStroke.Parent = InputFrame

        UICorner.CornerRadius = UDim.new(0, 3)
        UICorner.Parent = InputFrame

        ButtonsFrame.Name = "ButtonsFrame"
        ButtonsFrame.Parent = WhitelistFrame
        ButtonsFrame.AnchorPoint = Vector2.new(0.5, 0)
        ButtonsFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        ButtonsFrame.BackgroundTransparency = 1.000
        ButtonsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ButtonsFrame.BorderSizePixel = 0
        ButtonsFrame.Position = UDim2.new(0.5, 0, 0, 45)
        ButtonsFrame.Size = UDim2.new(1, -15, 1, -50)
        ButtonsFrame.ZIndex = 16

        UIListLayout.Parent = ButtonsFrame
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)
        
        Payback.Event = Instance.new('BindableEvent',Gui);
        
        function Payback:_Button(Text : string , Callback : () -> any)
            local ButtonFrame = Instance.new("Frame")
            local UIStroke = Instance.new("UIStroke")
            local UICorner = Instance.new("UICorner")
            local Texts = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            local TextLabel = Instance.new("TextLabel")

            ButtonFrame.Name = "ButtonFrame"
            ButtonFrame.Parent = ButtonsFrame
            ButtonFrame.AnchorPoint = Vector2.new(0.5, 0)
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
            ButtonFrame.BackgroundTransparency = 0.600
            ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Position = UDim2.new(0.5, 0, 0, 45)
            ButtonFrame.Size = UDim2.new(0, 135, 0, 30)
            ButtonFrame.ZIndex = 16

            UIStroke.Transparency = 0.950
            UIStroke.Color = Color3.fromRGB(255, 255, 255)
            UIStroke.Parent = ButtonFrame

            UICorner.CornerRadius = UDim.new(0, 3)
            UICorner.Parent = ButtonFrame

            Texts.Name = "Texts"
            Texts.Parent = ButtonFrame
            Texts.AnchorPoint = Vector2.new(0.5, 0.5)
            Texts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Texts.BackgroundTransparency = 1.000
            Texts.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Texts.BorderSizePixel = 0
            Texts.Position = UDim2.new(0.5, 0, 0.5, 0)
            Texts.Size = UDim2.new(1, 0, 1, 0)
            Texts.ZIndex = 15

            UIListLayout.Parent = Texts
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            UIListLayout.Padding = UDim.new(0, 5)

            TextLabel.Parent = Texts
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(0, 55, 0, 25)
            TextLabel.ZIndex = 17
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.Text = Text
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextSize = 14.000
            TextLabel.TextTransparency = 0.300
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local size = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));
            
            TextLabel.Size = UDim2.new(0, size.X + 3, 0, 25);
            
            local mamag = Loader.input(ButtonFrame , function()
                return Callback(TextBox.Text);
            end);
            
            mamag.MouseEnter:Connect(function()
                Loader.animate(UIStroke,{
                    Transparency = 0.9
                },0.4);

                Loader.animate(TextLabel,{
                    TextTransparency = 0.2
                },0.4);
            end)
            
            mamag.MouseLeave:Connect(function()
                Loader.animate(UIStroke,{
                    Transparency = 0.950
                },0.4);
                
                Loader.animate(TextLabel,{
                    TextTransparency = 0.300
                },0.4);
            end)
        end;	
        
        function Payback:WLWarning(Type: string , Reason: string)
            TextBox.Text = Reason;
            TextBox.TextColor3 = Payback.Type[Type or "Error"];
            
            task.delay(1,function()
                TextBox.Text = "";
                
                Loader.animate(TextBox , {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                },0.7)
            end)
        end;

        function Payback:Whitelist(Buttons : Buttons)
            Loader.animate(InterfaceFrame , {
                Position = UDim2.new(-1.5, 0,0, 35)
            },0.3);
            
            Loader.animate(WhitelistFrame , {
                Position = UDim2.new(0.5, 0,0, 35)
            },0.3)
            
            for i,v in next , ButtonsFrame:GetChildren() do
                if v:IsA('Frame') then
                    v:Destroy();
                end;
            end;
            
            for i,v in next , Buttons do
                Payback:_Button(v.Text or "BUTTON" , v.Icon , v.Callback or print);
            end;
            
            Loader.animate(MainFrame , {
                Size = UDim2.new(0, 300 , 0 , UIListLayout.AbsoluteContentSize.Y + 90);
            },0.4,nil,nil,0.1);
            
            Payback.Event.Event:Wait()
        end;
        
        function Payback:CloseWhitelist()
            Loader.animate(InterfaceFrame , {
                Position = UDim2.new(0.5, 0,0, 35)
            },0.3);

            Loader.animate(WhitelistFrame , {
                Position = UDim2.new(1.5, 0,0, 35)
            },0.3)
            
            Loader.animate(MainFrame , {
                Size = UDim2.new(0, 300,0, 200);
            },0.4,nil,nil,0.1);
            
            task.wait(0.1)
            
            Payback.Event:Fire();
        end;
    end;

    function Payback:Close()

        Loader.animate(Title,{
            TextTransparency = 1
        },0.4);

        Loader.animate(InterfaceFrame,{
            Position = UDim2.new(0.5, 0, 1, 35)
        },0.7);

        Loader.animate(LoaderName,{
            TextTransparency = 1
        },0.3);

        if Loader.connectToMain then
            local decat = {}

            task.delay(0.45,Loader.animate , MainFrame,{
                Size = UDim2.new(0, 50, 0, 50)
            },0.5);

            task.delay(0.75,Loader.animate , MainFrame,{
                Position = UDim2.new(1, -14, 1, -14)
            },0.5);

            decat.Stopped = false
            task.spawn(function()
                repeat
                    task.wait(1.2)
                    Loader.animate(MainFrame,{
                        Rotation = MainFrame.Rotation + 360
                    },0.7);
                    task.wait(0.7)
                    MainFrame.Rotation = MainFrame.Rotation - 360
                until decat.Stopped
            end)
            
            decat.Frame = MainFrame
            return decat
        end

        Loader.animate(MainFrame,{
            Size = UDim2.new(0, 300, 0, 37)
        },0.5);

        task.delay(0.45,Loader.animate , MainFrame,{
            Size = UDim2.new(0, 0, 0, 37)
        },0.5);

        task.delay(1,function()
            LoaderManager:Destroy();
        end)
        
        return nil
    end;

    return Payback;
end;

return Loader;
