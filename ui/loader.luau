local module = {};
local TweenService = game:GetService('TweenService');

module.CoreGui = (gethui and gethui()) or game:FindFirstChild('CoreGui') or game.Players.LocalPlayer.PlayerGui;

function module:RandomString() : string
    return string.char(math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102));	
end;

function module:NewInput(frame : Frame , Callback : () -> ()) : TextButton
    local Button = Instance.new('TextButton',frame);

    Button.ZIndex = frame.ZIndex + 10;
    Button.Size = UDim2.fromScale(1,1);
    Button.BackgroundTransparency = 1;
    Button.TextTransparency = 1;

    if Callback then
        Button.MouseButton1Click:Connect(Callback);
    end;

    return Button;
end;

function module:CreateAnimation(Instance: Instance , Time: number , Style : Enum.EasingStyle , Property : {[string] : any}) : Tween
    local Tween = TweenService:Create(Instance,TweenInfo.new(Time or 1 , Style or Enum.EasingStyle.Quint),Property);

    Tween:Play();

    return Tween;
end;

local current = 0
function module:getRanColor()
    current = current + 1

    print(current)
    if current == 1 then -- A
        return Color3.fromRGB(255, 179, 176)
    elseif current == 2 then -- L
        return Color3.fromRGB(255, 218, 176)
    elseif current == 3 then -- C
        return Color3.fromRGB(251, 255, 176)
    elseif current == 4 then -- H
        return Color3.fromRGB(176, 255, 198)
    elseif current == 5 then -- E
        return Color3.fromRGB(176, 247, 255)
    elseif current == 6 then -- M
        return Color3.fromRGB(176, 180, 255)
    elseif current == 7 then -- Y
        current = 0
        return Color3.fromRGB(221, 176, 255)
    end
    
    return Color3.fromRGB(255, 255, 255)
end

function module:LoadInit(config)
    config = config or {};
    config.Text = config.Text or "ALCHEMY";
    config.Size = config.Size or 65;
    config.Duration = config.Duration or 3;
    
    local LoadUI = Instance.new("ScreenGui")
    local KeyList = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local blur = Instance.new('BlurEffect');
    
    blur.Size = 0;
    blur.Parent = game:GetService('Lighting');
    
    LoadUI.Parent = module.CoreGui;
    LoadUI.ResetOnSpawn = false
    LoadUI.ZIndexBehavior = Enum.ZIndexBehavior.Global;
    LoadUI.IgnoreGuiInset = true;

    KeyList.Name = "KeyList"
    KeyList.Parent = LoadUI
    KeyList.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyList.BackgroundTransparency = 1.000
    KeyList.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyList.BorderSizePixel = 0
    KeyList.Position = UDim2.new(0.5, 0, 0.5, 0)
    KeyList.Size = UDim2.new(1, 0, 0, 1)

    UIListLayout.Parent = KeyList
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 5)
    
    local center = Instance.new("Frame")

    center.Name = "center"
    center.Parent = LoadUI
    center.AnchorPoint = Vector2.new(0.5, 0.5)
    center.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    center.BackgroundTransparency = 1.000
    center.BorderColor3 = Color3.fromRGB(0, 0, 0)
    center.BorderSizePixel = 0
    center.Position = UDim2.new(0.5, 0, 0.5, 0)
    center.Size = UDim2.new(0, 1, 0, 1)
    
    local GetText = function(as)
        local Ascii = Instance.new("TextLabel")

        Ascii.Name = "Ascii"
        Ascii.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Ascii.BackgroundTransparency = 1.000
        Ascii.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Ascii.BorderSizePixel = 0
        Ascii.Size = UDim2.new(0, config.Size, 0, config.Size)
        Ascii.Font = Enum.Font.GothamBold
        Ascii.Text = as
        Ascii.TextColor3 = module:getRanColor()
        Ascii.TextSize = 100.000
        Ascii.AnchorPoint = Vector2.new(0,0)
        Ascii.TextWrapped = true
        
        return Ascii;
    end;
    
    local textCache = {};
    
    do
        local ct = 1;

        -- create the text position
        string.gsub(config.Text,'.',function(value)
            local m = GetText(value);

            m.TextTransparency = 1;
            m.Parent = KeyList;
            
            textCache[ct] = m;
            
            ct += 1;
        end)
    end;
    
    module:CreateAnimation(blur,1.75,Enum.EasingStyle.Quint,{
        Size = 55
    });
    
    task.wait(0.25)
    
    local setPosition = function(m : Frame , v : Frame , a : UDim2)
        a = a or UDim2.fromOffset(0,0);
        m.Position = UDim2.fromOffset(v.AbsolutePosition.X,v.AbsolutePosition.Y + math.abs(LoadUI.AbsolutePosition.Y)) + a;
    end;
    
    local getPosition = function(v : Frame)
        return UDim2.fromOffset(v.AbsolutePosition.X,v.AbsolutePosition.Y + math.abs(LoadUI.AbsolutePosition.Y));
    end;
    
    local getScale = function(fr : Frame)
        return UDim2.fromOffset(fr.AbsoluteSize.X / 2 , fr.AbsoluteSize.Y / 2)
    end;
    
    local asciies = {};
    
    for i = 1 , #config.Text do
        local m = GetText(config.Text:sub(i,i));
        m.TextTransparency = 1;
        
        if i == 1 then -- first text
            setPosition(m,center,UDim2.fromOffset(0,250) - getScale(m));
            m.Parent = LoadUI;
            
            module:CreateAnimation(m,1,Enum.EasingStyle.Quint,{
                Position = getPosition(center) - getScale(m),
                TextTransparency = 0,
            });
            
            task.wait(1.4)
            
            module:CreateAnimation(m,0.5,Enum.EasingStyle.Quint,{
                Position = getPosition(textCache[i]),
                TextTransparency = 0,
            });
            
            task.wait(0.65);
        else
            setPosition(m,textCache[i],UDim2.fromOffset(0,100));
            m.Parent = LoadUI;
            
            module:CreateAnimation(m,0.75,Enum.EasingStyle.Quint,{
                Position = getPosition(textCache[i]),
                TextTransparency = 0,
            });
            
            task.wait(0.075)
        end;
        
        table.insert(asciies,m)
    end;
    
    task.wait(config.Duration);
    
    for i = #asciies , 1 , -1 do
        local m = asciies[i];
        
        module:CreateAnimation(m,0.5,Enum.EasingStyle.Quint,{
            TextTransparency = 1,
        });
        
        task.wait(0.065)
    end;
    
    task.wait(0.5);
    
    module:CreateAnimation(blur,1.75,Enum.EasingStyle.Quint,{
        Size = 0
    });
    
    task.delay(1,function()
        LoadUI:Destroy();
        blur:Destroy();
    end)
end;

return module;
