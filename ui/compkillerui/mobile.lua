--[[
    		Fatality-Dark Interface

    Author: 4lpaca
    License: MIT
    Modified by me! (@maxlasertech)
    Github: https://github.com/4lpaca-pin/CompKiller
--]]

--- Export Types ---

export type cloneref = (target: Instance) -> Instance;

export type Window = {
	Name: string,
	Keybind: string | Enum.KeyCode,
	Logo: string,
	Scale: UDim2,
	TextSize: number
};

export type ConfigManager = {
	Directory: string,
	Config: string,
};

export type WriteConfig = {
	Name: string,
	Author: string,
};

export type WindowUpdate = {
	Username: string,
	ExpireDate: string,
	Logo: string,
	WindowName: string,
	UserProfile: string
};

export type ConfigFunctions = {
	Directory: string,
	WriteConfig: (self: ConfigFunctions , Config: WriteConfig) -> any?,
	ReadInfo: (self: ConfigFunctions , ConfigName: string) -> any?,
	DeleteConfig: (self: ConfigFunctions , ConfigName: string) -> any?,
	LoadConfig: (self: ConfigFunctions , ConfigName: string) -> any?,
	GetConfigs: (self: ConfigFunctions , ConfigName: string) -> {string},
	GetConfigCount: (self: ConfigFunctions) -> number,
	GetFullConfigs: (self: ConfigFunctions , ConfigName: string) -> {
		{
			Name: string,
			Info: {
				Type: string,
				Author: string,
				Name: string,
				CreatedDate: string,
			}
		}	
	},
};

export type Notify = {
	Icon: string,
	Title: string,
	Content: string,
	Duration: number
};

export type Watermark = {
	Icon: string,
	Text: string
};

export type TabConfig = {
	Name: string,
	Icon: string,
	Type: string,
	EnableScrolling: boolean
};

export type TabConfigManager = {
	Name: string,
	Icon: string,
	Config: ConfigFunctions
}

export type ContainerTab = {
	Name: string,
	Icon: string,
	EnableScrolling: boolean
};

export type Category = {
	Name: string
};

export type Section = {
	Name: string,
	Position: string
};

export type Toggle = {
	Name: string,
	Default: boolean,
	Flag: string | nil,
	Risky: boolean,
	Callback: (Value: boolean) -> any?
};

export type MiniToggle = {
	Default: boolean,
	Flag: string | nil,
	Callback: (Value: boolean) -> any?
};

export type TextBoxConfig = {
	Name: string,
	Default: string,
	Placeholder: string,
	Flag: string | nil,
	Numeric: boolean,
	Callback: (Text: string) -> any?
};

export type ColorPicker = {
	Name: string,
	Default: Color3,
	Flag: string | nil,
	Transparency: number,
	Callback: (Value: Color3 , Trans: number) -> any?
};

export type MiniColorPicker = {
	Default: Color3,
	Transparency: number,
	Flag: string | nil,
	Callback: (Value: Color3 , Trans: number) -> any?
};

export type Slider = {
	Name: string,
	Min: number,
	Max: number,
	Default: number,
	Type: string,
	Round: number,
	Callback: (Value: number) -> any?
};

export type Dropdown = {
	Name: string,
	Default: string | {string},
	Values: {string},
	Multi: boolean,
	Callback: (Value: string | {[string]: boolean}) -> any?
};

export type Button = {
	Name: string,
	Callback: () -> any?
};

export type Keybind = {
	Name: string,
	Default: string | Enum.KeyCode,
	Callback: (Value: string) -> any,
	Blacklist: {string | Enum.KeyCode}
};

export type MiniKeybind = {
	Default: string | Enum.KeyCode,
	Callback: (Value: string) -> any,
	Blacklist: {string | Enum.KeyCode}
};

export type Helper = {
	Text: string
};

export type Paragraph = {
	Title: string,
	Content: string
}

pcall(function()
	local Constant = table.concat({"LP","H_NO"}).."_VI".."RTU".."AL".."IZE";
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end; 
	-- LPH_NO_VIRTUALIZE
end);

if identifyexecutor() == 'Salad' then
	getgenv().hookmetamethod = newcclosure(function(...) end)
end

getgenv = getgenv or getfenv;

-- Please ignore the ugly code. [Custom File System] --
if cloneref(game:GetService('RunService')):IsStudio() then
	local BaseWorkspace = Instance.new('Folder',game:GetService("ReplicatedFirst"));

	BaseWorkspace.Name = tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));

	local __get_path_c = function(path)
		return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
	end

	local __get_path = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			block = block[v];
		end;

		return block;
	end;

	getgenv().readfile = function(path)
		local path : StringValue = __get_path(path);

		return path.Value;
	end;

	getgenv().isfile = function(path)
		local success , message = pcall(function()
			return __get_path(path);
		end);

		if success and not message:IsA("Folder") then
			return true;
		end;

		return false;
	end;

	getgenv().isfolder = function(path)
		local success , message = pcall(function()
			return __get_path(path);
		end);

		if success and message:IsA("Folder") then
			return true;
		end;

		return false;
	end;

	getgenv().writefile = function(path,content)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if not item then
				local c = Instance.new('StringValue',block);

				c.Name = tostring(v);
				c.Value = content;
			else
				if item:IsA('StringValue') and tostring(item) == v then
					item.Name = tostring(v);
					item.Value = content;
				end;

				block = item;
			end;
		end;
	end;

	getgenv().listfiles = function(path)
		local fold = __get_path(path);
		local pa = {};

		for i,v in next , fold:GetChildren() do
			if v:IsA('StringValue') then
				table.insert(pa,path..'/'..tostring(v));
			end;
		end;

		return pa;
	end;

	getgenv().makefolder = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if not item then
				local c = Instance.new('Folder',block);

				c.Name = tostring(v);
			else
				block = item;
			end;
		end;
	end;

	getgenv().delfile = function(path)
		local main = __get_path_c(path);

		local block = BaseWorkspace;

		for i,v in next , main do
			local item = block:FindFirstChild(v);
			if item and item:IsA('StringValue') then
				item:Destroy();
			else
				block = item;
			end;
		end;
	end;
end;

--- Local Variables ---
local cloneref: cloneref = cloneref or function(f) return f end;
local TweenService: TweenService = cloneref(game:GetService('TweenService'));
local UserInputService: UserInputService = cloneref(game:GetService('UserInputService'));
local TextService: TextService = cloneref(game:GetService('TextService'));
local RunService: RunService = cloneref(game:GetService('RunService'));
local Players: Players = cloneref(game:GetService('Players'));
local HttpService: HttpService = cloneref(game:GetService('HttpService'));
local LocalPlayer: Player = Players.LocalPlayer;
local CoreGui = (gethui and gethui()) or cloneref(game:GetService("CoreGui")) or LocalPlayer.PlayerGui;
local Mouse = LocalPlayer:GetMouse();
local CurrentCamera = workspace.CurrentCamera;

local Compkiller = {
	Version = '1.4',
	Logo = "rbxassetid://120245531583106",
	Windows = {},
	Scale = {
		Window = UDim2.new(0, 456,0, 499),
		Mobile = UDim2.new(0, 450,0, 375),
		TabOpen = 185,
		TabClose = 85,
	},
	ArcylicParent = workspace.CurrentCamera
};

local LucideIcons: table = loadstring(game:HttpGet('https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/ui/windui/icon.lua'))();

Compkiller.Colors = {
	Highlight = Color3.fromRGB(17, 238, 253),
	Toggle = Color3.fromRGB(14, 203, 213),
	Risky = Color3.fromRGB(251, 255, 39),
	BGDBColor = Color3.fromRGB(22, 24, 29),
	BlockColor = Color3.fromRGB(28, 29, 34),
	StrokeColor = Color3.fromRGB(37, 38, 43),
	SwitchColor = Color3.fromRGB(255, 255, 255),
	DropColor = Color3.fromRGB(33, 35, 39),
	MouseEnter = Color3.fromRGB(55, 58, 65),
	BlockBackground = Color3.fromRGB(39, 40, 47),
	LineColor = Color3.fromRGB(65, 65, 65),
	HighStrokeColor = Color3.fromRGB(55, 56, 63),
};

Compkiller.Elements = {
	Highlight = {},
	DropHighlight = {},
	Risky = {},
	BGDBColor = {},
	BlockColor = {},
	StrokeColor = {},
	SwitchColor = {},
	DropColor = {},
	BlockBackground = {},
	LineColor = {},
	HighStrokeColor = {},
};

Compkiller.DragBlacklist = {};
Compkiller.Flags = {};

Compkiller.Lucide = {
	GetAsset = function(p : string)
		local q : table? = LucideIcons.Icons[p];
        if q then
            local r = LucideIcons.Spritesheets[tostring(q.Image)];
            if r then
                return {Image = r, ImageRectSize = q.ImageRectSize, ImageRectPosition = q.ImageRectPosition};
            end;
        end;
        if type(p) == "string" and not p:find("rbxassetid://") then
            return {
                Image = "rbxassetid://" .. p,
                ImageRectSize = Vector2.new(0, 0),
                ImageRectPosition = Vector2.new(0, 0)
            };
        elseif type(p) == "number" then
            return {
                Image = "rbxassetid://" .. p,
                ImageRectSize = Vector2.new(0, 0),
                ImageRectPosition = Vector2.new(0, 0)
            };
        else
            return p;
        end;
	end;
};

function Compkiller:_GetIcon(name : string) : string
	return Compkiller.Lucide.GetAsset(name);
end;

function Compkiller:_RandomString() : string
	return string.char(math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102));	
end;

function Compkiller:_ConvertArgs(Config: table)
	local b = table.clone(Config)
	if not b.Default then
		b.Default = b.Value
	end
	if not b.Name then
		b.Name = b.Title
	end
	if not b.Min and typeof(b.Value) == 'table' then
		for i,v in b.Value do
			local i = i
			if i == 'Rounding' then 
				i = 'Round'
			end
			b[i] = v
		end
	end
	if not b.Rounding then
		b.Round = b.Rounding
	end
	if not b.Type and typeof(b.Suffix) == 'table' then
		b.Type = typeof(b.Suffix.Text) == 'function' and b.Suffix.Text() or b.Suffix.Text
	end
	if not b.Flag then
		local ExistedFlags: table = {}

		local Flag = b.Name:gsub(' ', '_')

		for i in Compkiller.Flags do
			if #i >= #Flag and i:sub(1, #Flag) == Flag then
				table.insert(ExistedFlags, i)
			end
		end
		
		if #ExistedFlags > 0 then
			Flag = Flag .. tostring(#ExistedFlags + 1)
		end

		b.Flag = Flag
	end
	return b
end

function Compkiller:_IsMouseOverFrame(Frame : Frame) : boolean
	if not Frame then
		return;
	end;

	local AbsPos: Vector2, AbsSize: Vector2 = Frame.AbsolutePosition, Frame.AbsoluteSize;

	if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
		return true;
	end;
end;

function Compkiller:_Rounding(num: number, numDecimalPlaces: number) : number
	local mult: number = 10 ^ (numDecimalPlaces or 0);
	return math.floor(num * mult + 0.5) / mult;
end;

function Compkiller:_Animation(Self: Instance , Info: TweenInfo , Property :{[K] : V})
	local Tween = TweenService:Create(Self , Info or TweenInfo.new(0.25) , Property);

	Tween:Play();

	return Tween;
end;

function Compkiller:_Input(Frame : Frame , Callback : () -> ()) : TextButton
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

function Compkiller:GetCalculatePosition(planePos: number, planeNormal: number, rayOrigin: number, rayDirection: number) : number
	local n = planeNormal;
	local d = rayDirection;
	local v = rayOrigin - planePos;

	local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
	local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
	local a = -num / den;

	return rayOrigin + (a * rayDirection);
end;

function Compkiller:_Blur(element : Frame , WindowRemote) : RBXScriptSignal
	local Part = Instance.new('Part',Compkiller.ArcylicParent);
	local DepthOfField = Instance.new('DepthOfFieldEffect',cloneref(game:GetService('Lighting')));
	local BlockMesh = Instance.new("BlockMesh");
	local userSettings = UserSettings():GetService("UserGameSettings");

	BlockMesh.Parent = Part;

	Part.Material = Enum.Material.Glass;
	Part.Transparency = 1;
	Part.Reflectance = 1;
	Part.CastShadow = false;
	Part.Anchored = true;
	Part.CanCollide = false;
	Part.CanQuery = false;
	Part.CollisionGroup = Compkiller:_RandomString();
	Part.Size = Vector3.new(1, 1, 1) * 0.01;
	Part.Color = Color3.fromRGB(0,0,0);

	DepthOfField.Enabled = true;
	DepthOfField.FarIntensity = 0;
	DepthOfField.FocusDistance = 0;
	DepthOfField.InFocusRadius = 1000;
	DepthOfField.NearIntensity = 1;
	DepthOfField.Name = Compkiller:_RandomString();

	Part.Name = Compkiller:_RandomString();

	local UpdateFunction = function()
		local IsWindowActive = WindowRemote:GetValue();

		if IsWindowActive then

			Compkiller:_Animation(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 1
			})

			Compkiller:_Animation(Part,TweenInfo.new(0.1),{
				Transparency = 0.97,
				Size = Vector3.new(1, 1, 1) * 0.01;
			})
		else
			Compkiller:_Animation(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 0
			})

			Compkiller:_Animation(Part,TweenInfo.new(0.1),{
				Size = Vector3.zero,
				Transparency = 1.5,
			})

			return false;
		end;

		if IsWindowActive then
			local corner0 = element.AbsolutePosition;
			local corner1 = corner0 + element.AbsoluteSize;

			local ray0 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner0.X, corner0.Y, 1);
			local ray1 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner1.X, corner1.Y, 1);

			local planeOrigin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);

			local planeNormal = CurrentCamera.CFrame.LookVector;

			local pos0 = Compkiller:GetCalculatePosition(planeOrigin, planeNormal, ray0.Origin, ray0.Direction);
			local pos1 = Compkiller:GetCalculatePosition(planeOrigin, planeNormal, ray1.Origin, ray1.Direction);

			pos0 = CurrentCamera.CFrame:PointToObjectSpace(pos0);
			pos1 = CurrentCamera.CFrame:PointToObjectSpace(pos1);

			local size   = pos1 - pos0;
			local center = (pos0 + pos1) / 2;

			BlockMesh.Offset = center
			BlockMesh.Scale  = size / 0.0101;
			Part.CFrame = CurrentCamera.CFrame;
		end;
	end;

	local rbxsignal = CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(UpdateFunction)
	local loopThread = UserInputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			pcall(UpdateFunction);
		end;
	end);

	local THREAD = task.spawn(function()
		while true do task.wait(0.1)
			pcall(UpdateFunction);
		end;
	end);

	element.Destroying:Connect(function()
		rbxsignal:Disconnect();
		loopThread:Disconnect();
		task.cancel(THREAD);
		Part:Destroy();
		DepthOfField:Destroy();
	end);

	return rbxsignal;
end;

function Compkiller:_AddDragBlacklist(Frame: Frame)
	Frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseMovement then
			local finder = table.find(Compkiller.DragBlacklist , Frame);
			local IsScrolling = Frame:IsA('ScrollingFrame') and Frame.ScrollingEnabled;

			if not finder or IsScrolling then
				table.insert(Compkiller.DragBlacklist , Frame);
			end;
		end;
	end);

	Frame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseMovement then
			local finder = table.find(Compkiller.DragBlacklist , Frame);
			local IsScrolling = Frame:IsA('ScrollingFrame') and Frame.ScrollingEnabled;

			if finder or IsScrolling then
				table.remove(Compkiller.DragBlacklist , finder);
			end;
		end;
	end);
end;

function Compkiller:_GetWindowFromElement(Element)
	for i,v : ScreenGui in next , Compkiller.Windows do
		if v and Element:IsDescendantOf(v) then
			return v;
		end;
	end;
end;

function Compkiller.__SIGNAL(default)
	local Bindable = Instance.new('BindableEvent');

	Bindable.Name = string.sub(tostring({}),7);

	Bindable:SetAttribute('Value',default);

	local Binds = {
		__signals = {}	
	};

	function Binds:Connect(event)
		event(Bindable:GetAttribute("Value"));

		local signal = Bindable.Event:Connect(event);

		table.insert(Binds.__signals,signal);

		return signal;
	end;

	function Binds:Fire(value)
		local IsSame = Bindable:GetAttribute("Value") == value;

		Bindable:SetAttribute('Value',value);

		if not IsSame then
			Bindable:Fire(value);
		end;
	end;

	function Binds:GetValue()
		return Bindable:GetAttribute("Value");
	end;

	return Binds;
end;

function Compkiller:_Hover(Frame: Frame , OnHover: () -> any?, Release: () -> any?)
	Frame.MouseEnter:Connect(OnHover);

	Frame.MouseLeave:Connect(Release);
end;

function Compkiller.__CONFIG(config , default)
	config = config or {};

	for i,v in next , default do
		if config[i] == nil then
			config[i] = v;
		end;
	end;

	return config;
end;

function Compkiller:Drag(InputFrame: Frame, MoveFrame: Frame, Speed : number)
	local dragToggle: boolean = false;
	local dragStart: Vector3 = nil;
	local startPos: UDim2 = nil;
	local Tween = TweenInfo.new(Speed);

	local function updateInput(input)
		local delta = input.Position - dragStart;
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y);

		Compkiller:_Animation(MoveFrame,Tween,{
			Position = position
		});
	end;

	InputFrame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and #Compkiller.DragBlacklist <= 0 then 
			dragToggle = true
			dragStart = input.Position
			startPos = MoveFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch and #Compkiller.DragBlacklist <= 0 then
			if dragToggle then
				updateInput(input)
			end
		else
			if #Compkiller.DragBlacklist > 0 then
				dragToggle = false
			end
		end
	end);
end;

function Compkiller:_IsMobile()
	return true;
end;

function Compkiller:_AddLinkValue(Name , Default , GlobalBlock , LinkValues , rep , Signal)
	if Name == "Toggle" then
		local Toggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ToggleValue = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")

		Toggle.Name = "Toggle"
		Toggle.Parent = LinkValues
		Toggle.BackgroundColor3 = Compkiller.Colors.DropColor
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.Size = UDim2.new(0, 30, 0, 16)
		Toggle.ZIndex = GlobalBlock.ZIndex + 1
		Toggle.LayoutOrder = -#LinkValues:GetChildren();

		table.insert(Compkiller.Elements.DropColor , {
			Element = Toggle,
			Property = "BackgroundColor3"
		})

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Toggle

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = Toggle
		
		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		ToggleValue.Name = "ToggleValue"
		ToggleValue.Parent = Toggle
		ToggleValue.AnchorPoint = Vector2.new(0.5, 0.5)
		ToggleValue.BackgroundColor3 = Compkiller.Colors.SwitchColor
		ToggleValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ToggleValue.BorderSizePixel = 0
		ToggleValue.Position = UDim2.new(0.25, 0, 0.5, 0)
		ToggleValue.Size = UDim2.new(0.550000012, 0, 0.550000012, 0)
		ToggleValue.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ToggleValue.ZIndex = GlobalBlock.ZIndex + 2

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = ToggleValue;

		local ToggleElement = function(bool,noChange)
			if not noChange then
				Default = bool;
			end;

			if bool then
				Toggle:SetAttribute('Enabled',true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Position = UDim2.new(0.75, 0, 0.5, 0)
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundColor3 = Compkiller.Colors.Toggle
				})
			else
				Toggle:SetAttribute('Enabled',false);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Position = UDim2.new(0.25, 0, 0.5, 0)
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundColor3 = Compkiller.Colors.DropColor
				})
			end;
		end;

		local Input = Compkiller:_Input(Toggle);

		Compkiller:_Hover(Input , function()
			if not Default then
				Compkiller:_Animation(ToggleValue,rep.Tween,{
					Size = UDim2.new(0.6, 0, 0.6, 0)
				})
			end;
		end , function()
			Compkiller:_Animation(ToggleValue,rep.Tween,{
				Size = UDim2.new(0.550000012, 0, 0.550000012, 0)
			})
		end);

		local ToggleUI = function(bool)
			if bool then
				ToggleElement(Default,true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 0
				})
			else
				ToggleElement(false,true);

				Compkiller:_Animation(ToggleValue,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(Toggle,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 1
				})
			end;
		end;

		ToggleElement(Default);

		Signal:Connect(ToggleUI)

		return {
			Root = Toggle,
			ChangeValue = ToggleElement,
			Input = Input,
			ToggleUI = ToggleUI,
		};
	elseif Name == "ColorPicker" then
		local ColorPicker = Instance.new("Frame")
		local ColorFrame = Instance.new("Frame")
		local UIScale = Instance.new("UIScale")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")

		ColorPicker.Name = "ColorPicker"
		ColorPicker.Parent = LinkValues
		ColorPicker.BackgroundTransparency = 1.000
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.Size = UDim2.new(0, 16, 0, 16)
		ColorPicker.ZIndex = GlobalBlock.ZIndex + 1
		ColorPicker.LayoutOrder = -#LinkValues:GetChildren();
		
		ColorFrame.Name = "ColorFrame"
		ColorFrame.Parent = ColorPicker
		ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ColorFrame.BackgroundColor3 = Color3.fromRGB(15, 255, 207)
		ColorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorFrame.BorderSizePixel = 0
		ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		ColorFrame.Size = UDim2.new(1, -1, 1, -1)
		ColorFrame.ZIndex = GlobalBlock.ZIndex + 1

		UIScale.Parent = ColorFrame

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = ColorFrame
		
		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})
		
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ColorFrame

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(ColorFrame,TweenInfo.new(0.15),{
					BackgroundTransparency = 0,
				})

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.15),{
					Transparency = 0,
				})
			else
				Compkiller:_Animation(ColorFrame,TweenInfo.new(0.15),{
					BackgroundTransparency = 1,
				})

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.15),{
					Transparency = 1,
				})
			end;
		end)

		Compkiller:_Hover(ColorPicker, function()
			if Signal:GetValue() then
				Compkiller:_Animation(UIScale,TweenInfo.new(0.35),{
					Scale = 1.2
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(UIScale,TweenInfo.new(0.35),{
					Scale = 1
				})
			end;
		end)

		return ColorPicker , ColorFrame;
	elseif Name == "Keybind" then
		local Keys = {
			One = '1',
			Two = '2',
			Three = '3',
			Four = '4',
			Five = '5',
			Six = '6',
			Seven = '7',
			Eight = '8',
			Nine = '9',
			Zero = '0',
			['Minus'] = "-",
			['Plus'] = "+",
			BackSlash = "\\",
			Slash = "/",
			Period = '.',
			Semicolon = ';',
			Colon = ":",
			LeftControl = "LCtrl",
			RightControl = "RCtrl",
			LeftShift = "LShift",
			RightShift = "RShift",
			Return = "Enter",
			LeftBracket = "[",
			RightBracket = "]",
			Quote = "'",
			Comma = ",",
			Equals = "=",
			LeftSuper = "Super",
			RightSuper = "Super",
			LeftAlt = "LAlt",
			RightAlt = "RAlt",
			Escape = "Esc",
		};

		local GetItem = function(item)
			if item then
				if typeof(item) == 'EnumItem' then
					return Keys[item.Name] or item.Name;
				else
					return Keys[tostring(item)] or tostring(item);
				end;
			else
				return 'None';
			end;
		end;

		local Keybind = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextLabel = Instance.new("TextLabel")

		Keybind.Name = "Keybind"
		Keybind.Parent = LinkValues
		Keybind.BackgroundColor3 = Compkiller.Colors.DropColor
		Keybind.BackgroundTransparency = 0.8
		Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keybind.BorderSizePixel = 0
		Keybind.Size = UDim2.new(0, 45, 0, 16)
		Keybind.ZIndex = GlobalBlock.ZIndex + 2
		Keybind.ClipsDescendants = true
		Keybind.LayoutOrder = -#LinkValues:GetChildren();
		

		table.insert(Compkiller.Elements.DropColor , {
			Element = Keybind,
			Property = "BackgroundColor3"
		})
		
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Keybind

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = Keybind
		
		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		TextLabel.Parent = Keybind
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, -5, 1, -5)
		TextLabel.ZIndex = GlobalBlock.ZIndex + 3
		TextLabel.Font = Enum.Font.Gotham
		TextLabel.Text = GetItem(Default or "None");
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 12.000
		TextLabel.TextTransparency = 0.200
		
		table.insert(Compkiller.Elements.SwitchColor,{
			Element = TextLabel,
			Property = "TextColor3"
		});
		
		local Update = function()
			local size = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));

			Compkiller:_Animation(Keybind,TweenInfo.new(0.1),{
				Size = UDim2.new(0, size.X + 5, 0, 16)
			});
		end;

		Update();

		local ToggleUI = function(bool)
			if bool then
				Compkiller:_Animation(Keybind,rep.Tween,{
					BackgroundTransparency = 0.8
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 0
				})

				Compkiller:_Animation(TextLabel,rep.Tween,{
					TextTransparency = 0.200
				})
			else
				Compkiller:_Animation(Keybind,rep.Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,rep.Tween,{
					Transparency = 1
				})

				Compkiller:_Animation(TextLabel,rep.Tween,{
					TextTransparency = 1
				})
			end;
		end;

		Signal:Connect(ToggleUI);

		return {
			SetValue = function(text)
				TextLabel.Text = GetItem(text or "None");

				Update();
			end,
			Root = Keybind,
		};
	elseif Name == "Helper" then
		local InfoButton = Instance.new("ImageButton")
		local UICorner = Instance.new("UICorner")
		local BlockText = Instance.new("TextLabel")
		local UIStroke = Instance.new("UIStroke")
		local UICorner_2 = Instance.new("UICorner")

		InfoButton.Name = "InfoButton"
		InfoButton.Parent = LinkValues
		InfoButton.BackgroundTransparency = 1.000
		InfoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InfoButton.BorderSizePixel = 0
		InfoButton.LayoutOrder = -#LinkValues:GetChildren();
		InfoButton.Size = UDim2.new(0, 15, 0, 15)
		InfoButton.ZIndex = GlobalBlock.ZIndex + 25
		InfoButton.Image = "rbxassetid://10723415903"
		InfoButton.ImageTransparency = 0.500

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = InfoButton

		BlockText.Name = "BlockText"
		BlockText.Parent = InfoButton
		BlockText.AnchorPoint = Vector2.new(0, 0)
		BlockText.BackgroundColor3 = Compkiller.Colors.BlockColor
		
		table.insert(Compkiller.Elements.BlockColor , {
			Element = BlockText,
			Property = "BackgroundColor3"
		});
		
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 5, 0, 0)
		BlockText.Size = UDim2.new(0, 250, 0, 15)
		BlockText.ZIndex = GlobalBlock.ZIndex + 26
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = " "
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 13.000
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor,{
			Element = BlockText,
			Property = "TextColor3"
		});
		
		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = BlockText
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner_2.CornerRadius = UDim.new(0, 3)
		UICorner_2.Parent = BlockText

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			else
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 1
				})
			end;
		end)

		Compkiller:_Hover(InfoButton, function()
			if Signal:GetValue() then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.1
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(InfoButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			end;
		end)

		return {
			Text = BlockText,
			UIStroke = UIStroke,
			InfoButton = InfoButton,
		};
	elseif Name == "Option" then
		local OptionButton = Instance.new("ImageButton")
		local UICorner = Instance.new("UICorner")

		OptionButton.Name = "OptionButton"
		OptionButton.Parent = LinkValues
		OptionButton.BackgroundTransparency = 1.000
		OptionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OptionButton.BorderSizePixel = 0
		OptionButton.Size = UDim2.new(0, 15, 0, 15)
		OptionButton.ZIndex = GlobalBlock.ZIndex + 2
		OptionButton.Image = "rbxassetid://14007344336"
		OptionButton.ImageTransparency = 0.500
		OptionButton.LayoutOrder = -#LinkValues:GetChildren();

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = OptionButton

		Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			else
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 1
				})
			end;
		end)

		Compkiller:_Hover(OptionButton, function()
			if Signal:GetValue() then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.1
				})
			end;
		end , function()
			if Signal:GetValue() then
				Compkiller:_Animation(OptionButton,TweenInfo.new(0.15),{
					ImageTransparency = 0.500
				})
			end;
		end)

		return OptionButton;
	end;
end;

function Compkiller:_CreateBlock(Signal)
	local GlobalBlock = Instance.new("Frame")
	local BlockText = Instance.new("TextLabel")
	local LinkValues = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local BlockLine = Instance.new("Frame")

	GlobalBlock.Name = "GlobalBlock"
	GlobalBlock.BackgroundTransparency = 1.000
	GlobalBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GlobalBlock.BorderSizePixel = 0
	GlobalBlock.Size = UDim2.new(1, -1, 0, 30)
	GlobalBlock.ZIndex = 10

	BlockText.Name = "BlockText"
	BlockText.Parent = GlobalBlock
	BlockText.AnchorPoint = Vector2.new(0, 0.5)
	BlockText.BackgroundTransparency = 1.000
	BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlockText.BorderSizePixel = 0
	BlockText.Position = UDim2.new(0, 12, 0.5, 0)
	BlockText.Size = UDim2.new(1, -20, 0, 25)
	BlockText.ZIndex = 10
	BlockText.Font = Enum.Font.GothamMedium
	BlockText.Text = "Block"
	BlockText.TextColor3 = Compkiller.Colors.SwitchColor
	BlockText.TextSize = 14.000
	BlockText.TextTransparency = 0.300
	BlockText.TextXAlignment = Enum.TextXAlignment.Left
	
	table.insert(Compkiller.Elements.SwitchColor , {
		Element = BlockText,
		Property = 'TextColor3'
	});

	LinkValues.Name = "LinkValues"
	LinkValues.Parent = GlobalBlock
	LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
	LinkValues.BackgroundTransparency = 1.000
	LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LinkValues.BorderSizePixel = 0
	LinkValues.Position = UDim2.new(1, -12, 0.5, 0)
	LinkValues.Size = UDim2.new(1, 0, 0, 18)
	LinkValues.ZIndex = 11

	UIListLayout.Parent = LinkValues
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 8)

	BlockLine.Name = "BlockLine"
	BlockLine.Parent = GlobalBlock
	BlockLine.AnchorPoint = Vector2.new(0.5, 1)
	BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
	BlockLine.BackgroundTransparency = 0.500
	BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BlockLine.BorderSizePixel = 0
	BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
	BlockLine.Size = UDim2.new(1, -26, 0, 1)
	BlockLine.ZIndex = 12
	
	table.insert(Compkiller.Elements.LineColor,{
		Element = BlockLine,
		Property = "BackgroundColor3"
	});

	local rep = {
		TextTransparency = 0.300,
		Root = GlobalBlock,
		Tween = TweenInfo.new(0.25),
	};

	function rep:SetText(Text)
		BlockText.Text = Text;
	end;

	function rep:SetTextColor(Color)
		local oldIndex = table.find(Compkiller.Elements.SwitchColor , BlockText);
		
		table.remove(Compkiller.Elements.SwitchColor , oldIndex);
		
		BlockText.TextColor3 = Color;
		
		table.insert(Compkiller.Elements.Risky , {
			Element = BlockText,
			Property = 'TextColor3'
		});

	end;

	function rep:SetLine(visible)
		BlockLine.Visible = visible;
	end;

	function rep:SetTransparency(num)
		rep.TextTransparency = num;

		Compkiller:_Animation(BlockText,TweenInfo.new(0.3),{
			TextTransparency = rep.TextTransparency
		});
	end;

	function rep:SetParent(parent: Frame)
		GlobalBlock.Parent = parent;

		local ZINDEX = parent.ZIndex;

		GlobalBlock.ZIndex = ZINDEX + 1;
		BlockText.ZIndex = ZINDEX + 2;
		LinkValues.ZIndex = ZINDEX + 2;
		BlockLine.ZIndex = ZINDEX + 2;
	end;

	function rep:SetVisible(bool)
		if bool then
			Compkiller:_Animation(BlockText,rep.Tween,{
				TextTransparency = rep.TextTransparency
			});

			Compkiller:_Animation(BlockLine,rep.Tween,{
				BackgroundTransparency = 0.500
			});
		else
			Compkiller:_Animation(BlockText,rep.Tween,{
				TextTransparency = 1
			});

			Compkiller:_Animation(BlockLine,rep.Tween,{
				BackgroundTransparency = 1
			});
		end;
	end;

	function rep:AddLink(Name , Default)
		return Compkiller:_AddLinkValue(Name , Default , GlobalBlock , LinkValues , rep , Signal);
	end;

	return rep;
end;

function Compkiller:_AddColorPickerPanel(Button: ImageButton , Callback: (Color: Color3) -> any?)
	local Window = Compkiller:_GetWindowFromElement(Button);

	local BaseZ_Index = math.random(1,15) * 100;

	local ColorPickerWindow = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ColorPickBox = Instance.new("ImageLabel")
	local MouseMovement = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local ColorRedGreenBlue = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UICorner_3 = Instance.new("UICorner")
	local ColorRGBSlide = Instance.new("Frame")
	local Left = Instance.new("Frame")
	local UIStroke_3 = Instance.new("UIStroke")
	local Right = Instance.new("Frame")
	local UIStroke_4 = Instance.new("UIStroke")
	local ColorOpc = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local ColorOptSlide = Instance.new("Frame")
	local Left_2 = Instance.new("Frame")
	local UIStroke_5 = Instance.new("UIStroke")
	local Right_2 = Instance.new("Frame")
	local UIStroke_6 = Instance.new("UIStroke")
	local UIGradient_2 = Instance.new("UIGradient")
	local UIStroke_7 = Instance.new("UIStroke")
	local TransparentImage = Instance.new("ImageLabel")
	local UICorner_5 = Instance.new("UICorner")
	local HexFrame = Instance.new("Frame")
	local UICorner_6 = Instance.new("UICorner")
	local UIStroke_8 = Instance.new("UIStroke")
	local TextLabel = Instance.new("TextLabel")

	ColorPickerWindow.Name = "ColorPickerWindow"
	ColorPickerWindow.Parent = Window
	ColorPickerWindow.BackgroundColor3 = Compkiller.Colors.BlockBackground
	ColorPickerWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickerWindow.BorderSizePixel = 0
	ColorPickerWindow.Position = UDim2.new(123, 0, 123, 0)
	ColorPickerWindow.Size = UDim2.new(0, 175, 0, 200)
	ColorPickerWindow.ZIndex = BaseZ_Index
	ColorPickerWindow.AnchorPoint = Vector2.new(0.5,0)
	ColorPickerWindow.Active = true;
	
	table.insert(Compkiller.Elements.BlockBackground,{
		Element = ColorPickerWindow,
		Property = "BackgroundColor3"
	});
	
	Compkiller:_AddDragBlacklist(ColorPickerWindow)

	UIStroke.Color = Compkiller.Colors.HighStrokeColor
	UIStroke.Parent = ColorPickerWindow
	table.insert(Compkiller.Elements.HighStrokeColor , {
		Element = UIStroke,
		Property = "Color"
	})
	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = ColorPickerWindow

	ColorPickBox.Name = "ColorPickBox"
	ColorPickBox.Parent = ColorPickerWindow
	ColorPickBox.BackgroundColor3 = Color3.fromRGB(39, 255, 35)
	ColorPickBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickBox.BorderSizePixel = 0
	ColorPickBox.Position = UDim2.new(0, 7, 0, 7)
	ColorPickBox.Size = UDim2.new(0, 145, 0, 145)
	ColorPickBox.ZIndex = BaseZ_Index + 1
	ColorPickBox.Image = "http://www.roblox.com/asset/?id=112554223509763"

	MouseMovement.Name = "MouseMovement"
	MouseMovement.Parent = ColorPickBox
	MouseMovement.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MouseMovement.BackgroundTransparency = 1.000
	MouseMovement.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MouseMovement.BorderSizePixel = 0
	MouseMovement.Position = UDim2.new(0.822222233, 0, 0.0592592582, 0)
	MouseMovement.Size = UDim2.new(0, 12, 0, 12)
	MouseMovement.ZIndex = BaseZ_Index + 5
	MouseMovement.AnchorPoint = Vector2.new(0.5,0.5)
	MouseMovement.Image = "rbxassetid://4805639000"

	UICorner_2.CornerRadius = UDim.new(0, 2)
	UICorner_2.Parent = ColorPickBox

	UIStroke_2.Color = Color3.fromRGB(29, 29, 29)
	UIStroke_2.Parent = ColorPickBox

	ColorRedGreenBlue.Name = "ColorRedGreenBlue"
	ColorRedGreenBlue.Parent = ColorPickerWindow
	ColorRedGreenBlue.AnchorPoint = Vector2.new(1, 0)
	ColorRedGreenBlue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorRedGreenBlue.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorRedGreenBlue.BorderSizePixel = 0
	ColorRedGreenBlue.ClipsDescendants = true
	ColorRedGreenBlue.Position = UDim2.new(1, -7, 0, 7)
	ColorRedGreenBlue.Size = UDim2.new(0, 10, 0, 145)
	ColorRedGreenBlue.ZIndex = BaseZ_Index + 6

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Rotation = 90
	UIGradient.Parent = ColorRedGreenBlue

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = ColorRedGreenBlue

	ColorRGBSlide.Name = "ColorRGBSlide"
	ColorRGBSlide.Parent = ColorRedGreenBlue
	ColorRGBSlide.AnchorPoint = Vector2.new(0.5, 0)
	ColorRGBSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorRGBSlide.BackgroundTransparency = 1.000
	ColorRGBSlide.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorRGBSlide.BorderSizePixel = 0
	ColorRGBSlide.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorRGBSlide.Size = UDim2.new(1, 0, 0, 2)
	ColorRGBSlide.ZIndex = BaseZ_Index + 7

	Left.Name = "Left"
	Left.Parent = ColorRGBSlide
	Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Left.BorderSizePixel = 0
	Left.Size = UDim2.new(0, 2, 1, 0)
	Left.ZIndex = BaseZ_Index + 100

	UIStroke_3.Parent = Left

	Right.Name = "Right"
	Right.Parent = ColorRGBSlide
	Right.AnchorPoint = Vector2.new(1, 0)
	Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Right.BorderSizePixel = 0
	Right.Position = UDim2.new(1, 0, 0, 0)
	Right.Size = UDim2.new(0, 2, 1, 0)
	Right.ZIndex = BaseZ_Index + 100

	UIStroke_4.Parent = Right

	ColorOpc.Name = "ColorOpc"
	ColorOpc.Parent = ColorPickerWindow
	ColorOpc.BackgroundColor3 = Color3.fromRGB(102, 255, 0)
	ColorOpc.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorOpc.BorderSizePixel = 0
	ColorOpc.Position = UDim2.new(0, 7, 0, 160)
	ColorOpc.Size = UDim2.new(1, -30, 0, 9)
	ColorOpc.ZIndex = BaseZ_Index + 6

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = ColorOpc

	ColorOptSlide.Name = "ColorOptSlide"
	ColorOptSlide.Parent = ColorOpc
	ColorOptSlide.AnchorPoint = Vector2.new(0, 0.5)
	ColorOptSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorOptSlide.BackgroundTransparency = 1.000
	ColorOptSlide.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorOptSlide.BorderSizePixel = 0
	ColorOptSlide.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorOptSlide.Size = UDim2.new(0, 2, 1, 0)
	ColorOptSlide.ZIndex = BaseZ_Index + 7

	Left_2.Name = "Left"
	Left_2.Parent = ColorOptSlide
	Left_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Left_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Left_2.BorderSizePixel = 0
	Left_2.Size = UDim2.new(1, 0, 0, 2)
	Left_2.ZIndex = BaseZ_Index + 100

	UIStroke_5.Parent = Left_2

	Right_2.Name = "Right"
	Right_2.Parent = ColorOptSlide
	Right_2.AnchorPoint = Vector2.new(0, 1)
	Right_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Right_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Right_2.BorderSizePixel = 0
	Right_2.Position = UDim2.new(0, 0, 1, 0)
	Right_2.Size = UDim2.new(1, 0, 0, 2)
	Right_2.ZIndex = BaseZ_Index + 100

	UIStroke_6.Parent = Right_2

	UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
	UIGradient_2.Parent = ColorOpc

	UIStroke_7.Transparency = 0.500
	UIStroke_7.Color = Color3.fromRGB(29, 29, 29)
	UIStroke_7.Parent = ColorOpc

	TransparentImage.Name = "TransparentImage"
	TransparentImage.Parent = ColorOpc
	TransparentImage.BackgroundTransparency = 1.000
	TransparentImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TransparentImage.BorderSizePixel = 0
	TransparentImage.Size = UDim2.new(1, 0, 1, 0)
	TransparentImage.ZIndex = BaseZ_Index + 5
	TransparentImage.Image = "rbxassetid://6198493000"
	TransparentImage.ImageColor3 = Color3.fromRGB(206, 206, 206)
	TransparentImage.ScaleType = Enum.ScaleType.Crop

	UICorner_5.CornerRadius = UDim.new(1, 0)
	UICorner_5.Parent = TransparentImage

	HexFrame.Name = "HexFrame"
	HexFrame.Parent = ColorPickerWindow
	HexFrame.AnchorPoint = Vector2.new(0.5, 1)
	HexFrame.BackgroundColor3 = Compkiller.Colors.BlockColor
	HexFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HexFrame.BorderSizePixel = 0
	HexFrame.Position = UDim2.new(0.5, 0, 1, -5)
	HexFrame.Size = UDim2.new(1, -16, 0, 20)
	HexFrame.ZIndex = BaseZ_Index + 205
	
	table.insert(Compkiller.Elements.BlockColor,{
		Element = HexFrame,
		Property = "BackgroundColor3"
	});

	UICorner_6.CornerRadius = UDim.new(0, 4)
	UICorner_6.Parent = HexFrame

	UIStroke_8.Color = Compkiller.Colors.HighStrokeColor
	UIStroke_8.Parent = HexFrame
	
	table.insert(Compkiller.Elements.HighStrokeColor,{
		Element = UIStroke_8,
		Property = "Color"
	});

	TextLabel.Parent = HexFrame
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	TextLabel.Size = UDim2.new(1, -10, 1, -5)
	TextLabel.ZIndex = BaseZ_Index + 206
	TextLabel.Font = Enum.Font.Gotham
	TextLabel.Text = "#FFFFFFF"
	TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
	TextLabel.TextSize = 13.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	
	table.insert(Compkiller.Elements.SwitchColor , {
		Element = TextLabel,
		Property = 'TextColor3'
	});
	
	local Args = {
		IsHold = false,
		IsVisible = false,
	};

	local Tween = TweenInfo.new(0.2 , Enum.EasingStyle.Quad);
	local Tween2 = TweenInfo.new(0.275 , Enum.EasingStyle.Quad);

	Compkiller:_AddPropertyEvent(ColorPickerWindow,function(v)
		ColorPickerWindow.Visible = v;
	end)

	local ToggleUI = function(bool)
		local IsSame = Args.IsVisible == bool;

		Args.IsVisible = bool;

		local MainPosition = UDim2.new(0,Button.AbsolutePosition.X + 95,0,Button.AbsolutePosition.Y + 65);
		local DropPosition = UDim2.new(0,MainPosition.X.Offset,0,MainPosition.Y.Offset + 15);

		local MUL = Window.AbsoluteSize.Y / 2;

		if MainPosition.Y.Offset > MUL then -- go up
			MainPosition = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + 45);
			DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset - 25);

			ColorPickerWindow.AnchorPoint = Vector2.new(0.5,1)
		else
			ColorPickerWindow.AnchorPoint = Vector2.new(0.5,0)
		end;

		if bool then

			if not IsSame then
				ColorPickerWindow.Position = DropPosition
			end;

			Compkiller:_Animation(ColorPickerWindow,Tween2,{
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 175, 0, 200)
			});

			Compkiller:_Animation(ColorPickerWindow,Tween,{
				Position = MainPosition,
			});

			Compkiller:_Animation(UIStroke_8,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_7,Tween,{
				Transparency = 0.5
			});

			Compkiller:_Animation(UIStroke_6,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_5,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_4,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_3,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke_2,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(UIStroke,Tween,{
				Transparency = 0
			});

			Compkiller:_Animation(ColorPickBox,Tween,{
				BackgroundTransparency = 0,
				ImageTransparency = 0
			});

			Compkiller:_Animation(MouseMovement,Tween,{
				ImageTransparency = 0
			});

			Compkiller:_Animation(ColorOpc,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(TransparentImage,Tween,{
				ImageTransparency = 0
			});

			Compkiller:_Animation(Left,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Left_2,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Right,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(Right_2,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(ColorRedGreenBlue,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(HexFrame,Tween,{
				BackgroundTransparency = 0
			});

			Compkiller:_Animation(TextLabel,Tween,{
				TextTransparency = 0
			});
		else
			Compkiller:_Animation(UIStroke_8,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_7,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_6,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_5,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_4,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_3,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke_2,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(UIStroke,Tween,{
				Transparency = 1
			});

			Compkiller:_Animation(ColorPickerWindow,Tween2,{
				BackgroundTransparency = 1,
			});

			Compkiller:_Animation(ColorPickerWindow,Tween,{
				Position = DropPosition,
			});

			Compkiller:_Animation(ColorPickBox,Tween,{
				BackgroundTransparency = 1,
				ImageTransparency = 1
			});

			Compkiller:_Animation(MouseMovement,Tween,{
				ImageTransparency = 1
			});

			Compkiller:_Animation(ColorOpc,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(TransparentImage,Tween,{
				ImageTransparency = 1
			});

			Compkiller:_Animation(Left,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Left_2,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Right,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(Right_2,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(ColorRedGreenBlue,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(HexFrame,Tween,{
				BackgroundTransparency = 1
			});

			Compkiller:_Animation(TextLabel,Tween,{
				TextTransparency = 1
			});
		end;
	end;

	Button.MouseButton1Click:Connect(function()
		ToggleUI(true);
	end)

	local H , S , V = 0,0,0;
	local Transparency = 0;

	function Args:SetColor(Color: Color3 , TransparencyValue: number)
		H , S , V = Color:ToHSV();
		Transparency = TransparencyValue;
	end;

	function Args:Update()
		local MainColor = Color3.fromHSV(H , S , 1);
		local RealColor = Color3.fromHSV(H , S , V);

		Compkiller:_Animation(ColorPickBox,TweenInfo.new(0.2),{
			BackgroundColor3 = Color3.fromHSV(H , 1 , 1)
		});

		Compkiller:_Animation(ColorOpc,TweenInfo.new(0.2),{
			BackgroundColor3 = RealColor
		});

		Compkiller:_Animation(MouseMovement,TweenInfo.new(0.2),{
			Position = UDim2.fromScale(S , 1 - V)
		});

		Compkiller:_Animation(ColorOptSlide,TweenInfo.new(0.2),{
			Position = UDim2.new(Transparency ,0 , 0.5 ,0)
		});

		Compkiller:_Animation(ColorRGBSlide,TweenInfo.new(0.2),{
			Position = UDim2.new(0.5 ,0 , H ,0)
		});

		TextLabel.Text = "#" .. tostring(RealColor:ToHex())

		Callback(RealColor , Transparency);
	end;

	local SPAWN_THREAD;

	ColorPickerWindow.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			if SPAWN_THREAD then
				task.cancel(SPAWN_THREAD);
				SPAWN_THREAD = nil;
			end;

			SPAWN_THREAD = task.spawn(function()
				while true do task.wait(0.00001)
					if not Args.IsHold then
						break;	
					end;

					Callback(Color3.fromHSV(H , S , V),Transparency);
				end;
			end);
		end;
	end)

	ColorPickerWindow.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = false;

			if SPAWN_THREAD then
				task.cancel(SPAWN_THREAD);
				SPAWN_THREAD = nil;
			end;
		end;
	end)

	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			if not Compkiller:_IsMouseOverFrame(ColorPickerWindow) then
				ToggleUI(false);
			end;
		end;
	end)

	ColorRedGreenBlue.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait()
				local ColorY = ColorRedGreenBlue.AbsolutePosition.Y
				local ColorYM = ColorY + ColorRedGreenBlue.AbsoluteSize.Y;
				local Value = math.clamp(Mouse.Y, ColorY, ColorYM)
				local Code = ((Value - ColorY) / (ColorYM - ColorY));

				H = Code;

				Args:Update();
			end;
		end;
	end);

	ColorOpc.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait()
				local transparency = math.clamp((((Mouse.X) - ColorOpc.AbsolutePosition.X) / ColorOpc.AbsoluteSize.X), 0, 1);
				local RealColor = Color3.fromHSV(H , S , V);

				TextLabel.Text = "#" .. tostring(RealColor:ToHex())

				Transparency = transparency;

				Args:Update();
			end;
		end;
	end);

	ColorPickBox.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Args.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or Args.IsHold) do task.wait();
				local PosX = ColorPickBox.AbsolutePosition.X
				local ScaleX = PosX + ColorPickBox.AbsoluteSize.X
				local Value, PosY = math.clamp(Mouse.X, PosX, ScaleX), ColorPickBox.AbsolutePosition.Y
				local ScaleY = PosY + ColorPickBox.AbsoluteSize.Y
				local Vals = math.clamp(Mouse.Y, PosY, ScaleY)
				local RealColor = Color3.fromHSV(H , S , V);

				S = (Value - PosX) / (ScaleX - PosX);
				V = (1 - ((Vals - PosY) / (ScaleY - PosY)));

				TextLabel.Text = "#" .. tostring(RealColor:ToHex())

				Args:Update();
			end
		end
	end)

	return Args;
end;

function Compkiller:_AddPropertyEvent(Target: Frame , Callback: (boolean) -> any)
	Target:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
		Callback(Target.BackgroundTransparency <= 0.9)
	end)
end;

function Compkiller:_LoadOption(Value , TabSignal)
	local Args = {};
	local Window = Compkiller:_GetWindowFromElement(Value.Root);
	local Tween = TweenInfo.new(0.3,Enum.EasingStyle.Quint);

	function Args:AddKeybind(Config: MiniKeybind)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Keybind",
			Default = nil,
			Flag = nil,
			Callback = function() end;
			Blacklist = {}
		});

		local Keybind = Value:AddLink('Keybind' , Config.Default);

		local IsBinding = false;

		local IsBlacklist = function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end;

		Compkiller:_Input(Keybind.Root,function()
			if IsBinding then
				return;
			end;

			Keybind.SetValue("...");

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("MouseLeft") then
						Selected = "MouseLeft";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("MouseRight") then
						Selected = "MouseRight";
					end;
				end;
			end;

			local KeyName = (typeof(Selected) == "string" and Selected) or Selected.Name;

			Config.Default = KeyName;

			Keybind.SetValue(Selected);

			IsBinding = false;

			Config.Callback(KeyName);
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value)
			Config.Default = value;

			Keybind.SetValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		function Args:GetValue()
			return (typeof(Config.Default) == "string" and Config.Default) or Config.Default.Name;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddHelper(Config: Helper)
		Config = Compkiller.__CONFIG(Config,{
			Text = "Information."
		});

		local Helper = Value:AddLink("Helper" , Config.Default);
		local Button: ImageButton = Helper.InfoButton;

		Helper.Text.Parent = Window;

		Helper.UIStroke:GetPropertyChangedSignal('Transparency'):Connect(function()
			if Helper.UIStroke.Transparency > 0.9 then
				Helper.Text.Visible = false;
			else
				Helper.Text.Visible = true;
			end;
		end)

		local Update = function()
			local mainText = " "..Config.Text;

			mainText = string.gsub(mainText,'\n','\n ')

			Helper.Text.Text = mainText;

			local scale = TextService:GetTextSize(Helper.Text.Text,Helper.Text.TextSize,Helper.Text.Font,Vector2.new(math.huge,math.huge));

			Compkiller:_Animation(Helper.Text , TweenInfo.new(0.15), {
				Size = UDim2.fromOffset(scale.X + 50, scale.Y + 5)
			})

			return scale;
		end;

		local Release = function()
			local scale = Update()

			Compkiller:_Animation(Helper.Text,TweenInfo.new(0.15),{
				TextTransparency = 1,
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + (45))
			});

			Compkiller:_Animation(Helper.UIStroke,TweenInfo.new(0.15),{
				Transparency = 1
			});
		end;

		local Hold = function()
			local scale = Update()

			if not Helper.Text.Visible then
				Helper.Text.Position = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + (45))
			end;

			Compkiller:_Animation(Helper.Text,TweenInfo.new(0.15),{
				TextTransparency = 0.35,
				BackgroundTransparency = 0,
				Position = UDim2.fromOffset(Button.AbsolutePosition.X,Button.AbsolutePosition.Y + (40 - (scale.Y / 2)))
			});

			Compkiller:_Animation(Helper.UIStroke,TweenInfo.new(0.15),{
				Transparency = 0
			});

		end;

		Compkiller:_Hover(Button,  Hold, Release);

		Release();

		local Args = {};

		function Args:SetValue(value)
			Config.Text = value;
		end;

		return Args;
	end;

	function Args:AddColorPicker(Config: MiniColorPicker)
		Config = Compkiller.__CONFIG(Config,{
			Default = Color3.fromRGB(255,255,255),
			Transparency = 0,
			Callback = function() end
		});

		local ColorPicker:Frame , ColorFrame: Frame = Value:AddLink('ColorPicker' , Config.Default);

		local Button = Compkiller:_Input(ColorPicker);

		local ColorPicker = Compkiller:_AddColorPickerPanel(Button,function(color,opc)
			Config.Default = color;
			Config.Transparency = opc;

			ColorFrame.BackgroundColor3 = color;
			ColorFrame.BackgroundTransparency = opc;

			Config.Callback(Config.Default , Config.Transparency);
		end);

		ColorPicker:SetColor(Config.Default,Config.Transparency);
		ColorPicker:Update()

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value,opc)
			Config.Default = value;
			Config.Transparency = opc;

			ColorPicker:SetColor(value,opc)

			ColorPicker:Update()

			Config.Callback(value,opc);
		end;

		function Args:GetValue()
			return {
				ColorPicker = {
					Color = Config.Default,
					Transparency = Config.Transparency
				}
			};
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddToggle(Config : MiniToggle)
		Config = Compkiller:_ConvertArgs(Config)

		Config = Compkiller.__CONFIG(Config,{
			Flag = nil,
			Default = false,
			Callback = function() end;
		});

		local Toggle = Value:AddLink("Toggle" , Config.Default);

		Toggle.Input.MouseButton1Click:Connect(function()
			Config.Default = not Config.Default;

			Toggle.ChangeValue(Config.Default);

			Config.Callback(Config.Default);
		end);

		local Args = {};

		Args.Flag = Config.Flag

		function Args:SetValue(value)
			Config.Default = value;

			Toggle.ChangeValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddOption()
		local Element: ImageButton = Value:AddLink("Option");
		Element.Visible = false

		local BaseZ_Index = math.random(1,15) * 100;

		local Signal = Compkiller.__SIGNAL(false);

		local ExtractElement = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local Elements = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local Toggl = false;

		local ToggleUI = function(bool)
			local IsSameValue = bool == Toggl;

			Toggl = bool;

			local MainPosition = UDim2.fromOffset(Element.AbsolutePosition.X,Element.AbsolutePosition.Y + 80);
			local DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset + 15);
			local MUL = Window.AbsoluteSize.Y / 2;

			if MainPosition.Y.Offset > MUL then -- go up
				MainPosition = UDim2.fromOffset(Element.AbsolutePosition.X,Element.AbsolutePosition.Y + 45);
				DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset - 25);
				ExtractElement.AnchorPoint = Vector2.new(0,1)
			else
				ExtractElement.AnchorPoint = Vector2.new(0,0)
			end;

			if bool then
				Signal:Fire(true);

				if not IsSameValue then
					ExtractElement.Position = DropPosition
				end;

				Compkiller:_Animation(ExtractElement , Tween , {
					Position = MainPosition,
					BackgroundTransparency = 0,
					Size = UDim2.new(0, 225, 0, UIListLayout.AbsoluteContentSize.Y)
				});

				Compkiller:_Animation(UIStroke , Tween , {
					Transparency = 0
				});

			else
				Signal:Fire(false);

				Compkiller:_Animation(ExtractElement , Tween , {
					Position = DropPosition,
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 225, 0, UIListLayout.AbsoluteContentSize.Y - 10)
				});

				Compkiller:_Animation(UIStroke , Tween , {
					Transparency = 1
				});
			end;
		end;

		UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			Element.Visible = UIListLayout.AbsoluteContentSize.Y > 0
		end)

		Compkiller:_AddPropertyEvent(ExtractElement,function(bool)
			ExtractElement.Visible = bool;
		end);

		Compkiller:_AddDragBlacklist(ExtractElement);

		ExtractElement.Name = "ExtractElement"
		ExtractElement.Parent = Window
		ExtractElement.BackgroundColor3 = Compkiller.Colors.BlockBackground
		ExtractElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ExtractElement.BorderSizePixel = 0
		ExtractElement.ClipsDescendants = true
		ExtractElement.Position = UDim2.new(123, 0, 123, 0)
		ExtractElement.Size = UDim2.new(0, 225, 0, 35)
		ExtractElement.ZIndex = BaseZ_Index
		ExtractElement.Visible = false
		ExtractElement.ClipsDescendants = true
		
		table.insert(Compkiller.Elements.BlockBackground,{
			Element = ExtractElement,
			Property = "BackgroundColor3"
		});

		UIStroke.Color = Compkiller.Colors.HighStrokeColor
		UIStroke.Parent = ExtractElement
		
		table.insert(Compkiller.Elements.HighStrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});
		
		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = ExtractElement

		Elements.Name = "Elements"
		Elements.Parent = ExtractElement
		Elements.AnchorPoint = Vector2.new(0.5, 0.5)
		Elements.BackgroundTransparency = 1.000
		Elements.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Elements.BorderSizePixel = 0
		Elements.Position = UDim2.new(0.5, 0, 0.5, 0)
		Elements.Size = UDim2.new(1, -5, 1,-1)
		Elements.ZIndex = BaseZ_Index + 20

		UIListLayout.Parent = Elements
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 0)

		ToggleUI(false);

		Element.MouseButton1Click:Connect(function()
			ToggleUI(true);
		end);

		UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Toggl and not Compkiller:_IsMouseOverFrame(ExtractElement) and not Compkiller:_IsMouseOverFrame(Element) then
					ToggleUI(false);
				end;
			end
		end)		

		return Compkiller:_LoadElement(Elements , true , Signal)
	end;

	return Args;
end;

function Compkiller:_LoadDropdown(BaseParent: TextButton , Callback: () -> any)
	local Window = Compkiller:_GetWindowFromElement(BaseParent);

	local BaseZ_Index = BaseParent.ZIndex + (math.random(1,15) * 100);

	local DropdownWindow = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ToggleDb = Compkiller.__SIGNAL(false);
	local EventOut = Compkiller.__SIGNAL(0);

	DropdownWindow.Name = "DropdownWindow"
	DropdownWindow.Parent = Window
	DropdownWindow.BackgroundColor3 = Compkiller.Colors.BlockBackground
	DropdownWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DropdownWindow.BorderSizePixel = 0
	DropdownWindow.Position = UDim2.new(123, 0, 123, 0)
	DropdownWindow.Size = UDim2.new(0, 190, 0, 200)
	DropdownWindow.ZIndex = BaseZ_Index
	
	table.insert(Compkiller.Elements.BlockBackground,{
		Element = DropdownWindow,
		Property = "BackgroundColor3"
	});

	Compkiller:_AddDragBlacklist(DropdownWindow);
	Compkiller:_AddPropertyEvent(DropdownWindow,function(v)
		DropdownWindow.Visible = v;
	end)

	UIStroke.Color = Compkiller.Colors.HighStrokeColor
	UIStroke.Parent = DropdownWindow
	
	table.insert(Compkiller.Elements.HighStrokeColor , {
		Element = UIStroke,
		Property = "Color"
	})

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = DropdownWindow

	ScrollingFrame.Parent = DropdownWindow
	ScrollingFrame.Active = true
	ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	ScrollingFrame.Size = UDim2.new(1, -5, 1, -5)
	ScrollingFrame.ZIndex = BaseZ_Index + 5
	ScrollingFrame.BottomImage = ""
	ScrollingFrame.ScrollBarThickness = 0
	ScrollingFrame.TopImage = ""

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X,UIListLayout.AbsoluteContentSize.Y)
	end);

	local ToggleUI = function(bool)
		local IsSame = ToggleDb:GetValue() == bool;

		EventOut:Fire(bool);
		ToggleDb:Fire(bool);

		local MUL = Window.AbsoluteSize.Y / 2;

		local MainPosition = UDim2.fromOffset(BaseParent.AbsolutePosition.X + 1,BaseParent.AbsolutePosition.Y + 80);
		local DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset + 25);

		if MainPosition.Y.Offset > MUL then -- go up
			MainPosition = UDim2.fromOffset(BaseParent.AbsolutePosition.X + 1,BaseParent.AbsolutePosition.Y + 55);
			DropPosition = UDim2.fromOffset(MainPosition.X.Offset,MainPosition.Y.Offset - 25);

			DropdownWindow.AnchorPoint = Vector2.new(0,1);
		else
			DropdownWindow.AnchorPoint = Vector2.zero;
		end;

		if bool then
			if not IsSame then
				DropdownWindow.Position = DropPosition;
			end;

			Compkiller:_Animation(DropdownWindow,TweenInfo.new(0.2),{
				BackgroundTransparency = 0,
				Position = MainPosition,
				Size = UDim2.new(0, BaseParent.AbsoluteSize.X - 1, 0, math.clamp(UIListLayout.AbsoluteContentSize.Y + 10,10 , 200))
			})

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
				Transparency = 0
			})
		else
			Compkiller:_Animation(DropdownWindow,TweenInfo.new(0.2),{
				BackgroundTransparency = 1,
				Position = DropPosition,
				Size = UDim2.new(0, BaseParent.AbsoluteSize.X - 1, 0, math.clamp(UIListLayout.AbsoluteContentSize.Y / 1.5, 10 , 200))
			})

			Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
				Transparency = 1
			})
		end;
	end;

	ToggleUI(false)

	local SpamUpdate,_Delay = false , tick();
	local __signals = {};
	local Default = nil;
	local Values = nil;
	local IsMulti = false;

	local DrawButton = function()
		local DropdownItem = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")

		DropdownItem.Name = "DropdownItem"
		DropdownItem.BackgroundTransparency = 1.000
		DropdownItem.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownItem.BorderSizePixel = 0
		DropdownItem.Size = UDim2.new(1, -1, 0, 20)
		DropdownItem.ZIndex = BaseZ_Index + 6

		BlockText.Name = "BlockText"
		BlockText.Parent = DropdownItem
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 5, 0.5, 0)
		BlockText.Size = UDim2.new(1, -10, 0, 25)
		BlockText.ZIndex = BaseZ_Index + 6 
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = ""
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 13.000
		BlockText.TextTransparency = 0.500
		BlockText.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});
		
		BlockLine.Name = "BlockLine"
		BlockLine.Parent = DropdownItem
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -6, 0, 1)
		BlockLine.ZIndex = BaseZ_Index + 7
		
		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		return {
			BlockText = BlockText,
			DropdownItem = DropdownItem,
			BlockLine = BlockLine,
		};
	end;

	local ClearDropdown = function()
		for i,v in next , ScrollingFrame:GetChildren() do
			if v:IsA('Frame') then
				v:Destroy();
			end;
		end;

		for i,v in next,  __signals do
			v:Disconnect();
		end;
	end;

	local IsDefault = function(v)
		return (typeof(Default) == 'table' and (Default[v] or table.find(Default,v))) or Default == v;
	end;

	local MatchDefault = function(v,DataFrame)
		return (typeof(DataFrame) == 'table' and (DataFrame[v] or table.find(DataFrame,v))) or DataFrame == v;
	end;

	local UpdateDropdown = function()
		local DataFrame;

		if IsMulti then
			DataFrame = {};
		end;

		for i,v in next , Values do
			local bth = DrawButton();

			bth.BlockText.Text = tostring(v);

			bth.DropdownItem.Parent = ScrollingFrame;

			bth.Value = v;

			table.insert(__signals , ToggleDb:Connect(function(bool)
				if bool then
					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
					});

					Compkiller:_Animation(bth.BlockLine,TweenInfo.new(0.2),{
						BackgroundTransparency = 0
					});
				else
					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = 1
					});

					Compkiller:_Animation(bth.BlockLine,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					});
				end;
			end));

			if ToggleDb:GetValue() then
				Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
					TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
				});
			end;

			if IsDefault(v) and not IsMulti then
				DataFrame = bth;
			end;

			if IsMulti then
				if IsDefault(v) or MatchDefault(v,DataFrame) then
					DataFrame[v] = true;
				else
					DataFrame[v] = false;
				end;

				Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
					TextTransparency = ((MatchDefault(v,DataFrame)) and 0) or 0.5
				});

				Compkiller:_Input(bth.DropdownItem,function()
					DataFrame[v] = not DataFrame[v];

					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((MatchDefault(v,DataFrame)) and 0) or 0.5
					});

					Callback(DataFrame)
				end);
			else
				Compkiller:_Input(bth.DropdownItem,function()
					if DataFrame then
						Compkiller:_Animation(DataFrame.BlockText,TweenInfo.new(0.2),{
							TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
						});
					end;

					Default = v;

					DataFrame = bth;

					Compkiller:_Animation(bth.BlockText,TweenInfo.new(0.2),{
						TextTransparency = ((IsDefault(v) or MatchDefault(v,DataFrame)) and 0) or 0.5
					});

					Callback(DataFrame.Value)
				end);
			end;
		end;
	end;

	BaseParent.MouseButton1Click:Connect(function()
		if SpamUpdate then
			ClearDropdown();
			UpdateDropdown();
		end;

		ToggleUI(true);

		if not ToggleDb:GetValue() then
			ToggleUI(false);
		end
	end);

	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			if not Compkiller:_IsMouseOverFrame(DropdownWindow) then
				ToggleUI(false);
			end;
		end;
	end);

	local Args = {};

	function Args:SetDefault(v)
		Default = v;
	end;

	function Args:SetData(Def,Val,Multi,Vis)
		if Vis and ((tick() - _Delay) <= 0.5 or #Val > 10) then
			_Delay = tick();
			SpamUpdate = true;
		else
			SpamUpdate = false;	
		end;

		IsMulti = Multi;
		Default = Def;
		Values = Val;

		if Vis and not SpamUpdate then
			ClearDropdown();
			UpdateDropdown();
		end;
	end;

	function Args:Refersh()
		ClearDropdown();
		UpdateDropdown();
	end;

	Args.EventOut = EventOut;

	return Args;
end;

function Compkiller:_LoadElement(Parent: Frame , EnabledLine: boolean , Signal)
	local Zindex = Parent.ZIndex + 1;
	local Tween = TweenInfo.new(0.25,Enum.EasingStyle.Quint);

	local Args = {};

	function Args:AddToggle(Config : Toggle)
		Config = Compkiller:_ConvertArgs(Config)

		Config = Compkiller.__CONFIG(Config,{
			Name = "Toggle",
			Default = false,
			Flag = nil,
			Risky = false,
			Callback = function() end;
		});

		local Block = Compkiller:_CreateBlock(Signal);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		if Config.Risky then
			Block:SetTextColor(Compkiller.Colors.Risky);
		end;

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local Toggle = Block:AddLink('Toggle' , Config.Default);

		Toggle.Input.MouseButton1Click:Connect(function()
			Config.Default = not Config.Default;

			Toggle.ChangeValue(Config.Default);

			Block:SetTransparency((Config.Default and 0.1) or 0.3);

			Config.Callback(Config.Default);
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value)
			Config.Default = value;

			Toggle.ChangeValue(Config.Default);

			Block:SetTransparency((Config.Default and 0.1) or 0.3);

			Config.Callback(Config.Default);
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);

		end);

		Args.Link = Compkiller:_LoadOption(Block);
		Args.Options = Args.Link:AddOption();

		if typeof(Config.Content) == 'string' then
			Args.Link:AddHelper({
				Text = Config.Content
			})
		end

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddKeybind(Config : Keybind)
		Config = Compkiller.__CONFIG(Config,{
			Name = "Keybind",
			Default = nil,
			Flag = nil,
			Callback = function() end;
			Blacklist = {}
		});

		local Block = Compkiller:_CreateBlock(Signal);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local Keybind = Block:AddLink('Keybind' , Config.Default);

		local IsBinding = false;

		local IsBlacklist = function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end;

		Compkiller:_Input(Keybind.Root,function()
			if IsBinding then
				return;
			end;

			Keybind.SetValue("...");

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("MouseLeft") then
						Selected = "MouseLeft";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("MouseRight") then
						Selected = "MouseRight";
					end;
				end;
			end;

			local KeyName = typeof(Selected) == "string" and Selected or Selected.Name;

			Config.Default = KeyName;

			Keybind.SetValue(Selected);

			IsBinding = false;

			Config.Callback(KeyName);
		end);

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value)
			Config.Default = value;

			Keybind.SetValue(Config.Default);

			Config.Callback(Config.Default);
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);
		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return (typeof(Config.Default) == "string" and Config.Default) or Config.Default.Name;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddColorPicker(Config: ColorPicker)
		Config = Compkiller.__CONFIG(Config,{
			Name = "ColorPicker",
			Default = Color3.fromRGB(255,255,255),
			Flag = nil,
			Transparency = 0,
			Callback = function() end;
		});

		local Block = Compkiller:_CreateBlock(Signal);

		Block:SetParent(Parent);

		Block:SetText(Config.Name);

		Block:SetLine(EnabledLine);

		Block:SetVisible(Signal:GetValue());

		local ColorPicker:Frame , ColorFrame: Frame = Block:AddLink('ColorPicker' , Config.Default);

		local Button = Compkiller:_Input(ColorPicker);

		local ColorPicker = Compkiller:_AddColorPickerPanel(Button,function(color,opc)
			Config.Default = color;
			Config.Transparency = opc;

			ColorFrame.BackgroundColor3 = color;
			ColorFrame.BackgroundTransparency = opc;

			Config.Callback(Config.Default , Config.Transparency);
		end);

		ColorPicker:SetColor(Config.Default,Config.Transparency);
		ColorPicker:Update()

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(value,opc)
			Config.Default = value;
			Config.Transparency = opc;

			ColorPicker:SetColor(value,opc);
			ColorPicker:Update();

			Config.Callback(value,opc);
		end;

		Args.Signal = Signal:Connect(function(bool)
			Block:SetVisible(bool);
		end);

		Args.Link = Compkiller:_LoadOption(Block);

		function Args:GetValue()
			return {
				ColorPicker = {
					Color = Config.Default,
					Transparency = Config.Transparency
				}
			};
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddButton(Config: Button)
		Config = Compkiller:_ConvertArgs(Config)

		Config = Compkiller.__CONFIG(Config , {
			Name = 'Button',
			Callback = function() end
		});

		local Button = Instance.new("Frame")
		local BlockLine = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")

		Button.Name = "Button"
		Button.Parent = Parent
		Button.BackgroundTransparency = 1.000
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(1, -1, 0, 30)
		Button.ZIndex = Zindex + 5

		BlockLine.Name = "BlockLine"
		BlockLine.Parent = Button
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.6
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 6
		
		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		Frame.Parent = Button
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame.BackgroundTransparency = 0.600
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame.Size = UDim2.new(1, -15, 1, -5)
		Frame.ZIndex = Zindex + 7;

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame,
			Property = "BackgroundColor3"
		});

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = Frame
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});
		
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Frame

		TextLabel.Parent = Frame
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.ZIndex = Zindex + 8
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = Config.Name;
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 12.000
		TextLabel.TextStrokeTransparency = 0.900
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextLabel,
			Property = 'TextColor3'
		});

		Compkiller:_Hover(Frame,function()
			if Signal:GetValue() then
				Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.600
				})
			end;
		end,function()
			if Signal:GetValue() then
				Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.600
				})
			end;
		end);

		Compkiller:_Input(Frame,function()
			Config.Callback();
		end);

		local Args = {};

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockLine, TweenInfo.new(0.35),{
					BackgroundTransparency = 0.500
				});

				Compkiller:_Animation(Frame, TweenInfo.new(0.35),{
					BackgroundTransparency = 0.600
				});

				Compkiller:_Animation(UIStroke, TweenInfo.new(0.35),{
					Transparency = 0
				});

				Compkiller:_Animation(TextLabel, TweenInfo.new(0.35),{
					TextStrokeTransparency = 0.900,
					TextTransparency = 0
				});

			else
				Compkiller:_Animation(BlockLine, TweenInfo.new(0.35),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(Frame, TweenInfo.new(0.35),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke, TweenInfo.new(0.35),{
					Transparency = 1
				});

				Compkiller:_Animation(TextLabel, TweenInfo.new(0.35),{
					TextStrokeTransparency = 1,
					TextTransparency = 1
				});
			end;
		end);

		function Args:SetText(t)
			Config.Name = t;
			TextLabel.Text = Config.Name;
		end;

		return Args;
	end;

	function Args:AddSlider(Config: Slider)
		Config = Compkiller:_ConvertArgs(Config)

		Config = Compkiller.__CONFIG(Config , {
			Name = 'Slider',
			Default = 50,
			Min = 0,
			Max = 100,
			Type = "",
			Round = 0,
			Callback = function() end
		});

		local Slider = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local SliderBar = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local SliderInput = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local UIScale = Instance.new("UIScale")
		local ValueText = Instance.new("TextBox")

		Slider.Name = "Slider"
		Slider.Parent = Parent
		Slider.BackgroundTransparency = 1.000
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(1, -1, 0, 45)
		Slider.ZIndex = Zindex + 1

		BlockText.Name = "BlockText"
		BlockText.Parent = Slider
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 1)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 2
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.100
		BlockText.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});
		
		BlockLine.Name = "BlockLine"
		BlockLine.Parent = Slider
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 2
		BlockLine.Visible = EnabledLine or false;
		
		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});
		
		SliderBar.Name = "SliderBar"
		SliderBar.Parent = Slider
		SliderBar.AnchorPoint = Vector2.new(0.5, 1)
		SliderBar.BackgroundColor3 = Compkiller.Colors.DropColor
		SliderBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SliderBar.BorderSizePixel = 0
		SliderBar.ClipsDescendants = true
		SliderBar.Position = UDim2.new(0.5, 0, 1, -9)
		SliderBar.Size = UDim2.new(1, -25, 0, 10)
		SliderBar.ZIndex = Zindex + 3
		
		table.insert(Compkiller.Elements.DropColor , {
			Element = SliderBar,
			Property = "BackgroundColor3"
		})

		Compkiller:_AddDragBlacklist(SliderBar)

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = SliderBar
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = SliderBar

		SliderInput.Name = "SliderInput"
		SliderInput.Parent = SliderBar
		SliderInput.AnchorPoint = Vector2.new(0, 0.5)
		SliderInput.BackgroundColor3 = Compkiller.Colors.Highlight
		SliderInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SliderInput.BorderSizePixel = 0
		SliderInput.Position = UDim2.new(0, 0, 0.5, 0)
		SliderInput.Size = UDim2.new((Config.Default - Config.Min) / (Config.Max - Config.Min), 0, 1, 0)
		SliderInput.ZIndex = Zindex + 4

		table.insert(Compkiller.Elements.Highlight,{
			Element = SliderInput,
			Property = "BackgroundColor3"
		});

		UICorner_2.CornerRadius = UDim.new(0, 6)
		UICorner_2.Parent = SliderInput

		Frame.Parent = SliderInput
		Frame.AnchorPoint = Vector2.new(1, 0.5)
		Frame.BackgroundColor3 = Compkiller.Colors.SwitchColor
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(1, 5, 0.5, 0)
		Frame.Rotation = 45.000
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Frame.ZIndex = Zindex + 6
		Frame.BackgroundTransparency = 1
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = Frame,
			Property = 'BackgroundColor3'
		});
		
		UICorner_3.CornerRadius = UDim.new(3, 0)
		UICorner_3.Parent = Frame

		UIScale.Parent = Frame
		UIScale.Scale = 1.300

		ValueText.Name = "ValueText"
		ValueText.Parent = Slider
		ValueText.BackgroundTransparency = 1.000
		ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueText.BorderSizePixel = 0
		ValueText.Position = UDim2.new(0, 12, 0, 1)
		ValueText.Size = UDim2.new(1, -20, 0, 25)
		ValueText.ZIndex = Zindex + 4
		ValueText.Font = Enum.Font.GothamMedium
		ValueText.Text = tostring(Config.Default)..tostring(Config.Type)
		ValueText.TextColor3 = Compkiller.Colors.SwitchColor
		ValueText.TextSize = 12.000
		ValueText.TextTransparency = 0.750
		ValueText.TextXAlignment = Enum.TextXAlignment.Right
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = ValueText,
			Property = 'TextColor3'
		});
		
		Compkiller:_Hover(SliderBar,function()
			if Signal:GetValue() then
				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 0.2
				})
			end;
		end,function()
			if Signal:GetValue() then
				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 0.750
				})
			end;
		end)	

		local IsHold = false;

		local Update = function(Input)
			local SizeScale = math.clamp((((Input.Position.X) - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X), 0, 1);

			local Main = ((Config.Max - Config.Min) * SizeScale) + Config.Min;

			local Value = Compkiller:_Rounding(Main,Config.Round);

			local PositionX = UDim2.fromScale(SizeScale, 1);

			local Size = (Value - Config.Min) / (Config.Max - Config.Min);

			TweenService:Create(SliderInput , TweenInfo.new(0.2),{
				Size = UDim2.new(Size, 0, 1, 0)
			}):Play();

			Config.Default = Value;

			ValueText.Text = tostring(Config.Default)..tostring(Config.Type)

			Config.Callback(Value)
		end;

		ValueText.FocusLost:Connect(function()
            local Value = tonumber(ValueText.Text)
            if Value then
                local FakedValue = Value > Config.Max and Config.Max or Value

                local Size = (FakedValue - Config.Min) / (Config.Max - Config.Min);

                TweenService:Create(SliderInput , TweenInfo.new(0.2),{
                    Size = UDim2.new(Size, 0, 1, 0)
                }):Play();

                Config.Default = Value;

                ValueText.Text = tostring(Config.Default)..tostring(Config.Type)

                Config.Callback(Value)
            end
        end)

		do
			SliderBar.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					IsHold = true
					Update(Input)
				end
			end)

			SliderBar.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if UserInputService.TouchEnabled then
						if not Compkiller:_IsMouseOverFrame(SliderBar) then
							IsHold = false
						end;
					else
						IsHold = false
					end;
				end
			end)

			UserInputService.InputChanged:Connect(function(Input)
				if IsHold then
					if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)  then
						if UserInputService.TouchEnabled then
							if not Compkiller:_IsMouseOverFrame(SliderBar) then
								IsHold = false
							else
								Update(Input)
							end;
						else
							Update(Input)
						end;
					end;
				end;
			end);
		end;

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(Value)
			Config.Default = Value;

			ValueText.Text = tostring(Config.Default)..tostring(Config.Type)

			Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
				Size = UDim2.new((Config.Default - Config.Min) / (Config.Max - Config.Min), 0, 1, 0)
			});

			Config.Callback(Value);
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
					Size = UDim2.new((Config.Default - Config.Min) / (Config.Max - Config.Min), 0, 1, 0)
				});

				Compkiller:_Animation(ValueText,Tween,{
					TextTransparency = 0.750
				})

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(SliderInput,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 0
				})

				Compkiller:_Animation(SliderBar,Tween,{
					BackgroundTransparency = 0
				})

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 0.5
				})

				Compkiller:_Animation(BlockText,Tween,{
					TextTransparency = 0.1
				})
			else
				Compkiller:_Animation(SliderInput, TweenInfo.new(0.35),{
					Size = UDim2.new(0, 0, 1, 0)
				});

				Compkiller:_Animation(ValueText,Tween,{
					TextTransparency = 1
				})

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(SliderInput,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 1
				})

				Compkiller:_Animation(SliderBar,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(BlockText,Tween,{
					TextTransparency = 1
				})
			end;
		end);

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddParagraph(Config: Paragraph) -- request by Neptune
		Config = Compkiller:_ConvertArgs(Config)

		Config = Compkiller.__CONFIG(Config, {
			Title = "Paragraph",
			Content = ""
		});

		local Paragraph = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local DescriptionText = Instance.new("TextLabel")

		Paragraph.Name = "Paragraph"
		Paragraph.Parent = Parent
		Paragraph.BackgroundTransparency = 1.000
		Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Paragraph.BorderSizePixel = 0
		Paragraph.Size = UDim2.new(1, -1, 0, 40)
		Paragraph.ZIndex = Zindex + 2
		Paragraph.ClipsDescendants = true

		BlockText.Name = "BlockText"
		BlockText.Parent = Paragraph
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 12)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 3
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Title
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left
		BlockText.RichText = true
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = "BlockLine"
		BlockLine.Parent = Paragraph
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 4
		
		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});
		
		DescriptionText.RichText = true
		DescriptionText.Name = "DescriptionText"
		DescriptionText.Parent = Paragraph
		DescriptionText.BackgroundTransparency = 1.000
		DescriptionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DescriptionText.BorderSizePixel = 0
		DescriptionText.Position = UDim2.new(0, 12, 0, 22)
		DescriptionText.Size = UDim2.new(1, -20, 1, -25)
		DescriptionText.ZIndex = Zindex + 5
		DescriptionText.Font = Enum.Font.GothamMedium
		DescriptionText.Text = Config.Content
		DescriptionText.TextColor3 = Compkiller.Colors.SwitchColor
		DescriptionText.TextSize = 13.000
		DescriptionText.TextTransparency = 0.500
		DescriptionText.TextXAlignment = Enum.TextXAlignment.Left
		DescriptionText.TextYAlignment = Enum.TextYAlignment.Top
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = DescriptionText,
			Property = 'TextColor3'
		});
		
		local Base = 15;

		local UpdateScale = function()

			if not DescriptionText.Text:byte() then
				local TitleScale = TextService:GetTextSize(BlockText.Text,BlockText.TextSize,BlockText.Font,Vector2.new(math.huge,math.huge));

				Compkiller:_Animation(Paragraph,TweenInfo.new(0.15),{
					Size = UDim2.new(1, -1, 0, TitleScale.Y + Base)
				});
			else
				local TitleScale = TextService:GetTextSize(BlockText.Text,BlockText.TextSize,BlockText.Font,Vector2.new(math.huge,math.huge));
				local ContentScale = TextService:GetTextSize(DescriptionText.Text,DescriptionText.TextSize,DescriptionText.Font,Vector2.new(math.huge,math.huge));

				Compkiller:_Animation(Paragraph,TweenInfo.new(0.15),{
					Size = UDim2.new(1, -1, 0, (TitleScale.Y + ContentScale.Y) + Base)
				});
			end;
		end;

		UpdateScale();

		local Args = {};

		function Args:SetTitle(title)
			BlockText.Text = title;
			UpdateScale();
		end;

		function Args:SetContent(content)
			DescriptionText.Text = content;
			UpdateScale();
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.300
				});

				Compkiller:_Animation(DescriptionText,TweenInfo.new(0.2),{
					TextTransparency = 0.500
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.500
				});
			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(DescriptionText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});
			end;
		end);

		return Args;
	end;
	
	function Args:AddTextBox(Config: TextBoxConfig)
		Config = Compkiller.__CONFIG(Config , {
			Name = "TextBox",
			Default = "",
			Placeholder = "Placeholder",
			Numberic = false,
			Callback = function() end,
		});
		
		local TextBox = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local LinkValues = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local TextBox_2 = Instance.new("TextBox")
		local BlockLine = Instance.new("Frame")
		
		TextBox.Name = "TextBox"
		TextBox.Parent = Parent
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Size = UDim2.new(1, -1, 0, 30)
		TextBox.ZIndex = Zindex + 1

		BlockText.Name = "BlockText"
		BlockText.Parent = TextBox
		BlockText.AnchorPoint = Vector2.new(0, 0.5)
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0.5, 0)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 2
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.300
		BlockText.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor,{
			Element = BlockText,
			Property = "TextColor3"
		})
		
		LinkValues.Name = "LinkValues"
		LinkValues.Parent = TextBox
		LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
		LinkValues.BackgroundColor3 = Compkiller.Colors.DropColor
		LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LinkValues.BorderSizePixel = 0
		LinkValues.Position = UDim2.new(1, -12, 0.5, 0)
		LinkValues.Size = UDim2.new(0, 95, 0, 16)
		LinkValues.ZIndex = Zindex + 3
		
		table.insert(Compkiller.Elements.DropColor,{
			Element = LinkValues,
			Property = "BackgroundColor3"
		})
		
		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = LinkValues
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		})

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = LinkValues

		TextBox_2.Parent = LinkValues
		TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox_2.BackgroundTransparency = 1.000
		TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox_2.BorderSizePixel = 0
		TextBox_2.ClipsDescendants = true
		TextBox_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBox_2.Size = UDim2.new(1, -5, 1, 0)
		TextBox_2.ZIndex = Zindex + 5
		TextBox_2.ClearTextOnFocus = false
		TextBox_2.Font = Enum.Font.GothamMedium
		TextBox_2.PlaceholderText = Config.Placeholder
		TextBox_2.Text = Config.Default
		TextBox_2.TextColor3 = Compkiller.Colors.SwitchColor
		TextBox_2.TextSize = 11.000
		
		table.insert(Compkiller.Elements.SwitchColor,{
			Element = TextBox_2,
			Property = "TextColor3"
		})
		
		BlockLine.Name = "BlockLine"
		BlockLine.Parent = TextBox
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 3;
		
		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		})
		
		local Update = function()
			local scale = TextService:GetTextSize(TextBox_2.Text,TextBox_2.TextSize,TextBox_2.Font,Vector2.new(math.huge,math.huge));
			local Base = TextService:GetTextSize(TextBox_2.PlaceholderText,TextBox_2.TextSize,TextBox_2.Font,Vector2.new(math.huge,math.huge));

			local MainScale = ((scale.X > Base.X) and scale.X) or Base.X;
			
			Compkiller:_Animation(LinkValues,TweenInfo.new(0.25),{
				Size = UDim2.fromOffset(math.clamp(MainScale + 7 , Base.X , TextBox.AbsoluteSize.X / 2) , 16)
			})
		end;

		local parse = function(text)
			if not text then
				return "";	
			end;

			if Config.Numeric then
				local out = string.gsub(tostring(text), '[^0-9.]', '')

				if tonumber(out) then
					return tonumber(out);
				end;

				return nil;
			end;

			return text;
		end;
		
		Update();

		TextBox_2:GetPropertyChangedSignal('Text'):Connect(Update);
		
		TextBox_2:GetPropertyChangedSignal('Text'):Connect(function()
			local value = parse(TextBox_2.Text);
			
			if value then
				
				TextBox_2.Text = tostring(value);

				task.spawn(Config.Callback,value);
				
				Config.Default = value;
			else
				TextBox_2.Text = string.gsub(TextBox_2.Text, '[^0-9.]', '');
				
				Config.Default = TextBox_2.Text;
			end;
		end);
		
		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(Value)
			Config.Default = Value;

			TextBox_2.Text = tostring(Config.Default);
			
			Config.Callback(Value);
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.3
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.5
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 0
				});

				Compkiller:_Animation(LinkValues,TweenInfo.new(0.2),{
					BackgroundTransparency = 0
				});
				
			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 1
				});

				Compkiller:_Animation(LinkValues,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

			end;
		end);

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	function Args:AddDropdown(Config : Dropdown)
		Config = Compkiller:_ConvertArgs(Config)

		Config = Compkiller.__CONFIG(Config,{
			Name = "Dropdown",
			Default = nil,
			Values = {"Item 1","Item 2","Item 3"},
			Multi = false,
			Callback = function() end;
		});

		local DaTabarser = function(value)
			if not value then return ''; end;

			local Out;

			if typeof(value) == 'table' then
				if #value > 0 then
					local x = {};

					for i,v in next , value do
						table.insert(x , tostring(v))
					end;

					Out = table.concat(x,' , ');
				else
					local x = {};

					for i,v in next , value do
						if v == true then
							table.insert(x , tostring(i));
						end			
					end;

					Out = table.concat(x,' , ');
				end;
			else
				Out = tostring(value);
			end;

			return Out;
		end;

		local Dropdown = Instance.new("Frame")
		local BlockText = Instance.new("TextLabel")
		local BlockLine = Instance.new("Frame")
		local LinkValues = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local ValueItems = Instance.new("Frame")
		local UIStroke = Instance.new("UIStroke")
		local UICorner = Instance.new("UICorner")
		local ValueText = Instance.new("TextLabel")
		local MainButton = Instance.new("ImageButton")

		Dropdown.Name = "Dropdown"
		Dropdown.Parent = Parent
		Dropdown.BackgroundTransparency = 1.000
		Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Dropdown.BorderSizePixel = 0
		Dropdown.Size = UDim2.new(1, -1, 0, 55)
		Dropdown.ZIndex = Zindex + 2

		BlockText.Name = "BlockText"
		BlockText.Parent = Dropdown
		BlockText.BackgroundTransparency = 1.000
		BlockText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockText.BorderSizePixel = 0
		BlockText.Position = UDim2.new(0, 12, 0, 1)
		BlockText.Size = UDim2.new(1, -20, 0, 25)
		BlockText.ZIndex = Zindex + 3
		BlockText.Font = Enum.Font.GothamMedium
		BlockText.Text = Config.Name
		BlockText.TextColor3 = Compkiller.Colors.SwitchColor
		BlockText.TextSize = 14.000
		BlockText.TextTransparency = 0.100
		BlockText.TextXAlignment = Enum.TextXAlignment.Left

		if not BlockText.Text:byte() then
			Dropdown.Size = UDim2.new(1, -1, 0, 25)
		end;
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = BlockText,
			Property = 'TextColor3'
		});

		BlockLine.Name = "BlockLine"
		BlockLine.Parent = Dropdown
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 1, 0)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = Zindex + 3
		
		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		LinkValues.Name = "LinkValues"
		LinkValues.Parent = Dropdown
		LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
		LinkValues.BackgroundTransparency = 1.000
		LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LinkValues.BorderSizePixel = 0
		LinkValues.Position = UDim2.new(1, -12, 0, 15)
		LinkValues.Size = UDim2.new(1, 0, 0, 18)
		LinkValues.ZIndex = Zindex + 3

		UIListLayout.Parent = LinkValues
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 8)

		ValueItems.Name = "ValueItems"
		ValueItems.Parent = Dropdown
		ValueItems.AnchorPoint = Vector2.new(0.5, 1)
		ValueItems.BackgroundColor3 = Compkiller.Colors.DropColor
		ValueItems.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueItems.BorderSizePixel = 0
		ValueItems.ClipsDescendants = true
		ValueItems.Position = UDim2.new(0.5, 0, 1, -7)
		ValueItems.Size = UDim2.new(1, -25, 0, 18)
		ValueItems.ZIndex = Zindex + 5
		
		table.insert(Compkiller.Elements.DropColor , {
			Element = ValueItems,
			Property = "BackgroundColor3"
		})
		
		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = ValueItems
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});
		
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = ValueItems

		ValueText.Name = "ValueText"
		ValueText.Parent = ValueItems
		ValueText.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueText.BackgroundTransparency = 1.000
		ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueText.BorderSizePixel = 0
		ValueText.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueText.Size = UDim2.new(1, -10, 0, 15)
		ValueText.ZIndex = Zindex + 8
		ValueText.Font = Enum.Font.Gotham
		ValueText.Text = DaTabarser(Config.Default)
		ValueText.TextColor3 = Compkiller.Colors.SwitchColor
		ValueText.TextSize = 11.000
		ValueText.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = ValueText,
			Property = 'TextColor3'
		});
		
		MainButton.Name = "MainButton"
		MainButton.Parent = ValueItems
		MainButton.AnchorPoint = Vector2.new(1, 0.5)
		MainButton.BackgroundTransparency = 1.000
		MainButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainButton.BorderSizePixel = 0
		MainButton.Position = UDim2.new(1, -5, 0.5, 0)
		MainButton.Size = UDim2.new(0, 13, 0, 13)
		MainButton.ZIndex = Zindex + 5
		MainButton.Image = "rbxassetid://10709790948"

		Compkiller:_Hover(ValueItems,function()
			Compkiller:_Animation(ValueItems,TweenInfo.new(0.3),{
				BackgroundColor3 = Compkiller.Colors.MouseEnter
			});
		end,function()
			Compkiller:_Animation(ValueItems,TweenInfo.new(0.3),{
				BackgroundColor3 = Compkiller.Colors.DropColor
			});
		end);

		local repi;
		local Button = Compkiller:_Input(ValueItems);

		repi = Compkiller:_LoadDropdown(Button,function(value)
		  if Config.Multi then
			  local Value = value or {}
				local Dumped = {}

				for i,v in Value do
					if typeof(i) == 'string' then
						if v then
						  table.insert(Dumped, i)
						end
					else
						table.insert(Dumped, v)
					end
				end

				value = Dumped
			end
		
			Config.Default = value;

			repi:SetData(Config.Default,Config.Values,Config.Multi,false);
			repi:SetDefault(Config.Default);

			ValueText.Text = DaTabarser(Config.Default);

			Config.Callback(value);
		end);

		repi.EventOut:Connect(function(v)
			if v then
				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					Rotation = -180
				})
			else
				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					Rotation = 0
				})
			end;
		end)

		repi:SetData(Config.Default,Config.Values,Config.Multi,false);
		repi:Refersh();

		local Args = {};

		Args.Flag = Config.Flag;

		function Args:SetValue(Value)
			if Config.Multi then
			  Value = Value or {}
				local Dumped = {}

				for i,v in Value do
					if typeof(i) == 'string' then
						if v then
						  table.insert(Dumped, i)
						end
					else
						table.insert(Dumped, v)
					end
				end

				Value = Dumped
			end
			
			Config.Default = Value;

			ValueText.Text = DaTabarser(Config.Default);

			repi:SetData(Config.Default,Config.Values,Config.Multi,true);

			Config.Callback(Value);
		end;

		function Args:SetValues(v)
			Config.Values = v;

			repi:SetData(Config.Default,Config.Values,Config.Multi,true);
		end;

		Args.Signal = Signal:Connect(function(bool)
			if bool then
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 0.100
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 0.100
				});

				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundTransparency = 0
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 0
				});

				Compkiller:_Animation(ValueText,TweenInfo.new(0.32),{
					TextTransparency = 0
				});

				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					ImageTransparency = 0
				});
			else
				Compkiller:_Animation(BlockText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(BlockLine,TweenInfo.new(0.2),{
					BackgroundTransparency = 1 
				});

				Compkiller:_Animation(ValueItems,TweenInfo.new(0.2),{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
					Transparency = 1
				});

				Compkiller:_Animation(ValueText,TweenInfo.new(0.2),{
					TextTransparency = 1
				});

				Compkiller:_Animation(MainButton,TweenInfo.new(0.2),{
					ImageTransparency = 1
				});
			end;
		end);

		Args.Link = Compkiller:_LoadOption({
			AddLink = function(self ,Name , Default)
				return Compkiller:_AddLinkValue(Name , Default , LinkValues , LinkValues , {
					Tween = TweenInfo.new(0.2)	
				} , Signal);
			end,
			Root = Dropdown
		});

		function Args:GetValue()
			return Config.Default;
		end;

		if Config.Flag then
			Compkiller.Flags[Config.Flag] = Args;
		end;

		return Args;
	end;

	return Args;
end;

function Compkiller:GetTheme()
	return Compkiller.Colors;
end;

function Compkiller:SetTheme(name)
	if name == "Dark Green" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0429964, 0.110345, 0.0727226),
			["BlockBackground"] = Color3.new(0.159287, 0.234483, 0.201811),
			["BlockColor"] = Color3.new(0, 0.137931, 0.0951249),
			["DropColor"] = Color3.new(0, 0.227586, 0.100452),
			["Highlight"] = Color3.new(0.0666667, 0.992157, 0.628343),
			["LineColor"] = Color3.new(0.263258, 0.372414, 0.329504),
			["MouseEnter"] = Color3.new(0, 0.841379, 0.51063),
			["Risky"] = Color3.new(1, 0.398296, 0.152941),
			["StrokeColor"] = Color3.new(0.132342, 0.241379, 0.198517),
			["SwitchColor"] = Color3.new(0.927586, 1, 0.980523),
			["Toggle"] = Color3.new(0, 0.613793, 0.220119),
			HighStrokeColor = Color3.new(0, 0.241379, 0.186445),
		};
	elseif name == "Default" then
		Compkiller.Colors = {
			Highlight = Color3.fromRGB(17, 238, 253),
			Toggle = Color3.fromRGB(14, 203, 213),
			Risky = Color3.fromRGB(251, 255, 39),
			BGDBColor = Color3.fromRGB(22, 24, 29),
			BlockColor = Color3.fromRGB(28, 29, 34),
			StrokeColor = Color3.fromRGB(37, 38, 43),
			SwitchColor = Color3.fromRGB(255, 255, 255),
			DropColor = Color3.fromRGB(33, 35, 39),
			MouseEnter = Color3.fromRGB(55, 58, 65),
			BlockBackground = Color3.fromRGB(39, 40, 47),
			LineColor = Color3.fromRGB(65, 65, 65),
			HighStrokeColor = Color3.fromRGB(55, 56, 63),
		};
	elseif name == "Dark Blue" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0393817, 0.0754204, 0.165517),
			["BlockBackground"] = Color3.new(0, 0.0618311, 0.172414),
			["BlockColor"] = Color3.new(0, 0.0172414, 0.103448),
			["DropColor"] = Color3.new(0, 0.0965518, 0.289655),
			["HighStrokeColor"] = Color3.new(0, 0.132604, 0.234483),
			["Highlight"] = Color3.new(0.0666667, 0.781528, 0.992157),
			["LineColor"] = Color3.new(0, 0.110345, 0.275862),
			["MouseEnter"] = Color3.new(0, 0.606896, 1),
			["Risky"] = Color3.new(0.0310345, 0.819572, 1),
			["StrokeColor"] = Color3.new(0, 0.119857, 0.248276),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0.054902, 0.463935, 0.835294)
		}
	elseif name == "Purple Rose" then
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.0459068, 0.030321, 0.117241),
			["BlockBackground"] = Color3.new(0.156272, 0.119596, 0.324138),
			["BlockColor"] = Color3.new(0.0948428, 0.0576457, 0.165517),
			["DropColor"] = Color3.new(0.131034, 0, 0.0813317),
			["HighStrokeColor"] = Color3.new(0.136259, 0.101237, 0.296552),
			["Highlight"] = Color3.new(0.992157, 0.0666667, 0.33474),
			["LineColor"] = Color3.new(0.20872, 0.137408, 0.372414),
			["MouseEnter"] = Color3.new(0.365517, 0, 0.120999),
			["Risky"] = Color3.new(1, 0.6086, 0.152941),
			["StrokeColor"] = Color3.new(0.148499, 0.137836, 0.248276),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0.835294, 0.054902, 0.248654)
		}
	elseif name == "Skeet" then		
		Compkiller.Colors = {
			["BGDBColor"] = Color3.new(0.114578, 0.125191, 0.151724),
			["BlockBackground"] = Color3.new(0.128181, 0.131124, 0.151724),
			["BlockColor"] = Color3.new(0.0732699, 0.0760008, 0.0896552),
			["DropColor"] = Color3.new(0.0809037, 0.0861197, 0.0965517),
			["HighStrokeColor"] = Color3.new(0.119382, 0.1217, 0.137931),
			["Highlight"] = Color3.new(0, 0.634483, 0.0700119),
			["LineColor"] = Color3.new(0.151724, 0.151724, 0.151724),
			["MouseEnter"] = Color3.new(0.134007, 0.141391, 0.158621),
			["Risky"] = Color3.new(0.984314, 1, 0.152941),
			["StrokeColor"] = Color3.new(0.0769798, 0.0790924, 0.0896552),
			["SwitchColor"] = Color3.new(1, 1, 1),
			["Toggle"] = Color3.new(0, 0.324138, 0.10283)
		}
	end;
	
	Compkiller:RefreshCurrentColor()
end;

function Compkiller:RefreshCurrentColor()
	for i,v in next , Compkiller.Elements.Highlight do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.Highlight;
		end;
	end;

	for i,v in next , Compkiller.Elements do
		if v.Element and v.Property and v.Element:GetAttribute('Enabled') then
			v.Element[v.Property] = Compkiller.Colors.Highlight;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.Risky do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.Risky;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.BlockColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.BlockColor;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.BGDBColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.BGDBColor;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.StrokeColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.StrokeColor;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.SwitchColor do
		if v.Element and v.Property and v.Element[v.Property] ~= Compkiller.Colors.MouseEnter then
			v.Element[v.Property] = Compkiller.Colors.SwitchColor;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.BlockBackground do
		if v.Element and v.Property and v.Element[v.Property] then
			v.Element[v.Property] = Compkiller.Colors.BlockBackground;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.DropColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.DropColor;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.LineColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.LineColor;
		end;
	end;
	
	for i,v in next , Compkiller.Elements.HighStrokeColor do
		if v.Element and v.Property then
			v.Element[v.Property] = Compkiller.Colors.HighStrokeColor;
		end;
	end;
end;

function Compkiller:ChangeHighlightColor(NewColor: Color3)
	local H,S,V = NewColor:ToHSV();

	Compkiller.Colors.Highlight = NewColor;
	Compkiller.Colors.Toggle = Color3.fromHSV(H,S,V - 0.2);

	for i,v in next , Compkiller.Elements.Highlight do
		if v.Element and v.Property then
			v.Element[v.Property] = NewColor;
		end;
	end;

	for i,v in next , Compkiller.Elements do
		if v.Element and v.Property and v.Element:GetAttribute('Enabled') then
			v.Element[v.Property] = NewColor;
		end;
	end;
end;

function Compkiller.new(Config : Window)

	if not Config.Scale then
		if Compkiller:_IsMobile() then
			Config.Scale = Compkiller.Scale.Mobile;
		else
			Config.Scale = Compkiller.Scale.Window;
		end;
	end;

	Config = Compkiller.__CONFIG(Config , {
		Name = "COMPKILLER",
		Keybind = "Insert",
		Logo = Compkiller.Logo;
		Scale = Compkiller.Scale.Window,
		TextSize = 15
	});

	local TabHover = Compkiller.__SIGNAL(false);
	local WindowOpen = Compkiller.__SIGNAL(true);
	local WindowArgs = {
		SelectedTab = nil,
		Tabs = {},
		LastTab = nil,
		IsOpen = true,
		AlwayShowTab = false,
		THREADS = {}
	};

	WindowArgs.Username = LocalPlayer.Name;

	if Compkiller:_IsMobile() then
		WindowArgs.AlwayShowTab = true;
	end;

	local CompKiller = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TabFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local LineFrame1 = Instance.new("Frame")
	local CompLogo = Instance.new("ImageLabel")
	local WindowLabel = Instance.new("TextLabel")
	local TabButtons = Instance.new("Frame")
	local SelectionFrame = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local TabButtonScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Userinfo = Instance.new("Frame")
	local UserProfile = Instance.new("ImageLabel")
	local UICorner_4 = Instance.new("UICorner")
	local UserText = Instance.new("TextLabel")
	local ExpireText = Instance.new("TextLabel")
	local TabMainFrame = Instance.new("Frame")

	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		TabButtonScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
	end);

	CompKiller.Name = "u?name=compkiller_"..Compkiller:_RandomString();
	CompKiller.Parent = CoreGui;
	CompKiller.ResetOnSpawn = false
	CompKiller.IgnoreGuiInset = true;
	CompKiller.ZIndexBehavior = Enum.ZIndexBehavior.Global;

	table.insert(Compkiller.Windows , CompKiller);

	MainFrame.Active = true;
	MainFrame.Name = "MainFrame"
	MainFrame.Parent = CompKiller
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor

	table.insert(Compkiller.Elements.BGDBColor,{
		Element = MainFrame,
		Property = 'BackgroundColor3'
	});
	
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.fromScale(0.5,0.5);
	MainFrame.Size = Compkiller.Scale.Window
	MainFrame.ZIndex = 4

	if Compkiller:_IsMobile() then
		Compkiller:_AddDragBlacklist(MainFrame);
	end;
	

	MainFrame:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
		if MainFrame.BackgroundTransparency > 0.9 then
			MainFrame.Visible = false;
		else
			MainFrame.Visible = true;
		end;
	end)

	Compkiller:_Animation(MainFrame,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
		Size = Config.Scale
	});

	UICorner.Parent = MainFrame

	local TabFrameBaseTrans = 0.25;

	TabFrame.Active = true
	TabFrame.Name = "TabFrame"
	TabFrame.Parent = MainFrame
	TabFrame.AnchorPoint = Vector2.new(1, 0)
	TabFrame.BackgroundColor3 = Compkiller.Colors.BGDBColor
	
	table.insert(Compkiller.Elements.BGDBColor,{
		Element = TabFrame,
		Property = 'BackgroundColor3'
	});
	
	TabFrame.BackgroundTransparency = TabFrameBaseTrans
	TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabFrame.BorderSizePixel = 0
	TabFrame.ClipsDescendants = true
	TabFrame.Position = UDim2.new(0, 25, 0, 0)
	TabFrame.Size = UDim2.new(0, 85, 1, 0)

	UICorner_2.Parent = TabFrame

	LineFrame1.Name = "LineFrame1"
	LineFrame1.Parent = TabFrame
	LineFrame1.AnchorPoint = Vector2.new(1, 0)
	LineFrame1.BackgroundColor3 = Compkiller.Colors.BGDBColor
	
	table.insert(Compkiller.Elements.BGDBColor,{
		Element = LineFrame1,
		Property = 'BackgroundColor3'
	});
	
	LineFrame1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame1.BorderSizePixel = 0
	LineFrame1.Position = UDim2.new(1, -5, 0, 0)
	LineFrame1.Size = UDim2.new(0, 20, 1, 0)

	CompLogo.Name = "CompLogo"
	CompLogo.Parent = TabFrame
	CompLogo.BackgroundTransparency = 1.000
	CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CompLogo.BorderSizePixel = 0
	CompLogo.Position = UDim2.new(0, 9, 0, 7)
	CompLogo.Size = UDim2.new(0, 45, 0, 45)
	CompLogo.Image = Config.Logo

	WindowLabel.Name = "WindowLabel"
	WindowLabel.Parent = TabFrame
	WindowLabel.BackgroundTransparency = 1.000
	WindowLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowLabel.BorderSizePixel = 0
	WindowLabel.Position = UDim2.new(0, 60, 0, 17)
	WindowLabel.Size = UDim2.new(0, 200, 0, 25)
	WindowLabel.Font = Enum.Font.GothamBold
	WindowLabel.Text = Config.Name
	WindowLabel.TextColor3 = Compkiller.Colors.SwitchColor
	WindowLabel.TextSize = Config.TextSize
	WindowLabel.TextXAlignment = Enum.TextXAlignment.Left
	
	table.insert(Compkiller.Elements.SwitchColor , {
		Element = WindowLabel,
		Property = 'TextColor3'
	});
	
	TabButtons.Name = "TabButtons"
	TabButtons.Parent = TabFrame
	TabButtons.BackgroundTransparency = 1.000
	TabButtons.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtons.BorderSizePixel = 0
	TabButtons.Position = UDim2.new(0, 0, 0, 60)
	TabButtons.Size = UDim2.new(1, -25, 1, -125)

	SelectionFrame.Name = "SelectionFrame"
	SelectionFrame.Parent = TabButtons
	SelectionFrame.AnchorPoint = Vector2.new(1, 0)
	SelectionFrame.BackgroundColor3 = Compkiller.Colors.Highlight
	SelectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SelectionFrame.BorderSizePixel = 0
	SelectionFrame.Position = UDim2.new(1, 5, 0, 28)
	SelectionFrame.Size = UDim2.new(0, 8, 0, 32)

	table.insert(Compkiller.Elements.Highlight,{
		Element = SelectionFrame,
		Property = "BackgroundColor3"
	});

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = SelectionFrame

	TabButtonScrollingFrame.Name = "TabButtonScrollingFrame"
	TabButtonScrollingFrame.Parent = TabButtons
	TabButtonScrollingFrame.Active = true
	TabButtonScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	TabButtonScrollingFrame.BackgroundTransparency = 1.000
	TabButtonScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabButtonScrollingFrame.BorderSizePixel = 0
	TabButtonScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabButtonScrollingFrame.Size = UDim2.new(1, -5, 1, -5)
	TabButtonScrollingFrame.BottomImage = ""
	TabButtonScrollingFrame.ScrollBarThickness = 0
	TabButtonScrollingFrame.TopImage = ""

	UIListLayout.Parent = TabButtonScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)

	Userinfo.Name = "Userinfo"
	Userinfo.Parent = TabFrame
	Userinfo.AnchorPoint = Vector2.new(0, 1)
	Userinfo.BackgroundTransparency = 1.000
	Userinfo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Userinfo.BorderSizePixel = 0
	Userinfo.Position = UDim2.new(0, 0, 1, 0)
	Userinfo.Size = UDim2.new(1, -25, 0, 60)

	UserProfile.Name = "UserProfile"
	UserProfile.Parent = Userinfo
	UserProfile.BackgroundTransparency = 1.000
	UserProfile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserProfile.BorderSizePixel = 0
	UserProfile.Position = UDim2.new(0, 13, 0, 9)
	UserProfile.Size = UDim2.new(0, 35, 0, 35)
	UserProfile.ZIndex = 2
	UserProfile.Image = "rbxassetid://18518299306"

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = UserProfile

	UserText.Name = "UserText"
	UserText.Parent = Userinfo
	UserText.BackgroundTransparency = 1.000
	UserText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserText.BorderSizePixel = 0
	UserText.Position = UDim2.new(0, 55, 0, 8)
	UserText.Size = UDim2.new(0, 200, 0, 20)
	UserText.ZIndex = 2
	UserText.Font = Enum.Font.GothamMedium
	UserText.Text = "Username"
	UserText.TextColor3 = Compkiller.Colors.SwitchColor
	UserText.TextSize = 13.000
	UserText.TextXAlignment = Enum.TextXAlignment.Left
	
	table.insert(Compkiller.Elements.SwitchColor , {
		Element = UserText,
		Property = 'TextColor3'
	});
	
	ExpireText.Name = "ExpireText"
	ExpireText.Parent = Userinfo
	ExpireText.BackgroundTransparency = 1.000
	ExpireText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ExpireText.BorderSizePixel = 0
	ExpireText.Position = UDim2.new(0, 55, 0, 25)
	ExpireText.Size = UDim2.new(0, 200, 0, 20)
	ExpireText.ZIndex = 2
	ExpireText.Font = Enum.Font.GothamMedium
	ExpireText.Text = "0/0/0"
	ExpireText.TextColor3 = Compkiller.Colors.SwitchColor
	ExpireText.TextSize = 13.000
	ExpireText.TextTransparency = 0.500
	ExpireText.TextXAlignment = Enum.TextXAlignment.Left
	
	table.insert(Compkiller.Elements.SwitchColor , {
		Element = ExpireText,
		Property = 'TextColor3'
	});
	
	TabMainFrame.Name = "TabMainFrame"
	TabMainFrame.Parent = MainFrame
	TabMainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	TabMainFrame.BackgroundTransparency = 1.000
	TabMainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabMainFrame.BorderSizePixel = 0
	TabMainFrame.ClipsDescendants = true
	TabMainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabMainFrame.Size = UDim2.new(1, 0, 1, 0)
	TabMainFrame.ZIndex = 5

	WindowOpen:Connect(function(v)
		if v then
			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				Size = Config.Scale
			})

			Compkiller:_Animation(TabButtonScrollingFrame,TweenInfo.new(0.35),{
				Position = UDim2.new(0.5, 0, 0.5, 0)
			})

			Compkiller:_Animation(CompLogo,TweenInfo.new(0.2),{
				ImageTransparency = 0
			})

			Compkiller:_Animation(WindowLabel,TweenInfo.new(0.2),{
				TextTransparency = 0
			})

			Compkiller:_Animation(UserProfile,TweenInfo.new(0.2),{
				ImageTransparency = 0
			})

			Compkiller:_Animation(UserText,TweenInfo.new(0.2),{
				TextTransparency = 0
			})

			Compkiller:_Animation(ExpireText,TweenInfo.new(0.2),{
				TextTransparency = 0.5
			})

			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = 0
			})

			Compkiller:_Animation(LineFrame1,TweenInfo.new(0.3),{
				BackgroundTransparency = 0,
				Size = UDim2.new(0, 20, 1, 0)
			})

			Compkiller:_Animation(TabFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = TabFrameBaseTrans
			})
		else
			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				Size = UDim2.new(math.max(Config.Scale.X.Scale - 0.05,0) , Config.Scale.X.Offset - 10 , math.max(Config.Scale.Y.Scale - 0.05,0) , Config.Scale.Y.Offset - 10)
			})

			Compkiller:_Animation(TabButtonScrollingFrame,TweenInfo.new(0.35),{
				Position = UDim2.new(1.5, 100, 0.5, 0)
			})

			Compkiller:_Animation(LineFrame1,TweenInfo.new(0.1),{
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 1, 1, 0)
			})

			Compkiller:_Animation(CompLogo,TweenInfo.new(0.2),{
				ImageTransparency = 1
			})

			Compkiller:_Animation(WindowLabel,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(UserProfile,TweenInfo.new(0.2),{
				ImageTransparency = 1
			})

			Compkiller:_Animation(UserText,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(ExpireText,TweenInfo.new(0.2),{
				TextTransparency = 1
			})

			Compkiller:_Animation(MainFrame,TweenInfo.new(0.2),{
				BackgroundTransparency = 1
			})

			Compkiller:_Animation(TabFrame,TweenInfo.new(0.1),{
				BackgroundTransparency = 1
			})
		end;
	end);

	TabHover:Connect(function(value)
		local Style = TweenInfo.new(0.45,Enum.EasingStyle.Quint);

		if value then
			Compkiller:_Animation(TabFrame , Style , {
				Size = UDim2.new(0, 185,1, 0)
			});

			Compkiller:_Animation(WindowLabel , Style , {
				Position = UDim2.new(0, 60,0, 17),
				TextTransparency = 0
			});

			Compkiller:_Animation(UserText , Style , {
				Position = UDim2.new(0, 55,0, 8),
				TextTransparency = 0.1
			});

			Compkiller:_Animation(ExpireText , Style , {
				Position = UDim2.new(0, 55,0, 25),
				TextTransparency = 0.5
			});
		else
			Compkiller:_Animation(TabFrame , Style , {
				Size = UDim2.new(0, 85,1, 0)
			});

			Compkiller:_Animation(WindowLabel , Style , {
				Position = UDim2.new(0, 60 + 25,0, 17),
				TextTransparency = 1
			});

			Compkiller:_Animation(UserText , Style , {
				Position = UDim2.new(0, 55 + 25,0, 8),
				TextTransparency = 1
			});

			Compkiller:_Animation(ExpireText , Style , {
				Position = UDim2.new(0, 55 + 25,0, 25),
				TextTransparency = 1
			});
		end;
	end);

	function WindowArgs:DrawCategory(config : Category)
		config = config or {};
		config.Name = config.Name or "Category";

		local Category = Instance.new("Frame")
		local CategoryText = Instance.new("TextLabel")
		local Frame = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")

		Category.Name = "Category"
		Category.Parent = TabButtonScrollingFrame
		Category.BackgroundTransparency = 1.000
		Category.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Category.BorderSizePixel = 0
		Category.ClipsDescendants = true
		Category.Size = UDim2.new(1, -10, 0, 22)

		if Compkiller:_IsMobile() then
			Compkiller:_AddDragBlacklist(Category);
		end;

		CategoryText.Name = "CategoryText"
		CategoryText.Parent = Category
		CategoryText.BackgroundTransparency = 1.000
		CategoryText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CategoryText.BorderSizePixel = 0
		CategoryText.Position = UDim2.new(0, 5, 0, 8)
		CategoryText.Size = UDim2.new(1, 200, 0, 10)
		CategoryText.Font = Enum.Font.Gotham
		CategoryText.Text = config.Name
		CategoryText.TextColor3 = Compkiller.Colors.SwitchColor
		CategoryText.TextSize = 16.000
		CategoryText.TextTransparency = 0.500
		CategoryText.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = CategoryText,
			Property = 'TextColor3'
		});
		
		Frame.Parent = Category
		Frame.AnchorPoint = Vector2.new(0.5, 1)
		Frame.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame.BackgroundTransparency = 0.750
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 1, 0)
		Frame.Size = UDim2.new(1, 0, 0, 1)

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame,
			Property = "BackgroundColor3"
		});

		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.05, 0.21), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.96, 0.17), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Frame

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(CategoryText,Tween,{
					TextTransparency = 0.500
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0.750
				});
			else
				Compkiller:_Animation(CategoryText,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1
				});
			end;
		end);
	end;

	function WindowArgs:DrawContainerTab(TabConfig : ContainerTab)
		TabConfig = Compkiller.__CONFIG(TabConfig,{
			Name = "Tab",
			Icon = "eye",
		});

		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);
		local TabOpenSignal = Compkiller.__SIGNAL(false);

		local TabArgs = {
			__Current = nil,
			Tabs = {}
		};

		-- Creating Button --

		local TabButton = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local TabNameLabel = Instance.new("TextLabel")
		local Highlight = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		TabButton.Name = "TabButton"
		TabButton.Parent = TabButtonScrollingFrame
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.ClipsDescendants = true
		TabButton.Size = UDim2.new(1, -10, 0, 32)
		TabButton.ZIndex = 3

		local ImageIcon : table? = Compkiller:_GetIcon(TabConfig.Icon);

		Icon.Name = "Icon"
		Icon.Parent = TabButton
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Compkiller.Colors.Highlight
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 15, 0.5, 0)
		Icon.Size = UDim2.new(0, 22, 0, 22)
		Icon.ZIndex = 3
		Icon.ImageRectOffset = ImageIcon.ImageRectPosition
		Icon.ImageRectSize = ImageIcon.ImageRectSize
		Icon.Image = ImageIcon.Image
		Icon.ImageColor3 = Compkiller.Colors.Highlight

		table.insert(Compkiller.Elements.Highlight,{
			Element = Icon,
			Property = "ImageColor3"
		});

		TabNameLabel.Name = "TabNameLabel"
		TabNameLabel.Parent = TabButton
		TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabNameLabel.BackgroundTransparency = 1.000
		TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabNameLabel.BorderSizePixel = 0
		TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
		TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
		TabNameLabel.ZIndex = 3
		TabNameLabel.Font = Enum.Font.GothamMedium
		TabNameLabel.Text = TabConfig.Name;
		TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TabNameLabel.TextSize = 15.000
		TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TabNameLabel,
			Property = 'TextColor3'
		});
		
		Highlight.Name = "Highlight"
		Highlight.Parent = TabButton
		Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
		Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
		Highlight.BackgroundTransparency = 0.925
		Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Highlight.BorderSizePixel = 0
		Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
		Highlight.Size = UDim2.new(1, -17, 1, 0)
		Highlight.ZIndex = 2

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Highlight

		-- Creating Container --

		local ContainerTab = Instance.new("Frame")
		local MainFrame = Instance.new("Frame")
		local Top = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")

		ContainerTab.Name = "ContainerTab"
		ContainerTab.Parent = TabMainFrame
		ContainerTab.AnchorPoint = Vector2.new(0.5, 0.5)
		ContainerTab.BackgroundTransparency = 1.000
		ContainerTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ContainerTab.BorderSizePixel = 0
		ContainerTab.Position = UDim2.new(0.5, 0, 0.5, 0)
		ContainerTab.Size = UDim2.new(1, -15, 1, -15)
		ContainerTab.ZIndex = 6

		MainFrame.Name = "MainFrame"
		MainFrame.Parent = ContainerTab
		MainFrame.AnchorPoint = Vector2.new(0.5, 1)
		MainFrame.BackgroundTransparency = 1.000
		MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainFrame.BorderSizePixel = 0
		MainFrame.Position = UDim2.new(0.5, 0, 1, -5)
		MainFrame.Size = UDim2.new(1, 0, 1, -35)
		MainFrame.ZIndex = 6
		MainFrame.ClipsDescendants = true

		Top.Name = "Top"
		Top.Parent = ContainerTab
		Top.BackgroundTransparency = 1.000
		Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Top.BorderSizePixel = 0
		Top.Size = UDim2.new(1, 0, 0, 25)
		Top.ZIndex = 7

		UIListLayout.Parent = Top
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 10)

		-- Functions --
		Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
			if Highlight.BackgroundTransparency <= 0.99 then
				ContainerTab.Visible = true;
			else
				ContainerTab.Visible = false;
			end;
		end);

		local TabOpen = function(bool)
			if bool then
				WindowArgs.SelectedTab = TabButton;

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0,
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 0.925
				});

				for i,v in next , TabArgs.Tabs do
					if v.Root == TabArgs.__Current.Root then
						v.Remote:Fire(true);
					end;
				end;
			else
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 1
				});

				for i,v in next , TabArgs.Tabs do
					v.Remote:Fire(false);
				end;
			end;
		end;

		if not WindowArgs.Tabs[1] then
			TabOpenSignal:Fire(true);
			TabOpen(true);
		else
			TabOpen(false);
		end;

		table.insert(WindowArgs.Tabs , {
			Root = TabButton,
			Remote = TabOpenSignal
		});

		Compkiller:_Hover(TabButton,function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.1
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.1
				});
			end;
		end , function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});
			end;
		end)

		TabOpenSignal:Connect(TabOpen);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 15, 0.5, 0),
					Size = UDim2.new(0, 22, 0, 22),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 43, 0.5, 0)
				});

				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 4)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -17, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			else
				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 10)
				});

				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 12, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 80, 0.5, 0)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -10,1, 5),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			end;
		end);

		Compkiller:_Input(TabButton,function()
			for i,v in next, WindowArgs.Tabs do
				if v.Root == TabButton then
					v.Remote:Fire(true);
				else
					v.Remote:Fire(false);
				end;
			end;
		end);

		function TabArgs:DrawTab(TabConfig : TabConfig) -- Internal Tab
			TabConfig = Compkiller.__CONFIG(TabConfig,{
				Name = "Tab",
				Type = "Double",
				EnableScrolling = false,
			});

			local InternalSignal = Compkiller.__SIGNAL(false);
			local Frame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Highlight = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")

			Frame.Parent = Top
			Frame.BackgroundColor3 = Compkiller.Colors.BlockColor
			
			table.insert(Compkiller.Elements.BlockColor , {
				Element = Frame,
				Property = "BackgroundColor3"
			});
			
			Frame.BackgroundTransparency = 1.000
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.ClipsDescendants = true
			Frame.Size = UDim2.new(0, 75, 0, 26)
			Frame.ZIndex = 10

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Frame

			UIStroke.Transparency = 1.000
			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Frame
			
			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});
			
			Highlight.Name = "Highlight"
			Highlight.Parent = Frame
			Highlight.AnchorPoint = Vector2.new(1, 0.5)
			Highlight.BackgroundColor3 = Compkiller.Colors.Highlight
			Highlight.BackgroundTransparency = 1.000
			Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Highlight.BorderSizePixel = 0
			Highlight.Position = UDim2.new(0, 3, 0.5, 0)
			Highlight.Size = UDim2.new(0, 5, 0, 10)
			Highlight.ZIndex = 11

			table.insert(Compkiller.Elements.Highlight,{
				Element = Highlight,
				Property = "BackgroundColor3"
			});

			UICorner_2.CornerRadius = UDim.new(1, 0)
			UICorner_2.Parent = Highlight

			TextLabel.Parent = Frame
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0, 10, 0.5, 0)
			TextLabel.Size = UDim2.new(0, 200, 0, 20)
			TextLabel.ZIndex = 12
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.Text = TabConfig.Name
			TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel.TextSize = 13.000
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TextLabel,
				Property = 'TextColor3'
			});
			
			local UpdateScale = function()
				local scale = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));

				Frame.Size = UDim2.new(0, scale.X + 19, 0, 26)
			end;

			UpdateScale()

			local ToggleUI = function(bool)
				UpdateScale();

				if bool then

					Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
						BackgroundTransparency = 0,
						Size = UDim2.new(0, 5, 0, 10)
					})

					Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
						BackgroundTransparency = 0
					})

					Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
						Transparency = 0
					})

					Compkiller:_Animation(TextLabel,TweenInfo.new(0.2),{
						TextTransparency = 0
					})
				else

					Compkiller:_Animation(Highlight,TweenInfo.new(0.2),{
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 5, 0, 2)
					})

					Compkiller:_Animation(Frame,TweenInfo.new(0.2),{
						BackgroundTransparency = 1
					})

					Compkiller:_Animation(UIStroke,TweenInfo.new(0.2),{
						Transparency = 1
					})

					Compkiller:_Animation(TextLabel,TweenInfo.new(0.2),{
						TextTransparency = 0.5
					})
				end;
			end;


			local Id = {
				Root = Frame,
				Remote = InternalSignal
			};

			InternalSignal:Connect(ToggleUI)


			if not TabArgs.Tabs[1] then
				TabArgs.__Current = Id;

				InternalSignal:Fire(true)
			end;

			table.insert(TabArgs.Tabs,Id)

			Compkiller:_Input(Frame,function()
				for i,v in next , TabArgs.Tabs do
					if v.Root == Frame then
						TabArgs.__Current = v;

						v.Remote:Fire(true);
					else
						v.Remote:Fire(false);
					end;
				end;
			end);

			return WindowArgs:DrawTab(TabConfig , {
				ID = Id,
				Highlight = Highlight,
				Signal = InternalSignal,
				Parent = MainFrame
			});
		end;

		return TabArgs;
	end;

	function WindowArgs:AddUnbind(UilistLayout: UIListLayout , Scrolling)

		local Parent: ScrollingFrame = UilistLayout.Parent;

		Parent = Parent or Scrolling;

		local Detection = function()
			local Target = (UilistLayout.AbsoluteContentSize.Y);

			for i,v in next , Parent:GetChildren() do task.wait(0.1)
				local UIList = v:FindFirstChildWhichIsA('UIListLayout');
				if v:IsA('Frame') and UIList then
					if (UIList.AbsoluteContentSize.Y >= Target) or (v.AbsoluteSize.Y >= Target) or (UilistLayout.AbsoluteContentSize.Y > Parent.AbsoluteSize.Y) then
						UilistLayout.VerticalFlex = Enum.UIFlexAlignment.None;
						Parent.ScrollingEnabled = true;
					else
						Parent.ScrollingEnabled = false;
						UilistLayout.VerticalFlex = Enum.UIFlexAlignment.Fill;
					end;
				end
			end;
		end;

		local Executable = function()
			while true do task.wait(0.15);
				pcall(Detection);
			end;
		end;

		table.insert(WindowArgs.THREADS,task.spawn(Executable))
	end;

	function WindowArgs:DrawConfig(Configuration : TabConfigManager , Internal)
		Configuration = Compkiller.__CONFIG(Configuration,{
			Name = "Config",
			Icon = "folder",
			Config = nil
		});

		local TabOpenSignal = Compkiller.__SIGNAL(false);
		local TabArgs = {};

		-- Button --
		local TabButton = Instance.new("Frame")
		local Icon = Instance.new("ImageLabel")
		local TabNameLabel = Instance.new("TextLabel")
		local Highlight = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")

		TabButton.Name = "TabButton"
		TabButton.Parent = TabButtonScrollingFrame
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.ClipsDescendants = true
		TabButton.Size = UDim2.new(1, -10, 0, 32)
		TabButton.ZIndex = 3

		local ImageIcon : table? = Compkiller:_GetIcon(Configuration.Icon);

		Icon.Name = "Icon"
		Icon.Parent = TabButton
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Compkiller.Colors.Highlight
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 15, 0.5, 0)
		Icon.Size = UDim2.new(0, 22, 0, 22)
		Icon.ZIndex = 3
		Icon.ImageRectOffset = ImageIcon.ImageRectPosition
		Icon.ImageRectSize = ImageIcon.ImageRectSize
		Icon.Image = ImageIcon.Image
		Icon.ImageColor3 = Compkiller.Colors.Highlight

		table.insert(Compkiller.Elements.Highlight,{
			Element = Icon,
			Property = "ImageColor3"
		});

		TabNameLabel.Name = "TabNameLabel"
		TabNameLabel.Parent = TabButton
		TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
		TabNameLabel.BackgroundTransparency = 1.000
		TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabNameLabel.BorderSizePixel = 0
		TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
		TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
		TabNameLabel.ZIndex = 3
		TabNameLabel.Font = Enum.Font.GothamMedium
		TabNameLabel.Text = Configuration.Name;
		TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TabNameLabel.TextSize = 15.000
		TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TabNameLabel,
			Property = 'TextColor3'
		});
		
		Highlight.Name = "Highlight"
		Highlight.Parent = TabButton
		Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
		Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
		Highlight.BackgroundTransparency = 0.925
		Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Highlight.BorderSizePixel = 0
		Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
		Highlight.Size = UDim2.new(1, -17, 1, 0)
		Highlight.ZIndex = 2

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Highlight

		local TabConfig = Instance.new("Frame")
		local ConfigList = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Header = Instance.new("Frame")
		local SectionText = Instance.new("TextLabel")
		local SectionClose = Instance.new("ImageLabel")
		local ScrollingFrame = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local Space = Instance.new("Frame")
		local AddConfig = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local Header_2 = Instance.new("Frame")
		local SectionText_2 = Instance.new("TextLabel")
		local SectionClose_2 = Instance.new("ImageLabel")
		local Frame = Instance.new("Frame")
		local UIStroke_3 = Instance.new("UIStroke")
		local UICorner_3 = Instance.new("UICorner")
		local TextBox = Instance.new("TextBox")
		local Button = Instance.new("Frame")
		local BlockLine = Instance.new("Frame")
		local Frame_2 = Instance.new("Frame")
		local UIStroke_4 = Instance.new("UIStroke")
		local UICorner_4 = Instance.new("UICorner")
		local TextLabel = Instance.new("TextLabel")

		TabConfig.Name = "TabConfig"
		TabConfig.Parent = TabMainFrame
		TabConfig.AnchorPoint = Vector2.new(0.5, 0.5)
		TabConfig.BackgroundTransparency = 1.000
		TabConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabConfig.BorderSizePixel = 0
		TabConfig.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabConfig.Size = UDim2.new(1, 0, 1, 0)
		TabConfig.ZIndex = 6

		ConfigList.Name = "ConfigList"
		ConfigList.Parent = TabConfig
		ConfigList.AnchorPoint = Vector2.new(0.5, 0)
		ConfigList.BackgroundColor3 = Compkiller.Colors.BlockColor
		
		table.insert(Compkiller.Elements.BlockColor , {
			Element = ConfigList,
			Property = "BackgroundColor3"
		});
		
		ConfigList.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ConfigList.BorderSizePixel = 0
		ConfigList.Position = UDim2.new(0.5, 0, 0, 5)
		ConfigList.Size = UDim2.new(1, -10, 1, -110)
		ConfigList.ZIndex = 9

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = ConfigList

		UIStroke.Color = Compkiller.Colors.StrokeColor
		UIStroke.Parent = ConfigList
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke,
			Property = "Color"
		});

		Header.Name = "Header"
		Header.Parent = ConfigList
		Header.BackgroundTransparency = 1.000
		Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header.BorderSizePixel = 0
		Header.Size = UDim2.new(1, 0, 0, 35)
		Header.ZIndex = 9

		SectionText.Name = "SectionText"
		SectionText.Parent = Header
		SectionText.AnchorPoint = Vector2.new(0, 0.5)
		SectionText.BackgroundTransparency = 1.000
		SectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionText.BorderSizePixel = 0
		SectionText.Position = UDim2.new(0, 12, 0.5, 0)
		SectionText.Size = UDim2.new(0, 200, 0, 25)
		SectionText.ZIndex = 10
		SectionText.Font = Enum.Font.GothamMedium
		SectionText.Text = "Config List"
		SectionText.TextColor3 = Compkiller.Colors.SwitchColor
		SectionText.TextSize = 14.000
		SectionText.TextTransparency = 0.500
		SectionText.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = SectionText,
			Property = 'TextColor3'
		});
		
		SectionClose.Name = "SectionClose"
		SectionClose.Parent = Header
		SectionClose.AnchorPoint = Vector2.new(1, 0.5)
		SectionClose.BackgroundTransparency = 1.000
		SectionClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionClose.BorderSizePixel = 0
		SectionClose.Position = UDim2.new(1, -12, 0.5, 0)
		SectionClose.Size = UDim2.new(0, 17, 0, 17)
		SectionClose.ZIndex = 10
		SectionClose.Image = "rbxassetid://10709790948"
		SectionClose.ImageTransparency = 0.500

		ScrollingFrame.Parent = ConfigList
		ScrollingFrame.Active = true
		ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
		ScrollingFrame.BackgroundTransparency = 1.000
		ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Position = UDim2.new(0.5, 0, 0, 35)
		ScrollingFrame.Size = UDim2.new(1, -10, 1, -45)
		ScrollingFrame.ZIndex = 12
		ScrollingFrame.ScrollBarThickness = 0

		UIListLayout.Parent = ScrollingFrame
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 7)

		Space.Name = "Space"
		Space.Parent = ScrollingFrame
		Space.BackgroundTransparency = 1.000
		Space.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Space.BorderSizePixel = 0

		AddConfig.Name = "AddConfig"
		AddConfig.Parent = TabConfig
		AddConfig.AnchorPoint = Vector2.new(0.5, 1)
		AddConfig.BackgroundColor3 = Compkiller.Colors.BlockColor
		
		table.insert(Compkiller.Elements.BlockColor , {
			Element = AddConfig,
			Property = "BackgroundColor3"
		});
		
		AddConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		AddConfig.BorderSizePixel = 0
		AddConfig.Position = UDim2.new(0.5, 0, 1, -5)
		AddConfig.Size = UDim2.new(1, -10, 0, 95)
		AddConfig.ZIndex = 9

		UICorner_2.CornerRadius = UDim.new(0, 6)
		UICorner_2.Parent = AddConfig

		UIStroke_2.Color = Compkiller.Colors.StrokeColor
		UIStroke_2.Parent = AddConfig
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_2,
			Property = "Color"
		});

		Header_2.Name = "Header"
		Header_2.Parent = AddConfig
		Header_2.BackgroundTransparency = 1.000
		Header_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Header_2.BorderSizePixel = 0
		Header_2.Size = UDim2.new(1, 0, 0, 35)
		Header_2.ZIndex = 9

		SectionText_2.Name = "SectionText"
		SectionText_2.Parent = Header_2
		SectionText_2.AnchorPoint = Vector2.new(0, 0.5)
		SectionText_2.BackgroundTransparency = 1.000
		SectionText_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionText_2.BorderSizePixel = 0
		SectionText_2.Position = UDim2.new(0, 12, 0.5, 0)
		SectionText_2.Size = UDim2.new(0, 200, 0, 25)
		SectionText_2.ZIndex = 10
		SectionText_2.Font = Enum.Font.GothamMedium
		SectionText_2.Text = "Add Config"
		SectionText_2.TextColor3 = Compkiller.Colors.SwitchColor
		SectionText_2.TextSize = 14.000
		SectionText_2.TextTransparency = 0.500
		SectionText_2.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = SectionText_2,
			Property = 'TextColor3'
		});
		
		SectionClose_2.Name = "SectionClose"
		SectionClose_2.Parent = Header_2
		SectionClose_2.AnchorPoint = Vector2.new(1, 0.5)
		SectionClose_2.BackgroundTransparency = 1.000
		SectionClose_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SectionClose_2.BorderSizePixel = 0
		SectionClose_2.Position = UDim2.new(1, -12, 0.5, 0)
		SectionClose_2.Size = UDim2.new(0, 17, 0, 17)
		SectionClose_2.ZIndex = 10
		SectionClose_2.Image = "rbxassetid://10709790948"
		SectionClose_2.ImageTransparency = 0.500

		Frame.Parent = AddConfig
		Frame.AnchorPoint = Vector2.new(0.5, 0)
		Frame.BackgroundColor3 = Compkiller.Colors.BlockColor
		
		table.insert(Compkiller.Elements.BlockColor , {
			Element = Frame,
			Property = "BackgroundColor3"
		});
		
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.5, 0, 0, 35)
		Frame.Size = UDim2.new(1, -20, 0, 20)
		Frame.ZIndex = 15

		UIStroke_3.Color = Compkiller.Colors.StrokeColor
		UIStroke_3.Parent = Frame
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_3,
			Property = "Color"
		});
		
		UICorner_3.CornerRadius = UDim.new(0, 4)
		UICorner_3.Parent = Frame

		TextBox.Parent = Frame
		TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBox.Size = UDim2.new(1, -15, 1, -2)
		TextBox.ZIndex = 15
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
		TextBox.PlaceholderText = "Config Name..."
		TextBox.Text = ""
		TextBox.TextColor3 = Compkiller.Colors.SwitchColor
		TextBox.TextSize = 12.000
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextBox,
			Property = 'TextColor3'
		});
		
		Button.Name = "Button"
		Button.Parent = AddConfig
		Button.AnchorPoint = Vector2.new(0.5, 1)
		Button.BackgroundColor3 = Compkiller.Colors.SwitchColor
		Button.BackgroundTransparency = 1.000
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(0.5, 0, 1, -10)
		Button.Size = UDim2.new(1, -7, 0, 25)
		Button.ZIndex = 10

		BlockLine.Name = "BlockLine"
		BlockLine.Parent = AddConfig
		BlockLine.AnchorPoint = Vector2.new(0.5, 1)
		BlockLine.BackgroundColor3 = Compkiller.Colors.LineColor
		BlockLine.BackgroundTransparency = 0.500
		BlockLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlockLine.BorderSizePixel = 0
		BlockLine.Position = UDim2.new(0.5, 0, 0.5, 12)
		BlockLine.Size = UDim2.new(1, -26, 0, 1)
		BlockLine.ZIndex = 12
		
		table.insert(Compkiller.Elements.LineColor,{
			Element = BlockLine,
			Property = "BackgroundColor3"
		});

		Frame_2.Parent = Button
		Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame_2.BackgroundColor3 = Compkiller.Colors.Highlight
		Frame_2.BackgroundTransparency = 0.100
		Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame_2.BorderSizePixel = 0
		Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame_2.Size = UDim2.new(1, -15, 1, -5)
		Frame_2.ZIndex = 9

		table.insert(Compkiller.Elements.Highlight,{
			Element = Frame_2,
			Property = "BackgroundColor3"
		});

		UIStroke_4.Color = Compkiller.Colors.StrokeColor
		UIStroke_4.Parent = Frame_2
		
		table.insert(Compkiller.Elements.StrokeColor,{
			Element = UIStroke_4,
			Property = "Color"
		});
		
		UICorner_4.CornerRadius = UDim.new(0, 3)
		UICorner_4.Parent = Frame_2

		TextLabel.Parent = Frame_2
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.ZIndex = 10
		TextLabel.Font = Enum.Font.GothamMedium
		TextLabel.Text = "Add Config"
		TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
		TextLabel.TextSize = 12.000
		TextLabel.TextStrokeTransparency = 0.900
		
		table.insert(Compkiller.Elements.SwitchColor , {
			Element = TextLabel,
			Property = 'TextColor3'
		});
		
		local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

		Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
			if Highlight.BackgroundTransparency <= 0.99 then
				TabConfig.Visible = true;
			else
				TabConfig.Visible = false;
			end;
		end)

		local TabOpen = function(bool)
			if bool then

				WindowArgs.SelectedTab = TabButton;

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0,
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 0.925
				});

				--

				Compkiller:_Animation(ConfigList,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(AddConfig,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(UIStroke_4,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke_3,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke_2,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 0,
				});

				Compkiller:_Animation(SectionText,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(TextLabel,Tween,{
					TextTransparency = 0,
					TextStrokeTransparency = 0.9
				});

				Compkiller:_Animation(Frame_2,Tween,{
					BackgroundTransparency = 0.1,
				});

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 0.5,
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 0,
				});

				Compkiller:_Animation(SectionText_2,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(TextBox,Tween,{
					TextTransparency = 0
				});

				Compkiller:_Animation(SectionClose,Tween,{
					ImageTransparency = 0.5,
				});

				Compkiller:_Animation(SectionClose_2,Tween,{
					ImageTransparency = 0.5,
				});
			else

				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});

				Compkiller:_Animation(Highlight,Tween,{
					BackgroundTransparency = 1
				});

				Compkiller:_Animation(ConfigList,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(AddConfig,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(UIStroke_4,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke_3,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke_2,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(UIStroke,Tween,{
					Transparency = 1,
				});

				Compkiller:_Animation(SectionText,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(TextLabel,Tween,{
					TextTransparency = 1,
					TextStrokeTransparency = 1
				});

				Compkiller:_Animation(Frame_2,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(BlockLine,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(Frame,Tween,{
					BackgroundTransparency = 1,
				});

				Compkiller:_Animation(SectionText_2,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(TextBox,Tween,{
					TextTransparency = 1
				});

				Compkiller:_Animation(SectionClose,Tween,{
					ImageTransparency = 1,
				});

				Compkiller:_Animation(SectionClose_2,Tween,{
					ImageTransparency = 1,
				});
			end;
		end;

		if not WindowArgs.Tabs[1] then
			TabOpenSignal:Fire(true);
			TabOpen(true);
		else
			TabOpen(false);
		end;

		table.insert(WindowArgs.Tabs , {
			Root = TabButton,
			Remote = TabOpenSignal
		});

		Compkiller:_Hover(TabButton,function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.1
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.1
				});
			end;
		end , function()
			if WindowArgs.SelectedTab ~= TabButton then
				Compkiller:_Animation(Icon,Tween,{
					ImageTransparency = 0.5
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					TextTransparency = 0.5
				});
			end;
		end)

		TabOpenSignal:Connect(TabOpen);

		TabHover:Connect(function(bool)
			if bool then
				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 15, 0.5, 0),
					Size = UDim2.new(0, 22, 0, 22),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 43, 0.5, 0)
				});

				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 4)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -17, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			else
				Compkiller:_Animation(UICorner,Tween,{
					CornerRadius = UDim.new(0, 10)
				});

				Compkiller:_Animation(TabButton,Tween,{
					Size = UDim2.new(1, -10, 0, 32)
				});

				Compkiller:_Animation(Icon,Tween,{
					Position = UDim2.new(0, 12, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
				});

				Compkiller:_Animation(TabNameLabel,Tween,{
					Size = UDim2.new(0, 200, 0, 25),
					Position = UDim2.new(0, 80, 0.5, 0)
				});

				Compkiller:_Animation(Highlight,Tween,{
					Size = UDim2.new(1, -10,1, 5),
					Position = UDim2.new(0.5, 0, 0.5, 0)
				});
			end;
		end);

		Compkiller:_Input(TabButton,function()
			for i,v in next, WindowArgs.Tabs do
				if v.Root == TabButton then
					v.Remote:Fire(true);
				else
					v.Remote:Fire(false);
				end;
			end;
		end);

		function TabArgs:_DrawConfig()
			local ConfigButton = {};

			local ConfigBlock = Instance.new("Frame")
			local ConfigText = Instance.new("TextLabel")
			local LinkValues = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local SaveButton = Instance.new("Frame")
			local Frame = Instance.new("Frame")
			local UIStroke = Instance.new("UIStroke")
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local Icon = Instance.new("ImageLabel")
			local LoadButton = Instance.new("Frame")
			local Frame_2 = Instance.new("Frame")
			local UIStroke_2 = Instance.new("UIStroke")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel_2 = Instance.new("TextLabel")
			local Icon_2 = Instance.new("ImageLabel")
			local UIStroke_3 = Instance.new("UIStroke")
			local UICorner_3 = Instance.new("UICorner")
			local AuthorText = Instance.new("TextLabel")
			local DelButton = Instance.new("ImageButton")
			local UICorner = Instance.new("UICorner")
			local UIGradient = Instance.new("UIGradient")

			DelButton.Name = "DelButton"
			DelButton.Parent = LinkValues
			DelButton.BackgroundTransparency = 1.000
			DelButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DelButton.BorderSizePixel = 0
			DelButton.LayoutOrder = -9999
			DelButton.Size = UDim2.new(0, 35, 0, 15)
			DelButton.ZIndex = 14
			DelButton.Image = "rbxassetid://10747362393"
			DelButton.ImageColor3 = Color3.fromRGB(255, 107, 107)
			DelButton.ImageTransparency = 0.500
			DelButton.ScaleType = Enum.ScaleType.Fit

			UICorner.CornerRadius = UDim.new(1, 0)
			UICorner.Parent = DelButton
			ConfigBlock.Name = "ConfigBlock"
			ConfigBlock.Parent = ScrollingFrame
			ConfigBlock.BackgroundColor3 = Color3.fromRGB(33, 34, 40)
			ConfigBlock.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ConfigBlock.BorderSizePixel = 0
			ConfigBlock.BackgroundTransparency = 1
			ConfigBlock.Size = UDim2.new(1, -1, 0, 40)
			ConfigBlock.ZIndex = 10

			ConfigText.Name = "ConfigText"
			ConfigText.Parent = ConfigBlock
			ConfigText.AnchorPoint = Vector2.new(0, 0.5)
			ConfigText.BackgroundTransparency = 1.000
			ConfigText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ConfigText.BorderSizePixel = 0
			ConfigText.Position = UDim2.new(0, 12, 0.5, 15)
			ConfigText.Size = UDim2.new(1, -20, 0, 25)
			ConfigText.ZIndex = 10
			ConfigText.Font = Enum.Font.GothamMedium
			ConfigText.RichText = true;
			ConfigText.Text = "Config"
			ConfigText.TextColor3 = Compkiller.Colors.SwitchColor
			ConfigText.TextSize = 13.000
			ConfigText.TextTransparency = 1
			ConfigText.TextXAlignment = Enum.TextXAlignment.Left
			
			table.insert(Compkiller.Elements.SwitchColor , {
				Element = ConfigText,
				Property = 'TextColor3'
			});
			
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.29, 0.00), NumberSequenceKeypoint.new(0.33, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = ConfigText

			LinkValues.Name = "LinkValues"
			LinkValues.Parent = ConfigBlock
			LinkValues.AnchorPoint = Vector2.new(1, 0.540000021)
			LinkValues.BackgroundTransparency = 1.000
			LinkValues.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LinkValues.BorderSizePixel = 0
			LinkValues.Position = UDim2.new(1, -12, 0.5, 15)
			LinkValues.Size = UDim2.new(1, 0, 0, 18)
			LinkValues.ZIndex = 11

			UIListLayout.Parent = LinkValues
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout.Padding = UDim.new(0, -10)

			SaveButton.Name = "SaveButton"
			SaveButton.Parent = LinkValues
			SaveButton.BackgroundTransparency = 1.000
			SaveButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SaveButton.BorderSizePixel = 0
			SaveButton.Size = UDim2.new(0, 77, 0, 30)
			SaveButton.ZIndex = 14

			Frame.Parent = SaveButton
			Frame.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame.BackgroundTransparency = 1
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame.Size = UDim2.new(1, -15, 1, -5)
			Frame.ZIndex = 14

			table.insert(Compkiller.Elements.Highlight,{
				Element = Frame,
				Property = "BackgroundColor3"
			});

			UIStroke.Transparency = 1
			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Frame
			
			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});
			
			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Frame

			TextLabel.Parent = Frame
			TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0.5, 27, 0.5, 0)
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.ZIndex = 14
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.Text = "Save"
			TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel.TextSize = 12.000
			TextLabel.TextStrokeTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.TextTransparency = 1
			
			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TextLabel,
				Property = 'TextColor3'
			});
			
			Icon.Name = "Icon"
			Icon.Parent = Frame
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 5, 0.5, 0)
			Icon.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon.ZIndex = 15
			Icon.Image = "rbxassetid://10734941499"
			Icon.ImageTransparency = 1;

			LoadButton.Name = "LoadButton"
			LoadButton.Parent = LinkValues
			LoadButton.BackgroundTransparency = 1.000
			LoadButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LoadButton.BorderSizePixel = 0
			LoadButton.Size = UDim2.new(0, 77, 0, 30)
			LoadButton.ZIndex = 14

			Frame_2.Parent = LoadButton
			Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame_2.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame_2.BackgroundTransparency = 1
			Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame_2.Size = UDim2.new(1, -15, 1, -5)
			Frame_2.ZIndex = 14

			table.insert(Compkiller.Elements.Highlight,{
				Element = Frame_2,
				Property = "BackgroundColor3"
			});

			UIStroke_2.Transparency = 1
			UIStroke_2.Color = Compkiller.Colors.StrokeColor
			UIStroke_2.Parent = Frame_2
			
			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke_2,
				Property = "Color"
			});

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = Frame_2

			TextLabel_2.Parent = Frame_2
			TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel_2.BackgroundTransparency = 1.000
			TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_2.BorderSizePixel = 0
			TextLabel_2.Position = UDim2.new(0.5, 27, 0.5, 0)
			TextLabel_2.Size = UDim2.new(1, 0, 1, 0)
			TextLabel_2.ZIndex = 14
			TextLabel_2.Font = Enum.Font.GothamMedium
			TextLabel_2.Text = "Load"
			TextLabel_2.TextColor3 = Compkiller.Colors.SwitchColor
			TextLabel_2.TextSize = 12.000
			TextLabel_2.TextStrokeTransparency = 1
			TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_2.TextTransparency = 1
			
			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TextLabel_2,
				Property = 'TextColor3'
			});
			
			Icon_2.Name = "Icon"
			Icon_2.Parent = Frame_2
			Icon_2.AnchorPoint = Vector2.new(0, 0.5)
			Icon_2.BackgroundTransparency = 1.000
			Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_2.BorderSizePixel = 0
			Icon_2.Position = UDim2.new(0, 5, 0.5, 0)
			Icon_2.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			Icon_2.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Icon_2.ZIndex = 15
			Icon_2.Image = "rbxassetid://10723344270"
			Icon_2.ImageTransparency = 1
			UIStroke_3.Transparency = 1

			UIStroke_3.Color = Compkiller.Colors.StrokeColor
			UIStroke_3.Parent = ConfigBlock
			
			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke_3,
				Property = "Color"
			});

			UICorner_3.CornerRadius = UDim.new(0, 6)
			UICorner_3.Parent = ConfigBlock

			AuthorText.Name = "AuthorText"
			AuthorText.Parent = ConfigBlock
			AuthorText.AnchorPoint = Vector2.new(0, 0.5)
			AuthorText.BackgroundTransparency = 1.000
			AuthorText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			AuthorText.BorderSizePixel = 0
			AuthorText.Position = UDim2.new(0.5, -65, 0.5, 15)
			AuthorText.Size = UDim2.new(1, -20, 0, 25)
			AuthorText.ZIndex = 10
			AuthorText.Font = Enum.Font.GothamMedium
			AuthorText.RichText = true;
			AuthorText.Text = "Author: <font color=\"rgb(17, 238, 253)\">NoFi</font>"
			AuthorText.TextColor3 = Compkiller.Colors.SwitchColor
			AuthorText.TextSize = 13.000
			AuthorText.TextTransparency = 1
			AuthorText.TextXAlignment = Enum.TextXAlignment.Left
			
			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TabNameLabel,
				Property = 'TextColor3'
			});
			
			function ConfigButton:SetInfo(Author , ConfigName)
				local R,G,B = tostring(math.floor(Compkiller.Colors.Highlight.R * 255)) , tostring(math.floor(Compkiller.Colors.Highlight.G * 255)) , tostring(math.floor(Compkiller.Colors.Highlight.B * 255));

				AuthorText.Text = string.format("Author: <font color=\"rgb(%s, %s, %s)\">%s</font>" ,R,G,B , tostring(Author));
				ConfigText.Text = ConfigName;

				if ConfigBlock.BackgroundTransparency >= 0.7 then
					ConfigButton:Update();
				end;
			end;

			function ConfigButton:Toggle(v)
				if v then
					Compkiller:_Animation(ConfigBlock,Tween,{
						BackgroundTransparency = 0
					});

					Compkiller:_Animation(LinkValues,Tween,{
						Position = UDim2.new(1, -12, 0.5, 0)
					});

					Compkiller:_Animation(ConfigText,Tween,{
						TextTransparency = 0.3,
						Position = UDim2.new(0, 12, 0.5, 0)
					});

					Compkiller:_Animation(Frame,Tween,{
						BackgroundTransparency = 0.100
					});

					Compkiller:_Animation(UIStroke,Tween,{
						Transparency = 0
					});

					Compkiller:_Animation(AuthorText,Tween,{
						TextTransparency = 0.5,
						Position = UDim2.new(0,AuthorText:GetAttribute('SPC'), 0.5, 0)
					});

					Compkiller:_Animation(Icon_2,Tween,{
						ImageTransparency = 0
					});

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0
					});

					Compkiller:_Animation(Frame_2,Tween,{
						BackgroundTransparency = 0.100
					});

					Compkiller:_Animation(UIStroke_2,Tween,{
						Transparency = 0
					});

					Compkiller:_Animation(TextLabel,Tween,{
						TextStrokeTransparency = 0.900,
						TextTransparency = 0
					});

					Compkiller:_Animation(TextLabel_2,Tween,{
						TextStrokeTransparency = 0.900,
						TextTransparency = 0
					});
				else
					Compkiller:_Animation(AuthorText,Tween,{
						TextTransparency = 1,
						Position = UDim2.new(0.5, -65, 0.5, 15)
					});

					Compkiller:_Animation(Icon_2,Tween,{
						ImageTransparency = 1
					});

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 1
					});

					Compkiller:_Animation(LinkValues,Tween,{
						Position = UDim2.new(1, -12, 0.5, 15)
					});

					Compkiller:_Animation(ConfigBlock,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(ConfigText,Tween,{
						TextTransparency = 1,
						Position = UDim2.new(0, 12, 0.5, 15)
					});

					Compkiller:_Animation(Frame,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(UIStroke,Tween,{
						Transparency = 1
					});

					Compkiller:_Animation(Frame_2,Tween,{
						BackgroundTransparency = 1
					});

					Compkiller:_Animation(UIStroke_2,Tween,{
						Transparency = 1
					});

					Compkiller:_Animation(TextLabel,Tween,{
						TextStrokeTransparency = 1,
						TextTransparency = 1
					});

					Compkiller:_Animation(TextLabel_2,Tween,{
						TextStrokeTransparency = 1,
						TextTransparency = 1
					});
				end;
			end;

			function ConfigButton:Update()
				local nameScale = TextService:GetTextSize(ConfigText.Text,ConfigText.TextSize,ConfigText.Font,Vector2.new(math.huge,math.huge));

				AuthorText:SetAttribute('SPC',math.clamp(nameScale.X + 20 , 100,150));

				AuthorText.Position = UDim2.new(0, AuthorText:GetAttribute('SPC'), 0.5, 15)
			end;

			ConfigButton:Update();

			Compkiller:_Input(LoadButton,function()
				task.spawn(ConfigButton.OnLoad);
			end);

			Compkiller:_Input(SaveButton,function()
				task.spawn(ConfigButton.OnSave);
			end);

			DelButton.MouseButton1Click:Connect(function()
				task.spawn(ConfigButton.OnDelete);
			end)

			ConfigButton.OnLoad = nil;
			ConfigButton.OnSave = nil;
			ConfigButton.OnDelete = nil;

			return ConfigButton;
		end;

		function TabArgs:Init()
			local __signals = {};
			local Init = {};

			Compkiller:_Input(Button,function()
				if TextBox.Text:byte() then
					Configuration.Config:WriteConfig({
						Name = TextBox.Text,
						Author = WindowArgs.Username,
					});
				end;
			end);

			local Refresh = function()
				local FullConfig = Configuration.Config:GetFullConfigs();

				for i,v in next, ScrollingFrame:GetChildren() do
					if v:IsA('Frame') and v.Name ~= "Space" then
						v:Destroy();
					end;
				end;

				for i,v in next , __signals do
					v:Disconnect();
				end;

				for i,v in next , FullConfig do
					local Button = TabArgs:_DrawConfig();

					Button:SetInfo(v.Info.Author,v.Name);

					table.insert(__signals,TabOpenSignal:Connect(function(v)
						Button:Toggle(v);
					end));

					Button.OnLoad = function()
						Configuration.Config:LoadConfig(v.Name);
					end;

					Button.OnSave = function()
						local NewAuthorText = ((v.Info.Author == WindowArgs.Username) and  WindowArgs.Username) or v.Info.Author .. " [EDIT]";

						Button:SetInfo(NewAuthorText,v.Name);

						Configuration.Config:WriteConfig({
							Name = v.Name,
							Author = NewAuthorText;
						});
					end

					Button.OnDelete = function()
						Configuration.Config:DeleteConfig(v.Name)
					end
				end;
			end;

			Refresh();

			Init.THREAD = task.spawn(function()
				local OldIndex = Configuration.Config:GetConfigCount();

				while true do task.wait(0.125);
					local CountInDirectory = Configuration.Config:GetConfigCount();

					if OldIndex ~= CountInDirectory then
						OldIndex = CountInDirectory;

						Refresh();
					end;
				end;
			end);

			return Init;
		end;

		return TabArgs;
	end;

	function WindowArgs:DrawTab(TabConfig : TabConfig , Internal)
		TabConfig = Compkiller.__CONFIG(TabConfig,{
			Name = "Tab",
			Icon = "eye",
			Type = "Double"
		});

		local TabOpenSignal = Compkiller.__SIGNAL(false);
		local TabArgs = {};
		local Upvalue = {};

		if Internal then

			local TabContent = Instance.new("Frame")
			local Left = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Right = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			TabContent.Name = "TabContent"
			TabContent.Parent = Internal.Parent;
			TabContent.AnchorPoint = Vector2.new(0.5, 0.5)
			TabContent.BackgroundTransparency = 1.000
			TabContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabContent.BorderSizePixel = 0
			TabContent.Position = UDim2.new(0.5, 0, 0.5, 0)
			TabContent.Size = UDim2.new(1, 0,1, 0)
			TabContent.ZIndex = 6

			Left.Name = "Left"
			Left.Parent = TabContent
			Left.Active = true
			Left.AnchorPoint = Vector2.new(0.5, 0.5)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.ClipsDescendants = false
			Left.ScrollingEnabled = false;
			Left.Position = UDim2.new(0.25, -3, 0.5, 0)
			Left.Size = UDim2.new(0.5, -3, 1, 0)
			Left.ZIndex = 8
			Left.BottomImage = ""
			Left.CanvasSize = UDim2.new(0, 0, 0, 0)
			Left.ScrollBarThickness = 0
			Left.TopImage = ""

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Left.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
			end)

			UIListLayout.Parent = Left
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalFlex = Enum.UIFlexAlignment.Fill
			UIListLayout.Padding = UDim.new(0, 10)

			Right.Name = "Right"
			Right.Parent = TabContent
			Right.Active = true
			Right.AnchorPoint = Vector2.new(0.5, 0.5)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = false
			Right.Position = UDim2.new(0.75, 3, 0.5, 0)
			Right.Size = UDim2.new(0.5, -3, 1, 0)
			Right.ZIndex = 8
			Right.ScrollingEnabled = false
			Right.BottomImage = ""
			Right.CanvasSize = UDim2.new(0, 0, 0, 0)
			Right.ScrollBarThickness = 0
			Right.TopImage = ""

			Upvalue.Left = Left;
			Upvalue.Right = Right;

			UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Right.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y)
			end)

			UIListLayout_2.Parent = Right
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, 10)
			UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.Fill

			if Compkiller:_IsMobile() or TabConfig.EnableScrolling then
				WindowArgs:AddUnbind(UIListLayout_2 , Right);
				WindowArgs:AddUnbind(UIListLayout , Left);
			end;

			if TabConfig.Type == "Single" then
				Right.Visible = false;
				Left.Position = UDim2.new(0.5, 0, 0.5, 0)
				Left.Size = UDim2.new(1,0,1,0)
			end;

			local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

			Internal.Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if Internal.Highlight.BackgroundTransparency <= 0.99 then
					TabContent.Visible = true;
				else
					TabContent.Visible = false;
				end;
			end);

			Upvalue.Left = Left;
			Upvalue.Right = Right;

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Left);
				Compkiller:_AddDragBlacklist(Right);
			end;

			TabOpenSignal = Internal.Signal;

			if not TabOpenSignal:GetValue() then
				TabContent.Visible = false;
			else
				TabContent.Visible = true;
			end;
		else
			-- Button --
			local TabButton = Instance.new("Frame")
			local Icon = Instance.new("ImageLabel")
			local TabNameLabel = Instance.new("TextLabel")
			local Highlight = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")

			TabButton.Name = "TabButton"
			TabButton.Parent = TabButtonScrollingFrame
			TabButton.BackgroundTransparency = 1.000
			TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabButton.BorderSizePixel = 0
			TabButton.ClipsDescendants = true
			TabButton.Size = UDim2.new(1, -10, 0, 32)
			TabButton.ZIndex = 3

			local ImageIcon : table? = Compkiller:_GetIcon(TabConfig.Icon);

			Icon.Name = "Icon"
			Icon.Parent = TabButton
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = Compkiller.Colors.Highlight
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, 15, 0.5, 0)
			Icon.Size = UDim2.new(0, 22, 0, 22)
			Icon.ZIndex = 3
			Icon.ImageRectOffset = ImageIcon.ImageRectPosition
			Icon.ImageRectSize = ImageIcon.ImageRectSize
			Icon.Image = ImageIcon.Image
			Icon.ImageColor3 = Compkiller.Colors.Highlight

			table.insert(Compkiller.Elements.Highlight,{
				Element = Icon,
				Property = "ImageColor3"
			});

			TabNameLabel.Name = "TabNameLabel"
			TabNameLabel.Parent = TabButton
			TabNameLabel.AnchorPoint = Vector2.new(0, 0.5)
			TabNameLabel.BackgroundTransparency = 1.000
			TabNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabNameLabel.BorderSizePixel = 0
			TabNameLabel.Position = UDim2.new(0, 43, 0.5, 0)
			TabNameLabel.Size = UDim2.new(0, 200, 0, 25)
			TabNameLabel.ZIndex = 3
			TabNameLabel.Font = Enum.Font.GothamMedium
			TabNameLabel.Text = TabConfig.Name;
			TabNameLabel.TextColor3 = Compkiller.Colors.SwitchColor
			TabNameLabel.TextSize = 15.000
			TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			table.insert(Compkiller.Elements.SwitchColor , {
				Element = TabNameLabel,
				Property = 'TextColor3'
			});
			
			Highlight.Name = "Highlight"
			Highlight.Parent = TabButton
			Highlight.AnchorPoint = Vector2.new(0.5, 0.5)
			Highlight.BackgroundColor3 = Color3.fromRGB(161, 161, 161)
			Highlight.BackgroundTransparency = 0.925
			Highlight.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Highlight.BorderSizePixel = 0
			Highlight.Position = UDim2.new(0.5, 0, 0.5, 0)
			Highlight.Size = UDim2.new(1, -17, 1, 0)
			Highlight.ZIndex = 2

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Highlight

			local TabContent = Instance.new("Frame")
			local Left = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Right = Instance.new("ScrollingFrame")
			local UIListLayout_2 = Instance.new("UIListLayout")

			TabContent.Name = "TabContent"
			TabContent.Parent = TabMainFrame;
			TabContent.AnchorPoint = Vector2.new(0.5, 0.5)
			TabContent.BackgroundTransparency = 1.000
			TabContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabContent.BorderSizePixel = 0
			TabContent.Position = UDim2.new(0.5, 0, 0.5, 0)
			TabContent.Size = UDim2.new(1, -15, 1, -15)
			TabContent.ZIndex = 6

			Left.Name = "Left"
			Left.Parent = TabContent
			Left.Active = true
			Left.AnchorPoint = Vector2.new(0.5, 0.5)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.ClipsDescendants = false
			Left.ScrollingEnabled = false;
			Left.Position = UDim2.new(0.25, -3, 0.5, 0)
			Left.Size = UDim2.new(0.5, -3, 1, 0)
			Left.ZIndex = 8
			Left.BottomImage = ""
			Left.CanvasSize = UDim2.new(0, 0, 0, 0)
			Left.ScrollBarThickness = 0
			Left.TopImage = ""

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Left.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
			end)

			UIListLayout.Parent = Left
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalFlex = Enum.UIFlexAlignment.Fill
			UIListLayout.Padding = UDim.new(0, 10)

			Right.Name = "Right"
			Right.Parent = TabContent
			Right.Active = true
			Right.AnchorPoint = Vector2.new(0.5, 0.5)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = false
			Right.Position = UDim2.new(0.75, 3, 0.5, 0)
			Right.Size = UDim2.new(0.5, -3, 1, 0)
			Right.ZIndex = 8
			Right.ScrollingEnabled = false
			Right.BottomImage = ""
			Right.CanvasSize = UDim2.new(0, 0, 0, 0)
			Right.ScrollBarThickness = 0
			Right.TopImage = ""

			Upvalue.Left = Left;
			Upvalue.Right = Right;

			UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Right.CanvasSize = UDim2.fromOffset(0,UIListLayout_2.AbsoluteContentSize.Y)
			end)

			UIListLayout_2.Parent = Right
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, 10)
			UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.Fill

			if Compkiller:_IsMobile() or TabConfig.EnableScrolling then
				WindowArgs:AddUnbind(UIListLayout_2 , Right);
				WindowArgs:AddUnbind(UIListLayout , Left);
			end;

			if Compkiller:_IsMobile() then
				Compkiller:_AddDragBlacklist(Left);
				Compkiller:_AddDragBlacklist(Right);
			end;

			if TabConfig.Type == "Single" then
				Right.Visible = false;
				Left.Position = UDim2.new(0.5, 0, 0.5, 0)
				Left.Size = UDim2.new(1, -1, 1, -1)
			end;

			local Tween = TweenInfo.new(0.35,Enum.EasingStyle.Quint);

			Highlight:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if Highlight.BackgroundTransparency <= 0.99 then
					TabContent.Visible = true;
				else
					TabContent.Visible = false;
				end;
			end)

			local TabOpen = function(bool)
				if bool then

					WindowArgs.SelectedTab = TabButton;

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0,
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0
					});

					Compkiller:_Animation(Highlight,Tween,{
						BackgroundTransparency = 0.925
					});


				else

					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.5
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.5
					});

					Compkiller:_Animation(Highlight,Tween,{
						BackgroundTransparency = 1
					});
				end;
			end;

			if not WindowArgs.Tabs[1] then
				TabOpenSignal:Fire(true);
				TabOpen(true);
			else
				TabOpen(false);
			end;

			table.insert(WindowArgs.Tabs , {
				Root = TabButton,
				Remote = TabOpenSignal
			});

			Compkiller:_Hover(TabButton,function()
				if WindowArgs.SelectedTab ~= TabButton then
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.1
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.1
					});
				end;
			end , function()
				if WindowArgs.SelectedTab ~= TabButton then
					Compkiller:_Animation(Icon,Tween,{
						ImageTransparency = 0.5
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						TextTransparency = 0.5
					});
				end;
			end)

			TabOpenSignal:Connect(TabOpen);

			TabHover:Connect(function(bool)
				if bool then
					Compkiller:_Animation(TabButton,Tween,{
						Size = UDim2.new(1, -10, 0, 32)
					});

					Compkiller:_Animation(Icon,Tween,{
						Position = UDim2.new(0, 15, 0.5, 0),
						Size = UDim2.new(0, 22, 0, 22),
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						Size = UDim2.new(0, 200, 0, 25),
						Position = UDim2.new(0, 43, 0.5, 0)
					});

					Compkiller:_Animation(UICorner,Tween,{
						CornerRadius = UDim.new(0, 4)
					});

					Compkiller:_Animation(Highlight,Tween,{
						Size = UDim2.new(1, -17, 1, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0)
					});
				else
					Compkiller:_Animation(UICorner,Tween,{
						CornerRadius = UDim.new(0, 10)
					});

					Compkiller:_Animation(TabButton,Tween,{
						Size = UDim2.new(1, -10, 0, 32)
					});

					Compkiller:_Animation(Icon,Tween,{
						Position = UDim2.new(0, 12, 0.5, 0),
						Size = UDim2.new(0, 20, 0, 20),
					});

					Compkiller:_Animation(TabNameLabel,Tween,{
						Size = UDim2.new(0, 200, 0, 25),
						Position = UDim2.new(0, 80, 0.5, 0)
					});

					Compkiller:_Animation(Highlight,Tween,{
						Size = UDim2.new(1, -10,1, 5),
						Position = UDim2.new(0.5, 0, 0.5, 0)
					});
				end;
			end);

			Compkiller:_Input(TabButton,function()
				for i,v in next, WindowArgs.Tabs do
					if v.Root == TabButton then
						v.Remote:Fire(true);
					else
						v.Remote:Fire(false);
					end;
				end;
			end);


		end;

		local lastSection = 'right';

		function TabArgs:DrawSection(config: Section)
			config = Compkiller:_ConvertArgs(config)

			if not config.Position then	
				if lastSection == 'right' then
					lastSection = 'left'
				else
					lastSection = 'right'
				end
			else
				lastSection = config.Position
			end

			config.Position = lastSection

			config = Compkiller.__CONFIG(config,{
				Name = "Section",
				Position = "left"
			});

			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local UIListLayout = Instance.new("UIListLayout")
			local Header = Instance.new("Frame")
			local SectionText = Instance.new("TextLabel")
			local SectionClose = Instance.new("ImageLabel")

			Section.Name = "Section"
			Section.Parent = (TabConfig.Type == "Double" and ((string.lower(config.Position) == "left" and Upvalue.Left) or Upvalue.Right)) or Upvalue.Left;

			if TabConfig.Type == "Single" then
				Section.Parent = Upvalue.Left;
			end;

			Section.BackgroundColor3 = Compkiller.Colors.BlockColor
			
			table.insert(Compkiller.Elements.BlockColor , {
				Element = Section,
				Property = "BackgroundColor3"
			});
			
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(1, 0, 0, 0)
			Section.ZIndex = 9

			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Section

			UIStroke.Color = Compkiller.Colors.StrokeColor
			UIStroke.Parent = Section
			
			table.insert(Compkiller.Elements.StrokeColor,{
				Element = UIStroke,
				Property = "Color"
			});

			UIListLayout.Parent = Section
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)

			Header.Name = "Header"
			Header.Parent = Section
			Header.BackgroundTransparency = 1.000
			Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Header.BorderSizePixel = 0
			Header.LayoutOrder = -100
			Header.Size = UDim2.new(1, 0, 0, 35)
			Header.ZIndex = 9

			SectionText.Name = "SectionText"
			SectionText.Parent = Header
			SectionText.AnchorPoint = Vector2.new(0, 0.5)
			SectionText.BackgroundTransparency = 1.000
			SectionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionText.BorderSizePixel = 0
			SectionText.Position = UDim2.new(0, 12, 0.5, 0)
			SectionText.Size = UDim2.new(0, 200, 0, 25)
			SectionText.ZIndex = 10
			SectionText.Font = Enum.Font.GothamMedium
			SectionText.Text = config.Name;
			SectionText.TextColor3 = Compkiller.Colors.SwitchColor
			SectionText.TextSize = 14.000
			SectionText.TextTransparency = 0.500
			SectionText.TextXAlignment = Enum.TextXAlignment.Left
			
			table.insert(Compkiller.Elements.SwitchColor , {
				Element = SectionText,
				Property = 'TextColor3'
			});
			
			SectionClose.Name = "SectionClose"
			SectionClose.Parent = Header
			SectionClose.AnchorPoint = Vector2.new(1, 0.5)
			SectionClose.BackgroundTransparency = 1.000
			SectionClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionClose.BorderSizePixel = 0
			SectionClose.Position = UDim2.new(1, -12, 0.5, 0)
			SectionClose.Size = UDim2.new(0, 17, 0, 17)
			SectionClose.ZIndex = 10
			SectionClose.Image = "rbxassetid://10709790948"
			SectionClose.ImageTransparency = 0.500

			if not SectionText.Text:byte() then
				Header.Visible = false;
			else
				Header.Visible = true;
			end;

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				if not SectionText.Text:byte() then
					Header.Visible = false;
				else
					Header.Visible = true;
				end;

				Compkiller:_Animation(Section,TweenInfo.new(0.1),{
					Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y)
				})
			end);

			TabOpenSignal:Connect(function(bool)
				if bool then
					Compkiller:_Animation(Section,TweenInfo.new(0.21),{
						BackgroundTransparency = 0
					})

					Compkiller:_Animation(SectionText,TweenInfo.new(0.21),{
						TextTransparency = 0.500
					})

					Compkiller:_Animation(SectionClose,TweenInfo.new(0.21),{
						ImageTransparency = 0.500
					})
				else
					Compkiller:_Animation(Section,TweenInfo.new(0.21),{
						BackgroundTransparency = 1
					})

					Compkiller:_Animation(SectionText,TweenInfo.new(0.21),{
						TextTransparency = 1
					})

					Compkiller:_Animation(SectionClose,TweenInfo.new(0.21),{
						ImageTransparency = 1
					})
				end;
			end);

			return Compkiller:_LoadElement(Section , true , TabOpenSignal)
		end;

		return TabArgs;
	end;

	do
		local CloseWindow = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ImageLabel = Instance.new("ImageLabel")

		CloseWindow.Name = "CloseWindow"
		CloseWindow.Parent = CompKiller
		CloseWindow.AnchorPoint = Vector2.new(1, 0)
		CloseWindow.BackgroundColor3 = Compkiller.Colors.BGDBColor
		
		table.insert(Compkiller.Elements.BGDBColor,{
			Element = CloseWindow,
			Property = 'BackgroundColor3'
		});
		
		CloseWindow.BackgroundTransparency = 1
		CloseWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
		CloseWindow.BorderSizePixel = 0
		CloseWindow.Position = UDim2.new(1, -10, 0, 10)
		CloseWindow.Size = UDim2.new(0, 0, 0, 23)
		CloseWindow.ZIndex = 150
		CloseWindow.ClipsDescendants = true;

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = CloseWindow

		ImageLabel.Parent = CloseWindow
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeYY
		ImageLabel.ZIndex = 151
		ImageLabel.Image = Config.Logo
		ImageLabel.ImageTransparency = 1
		ImageLabel.ClipsDescendants = false;

		local ToggleCloseUI = function(v)
			ImageLabel.Image = Config.Logo;

			if v then
				ImageLabel.ClipsDescendants = true;

				Compkiller:_Animation(CloseWindow,TweenInfo.new(0.2),{
					Size = UDim2.new(0, 45, 0, 23),
					BackgroundTransparency = 0.025
				})

				Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
					ImageTransparency = (ImageLabel:GetAttribute('Hover') and 0.1) or 0.35
				})
			else
				ImageLabel.ClipsDescendants = false;

				Compkiller:_Animation(CloseWindow,TweenInfo.new(0.2),{
					Size = UDim2.new(0, 0, 0, 23),
					BackgroundTransparency = 1
				})

				Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
					ImageTransparency = 1
				})
			end;
		end;

		function WindowArgs:Watermark()
			local Watermark = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Logo = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Frame = Instance.new("Frame")
			local CompLogo = Instance.new("ImageLabel")
			local WaternarkList = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")

			Watermark.Name = "Watermark"
			Watermark.Parent = CompKiller
			Watermark.AnchorPoint = Vector2.new(1, 0)
			Watermark.BackgroundColor3 = Compkiller.Colors.BGDBColor
			
			table.insert(Compkiller.Elements.BGDBColor,{
				Element = Watermark,
				Property = 'BackgroundColor3'
			});
			
			Watermark.BackgroundTransparency = 0.025
			Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Watermark.BorderSizePixel = 0
			Watermark.Position = UDim2.new(1, -10, 0, 10)
			Watermark.Size = UDim2.new(0, 45, 0, 23)
			Watermark.ZIndex = 150

			ImageLabel:GetPropertyChangedSignal('ClipsDescendants'):Connect(function()
				if ImageLabel.ClipsDescendants then
					Compkiller:_Animation(Watermark , TweenInfo.new(0.2),{
						Position = UDim2.new(1, -60, 0, 10)
					})
				else
					Compkiller:_Animation(Watermark , TweenInfo.new(0.2),{
						Position = UDim2.new(1, -10, 0, 10)
					})
				end;
			end)

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Watermark

			Logo.Name = "Logo"
			Logo.Parent = Watermark
			Logo.AnchorPoint = Vector2.new(1, 0.5)
			Logo.BackgroundColor3 = Compkiller.Colors.BGDBColor
			
			table.insert(Compkiller.Elements.BGDBColor,{
				Element = Logo,
				Property = 'BackgroundColor3'
			});
			
			Logo.BackgroundTransparency = 0.300
			Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Logo.BorderSizePixel = 0
			Logo.Position = UDim2.new(0, 5, 0.5, 0)
			Logo.Size = UDim2.new(1, 10, 1, 0)
			Logo.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Logo.ZIndex = 149

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = Logo

			Frame.Parent = Logo
			Frame.AnchorPoint = Vector2.new(0, 0.5)
			Frame.BackgroundColor3 = Compkiller.Colors.Highlight
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(1, -5, 0.5, 0)
			Frame.Size = UDim2.new(0, 2, 1, 0)
			Frame.ZIndex = 151

			table.insert(Compkiller.Elements.Highlight,{
				Element = Frame,
				Property = "BackgroundColor3"
			});

			CompLogo.Name = "CompLogo"
			CompLogo.Parent = Logo
			CompLogo.AnchorPoint = Vector2.new(0.5, 0.5)
			CompLogo.BackgroundTransparency = 1.000
			CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CompLogo.BorderSizePixel = 0
			CompLogo.Position = UDim2.new(0.5, -2, 0.5, 0)
			CompLogo.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
			CompLogo.SizeConstraint = Enum.SizeConstraint.RelativeYY
			CompLogo.ZIndex = 159
			CompLogo.Image = Config.Logo

			WaternarkList.Name = "WaternarkList"
			WaternarkList.Parent = Watermark
			WaternarkList.AnchorPoint = Vector2.new(0.5, 0)
			WaternarkList.BackgroundTransparency = 1.000
			WaternarkList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WaternarkList.BorderSizePixel = 0
			WaternarkList.Position = UDim2.new(0.5, 0, 0, 0)
			WaternarkList.Size = UDim2.new(1, -10, 1, 0)
			WaternarkList.ZIndex = 155
			WaternarkList.ClipsDescendants = true

			UIListLayout.Parent = WaternarkList
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout.Padding = UDim.new(0, 3)

			local BackFrame = Instance.new("Frame")

			BackFrame.Name = "BackFrame"
			BackFrame.Parent = Watermark
			BackFrame.AnchorPoint = Vector2.new(1, 0.5)
			BackFrame.BackgroundTransparency = 1.000
			BackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BackFrame.BorderSizePixel = 0
			BackFrame.Position = UDim2.new(1, 0, 0.5, 0)
			BackFrame.Size = UDim2.new(1, 30, 1, 0)

			Compkiller:_Blur(BackFrame,WindowOpen);

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Compkiller:_Animation(Watermark,TweenInfo.new(0.4),{
					Size = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + 8, 0, 23)
				});
			end)

			local Args = {};

			function Args:AddText(Watermark : Watermark)
				Watermark = Compkiller.__CONFIG(Watermark, {
					Text = "Watermark",
					Icon = "info"
				});

				local Icon = Instance.new("ImageLabel")
				local TextLabel = Instance.new("TextLabel")

				local ImageIcon : table? = Compkiller:_GetIcon(Watermark.Icon);

				Icon.Name = "Icon"
				Icon.Parent = WaternarkList
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Size = UDim2.fromOffset(15,15)
				Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
				Icon.ZIndex = 156
				Icon.ImageRectOffset = ImageIcon.ImageRectPosition
				Icon.ImageRectSize = ImageIcon.ImageRectSize
				Icon.Image = ImageIcon.Image

				TextLabel.Parent = WaternarkList
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Size = UDim2.new(0, 50, 0.699999988, 0)
				TextLabel.ZIndex = 156
				TextLabel.Font = Enum.Font.GothamMedium
				TextLabel.Text = Watermark.Text
				TextLabel.TextColor3 = Compkiller.Colors.SwitchColor
				TextLabel.TextSize = 10.000
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left
				
				table.insert(Compkiller.Elements.SwitchColor , {
					Element = TextLabel,
					Property = 'TextColor3'
				});
				
				local Update = function()
					local scale = TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge));

					TextLabel.Size = UDim2.new(0, scale.X + 2, 0.7, 0)
				end;

				Update()

				local Arg = {};

				function Arg:SetText(text)
					TextLabel.Text = text;
					Update();
				end;

				function Arg:Visible(v)
					Icon.Visible = v;
					TextLabel.Visible = v;
				end;

				return Arg;
			end;

			return Args;
		end;

		function WindowArgs:Toggle(Value: boolean)
			WindowOpen:Fire(Value);

			if Value then
				for i,v in next , WindowArgs.Tabs do
					if v.Root == WindowArgs.SelectedTab then
						v.Remote:Fire(true);
					end;
				end;
			else
				for i,v in next , WindowArgs.Tabs do
					v.Remote:Fire(false);
				end;
			end;
		end;

		function WindowArgs:_ToggleUI()
			WindowArgs.IsOpen = not WindowArgs.IsOpen;

			WindowArgs:Toggle(WindowArgs.IsOpen)
		end;

		local Button = Compkiller:_Input(CloseWindow,function()
			WindowArgs:_ToggleUI()
		end)

		if not Compkiller:_IsMobile() then

			Compkiller:_Hover(Button,function()
				ImageLabel:SetAttribute("Hover",true);
			end , function()
				ImageLabel:SetAttribute("Hover",false);
			end);
		end;

		table.insert(WindowArgs.THREADS,task.spawn(function()
			while true do task.wait(0.15)
				if Compkiller:_IsMobile() then
					ToggleCloseUI(true);

					if WindowArgs.IsOpen then
						Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
							ImageTransparency = 0.35
						});

						ImageLabel:GetAttribute("Hover",false);
					else
						ImageLabel:GetAttribute("Hover",true);

						Compkiller:_Animation(ImageLabel,TweenInfo.new(0.2),{
							ImageTransparency = 0.1
						});
					end;
				else
					if not WindowArgs.IsOpen then
						ToggleCloseUI(true);
					else
						ToggleCloseUI(false);
					end
				end;
			end
		end));

		UserInputService.InputBegan:Connect(function(Input,Typing)
			if not Typing and (Input.KeyCode == Config.Keybind or Input.KeyCode.Name == Config.Keybind) then
				WindowArgs:_ToggleUI()
			end;
		end);
	end;

	function WindowArgs:Update(config: WindowUpdate)
		config = config or {};
		config.Logo = config.Logo or Config.Logo;
		config.Username = config.Username or LocalPlayer.DisplayName;
		config.ExpireDate = config.ExpireDate or "NEVER";
		config.WindowName = config.WindowName or Config.Name;
		config.UserProfile = config.UserProfile or string.format("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150",tostring(LocalPlayer.UserId));

		UserText.Text = config.Username;
		CompLogo.Image = config.Logo;
		ExpireText.Text = config.ExpireDate;
		WindowLabel.Text = config.WindowName;
		UserProfile.Image = config.UserProfile;
		WindowArgs.Username = config.Username;

		Config.Logo = config.Logo or Config.Logo;
		WindowArgs.Username = config.Username or WindowArgs.Username;
		WindowArgs.ExipreDate = config.ExpireDate or WindowArgs.ExipreDate;
		Config.Name = config.WindowName or Config.Name;
		WindowArgs.Profile = config.UserProfile or WindowArgs.Profile;
	end;

	WindowArgs.LOOP_THREAD = task.spawn(function()
		local TimeTic = tick();

		local BlurElement = Instance.new("Frame")

		BlurElement.Name = "BlurElement"
		BlurElement.Parent = MainFrame
		BlurElement.AnchorPoint = Vector2.new(1, 0.5)
		BlurElement.BackgroundTransparency = 1.000
		BlurElement.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BlurElement.BorderSizePixel = 0
		BlurElement.Position = UDim2.new(1, -5, 0.5, 0)
		BlurElement.Size = UDim2.new(1, 0, 1, 0)
		BlurElement.ZIndex = -100
		BlurElement.Active = true

		Compkiller:_Blur(BlurElement , WindowOpen);

		local MovementFrame = Instance.new("Frame")

		MovementFrame.Name = "MovementFrame"
		MovementFrame.Parent = MainFrame
		MovementFrame.AnchorPoint = Vector2.new(1, 0.5)
		MovementFrame.BackgroundTransparency = 1.000
		MovementFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MovementFrame.BorderSizePixel = 0
		MovementFrame.Position = UDim2.new(1, 0, 0.5, 0)
		MovementFrame.Size = UDim2.new(1, 0, 1, 0)
		MovementFrame.ZIndex = 9

		Compkiller:Drag(MovementFrame,MainFrame,0.1)

		table.insert(Compkiller.Elements.Highlight,{
			Element = SelectionFrame,
			Property = "BackgroundColor3"
		});

		while true do task.wait(0.01);
			BlurElement.Size = UDim2.new(1, TabFrame.AbsoluteSize.X - 35, 1, 0);
			MovementFrame.Size = UDim2.new(1, TabFrame.AbsoluteSize.X - 35, 1, 0);

			SelectionFrame.BackgroundColor3 = Compkiller.Colors.Highlight;

			if WindowArgs.SelectedTab and WindowArgs.IsOpen then
				local vili = -(TabButtons.AbsolutePosition.Y - WindowArgs.SelectedTab.AbsolutePosition.Y) + 2;
				local distance = (SelectionFrame.Position.Y.Offset - vili);

				if vili < 0 or vili > TabButtons.AbsoluteSize.Y then
					Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.1) , {
						BackgroundTransparency = 1
					});
				else
					if math.abs(distance) <= 10 then
						Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.1) , {
							BackgroundTransparency = 0
						});

						SelectionFrame.Position = UDim2.new(1,5,0,math.ceil(vili));
					else
						Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.15) , {
							BackgroundTransparency = 0,
							Position = UDim2.new(1,5,0,math.ceil(vili))
						});
					end;
				end;
			else
				Compkiller:_Animation(SelectionFrame , TweenInfo.new(0.15) , {
					BackgroundTransparency = 1
				});
			end;

			if WindowArgs.AlwayShowTab then
				TabHover:Fire(true);
			end;
		end;
	end);

	WindowArgs:Update();

	local OldDelayThread;
	local DurationTime = tick();

	Compkiller:_Hover(TabFrame , function()
		if OldDelayThread then
			task.cancel(OldDelayThread);
			OldDelayThread = nil;
		end;

		if WindowArgs.AlwayShowTab then
			return;
		end;

		DurationTime = tick();

		TabHover:Fire(true);
	end , function()
		if OldDelayThread then
			task.cancel(OldDelayThread);
			OldDelayThread = nil;
		end;

		if WindowArgs.AlwayShowTab then
			return;
		end;

		OldDelayThread = task.delay(math.clamp((tick() - DurationTime) , 0.01,5),function()
			if TabHover:GetValue() then
				TabHover:Fire(false);
			end
		end);
	end);

	return WindowArgs;
end;

function Compkiller:GetDate(Time)
	Time = Time or tick();

	local val = os.date('*t',Time);

	return string.format("%s/%s/%s",val.day,val.month,val.year);
end;

function Compkiller:GetTimeNow(Time)
	Time = Time or tick();

	local val = os.date('*t',Time);

	return string.format("%s:%s:%s",val.hour,val.min,val.sec);
end;

function Compkiller:GetConfig(Type: string)
	local ConfigFlags = {};

	for i,v in next , Compkiller.Flags do
		local Value = v:GetValue();
		local Suf = {};

		if typeof(Value) == "table" and Value.ColorPicker and typeof(Value.ColorPicker) == 'table' then
			Suf.Color3 = {
				R = Value.ColorPicker.Color.R,
				G = Value.ColorPicker.Color.G,
				B = Value.ColorPicker.Color.B
			};

			Suf.Transparency = Value.ColorPicker.Transparency;

			Suf.Type = "ColorPicker";
		else
			Suf.Value = Value;
			Suf.Type = "NormalElement";
		end;

		if Type == "KV" then
			ConfigFlags[v.Flag] = {
				Flag = v.Flag,
				Value = Suf,
				Functions = v,
			}
		elseif Type == "MK" then
			ConfigFlags[v.Flag] = {
				Flag = v.Flag,
				Value = Suf,
			}
		else
			table.insert(ConfigFlags , {
				Flag = v.Flag,
				Value = Suf
			})
		end;
	end;

	return ConfigFlags;
end;

function Compkiller:_Path(...)
	local args = {...};

	return table.concat(args, "/");
end;

function Compkiller:ConfigManager(ConfigManager: ConfigManager) : ConfigFunctions
	ConfigManager = Compkiller.__CONFIG(ConfigManager , {
		Directory = "Compkiller",
		Config = "Software"
	});

	if not isfolder(ConfigManager.Directory) then
		makefolder(ConfigManager.Directory);
	end;

	if not isfolder(Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config)) then
		makefolder(Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config));
	end;

	local Args = {
		Directory = Compkiller:_Path(ConfigManager.Directory , ConfigManager.Config);	
	};

	function Args:WriteConfig(Config: WriteConfig)
		Config = Compkiller.__CONFIG(Config , {
			Name = "Config",
			Author = LocalPlayer.Name,
		});

		local Flags = Compkiller:GetConfig("MK");

		Flags["__INFORMATION"] = {
			Type = "Information",
			Author = Config.Author,
			Name = Config.Name,
			CreatedDate = Compkiller:GetDate()
		};

		writefile(Compkiller:_Path(Args.Directory , Config.Name) , HttpService:JSONEncode(Flags));
	end;
	
	function Args:LoadConfigFromString(str: string)
		local decoded = HttpService:JSONDecode(str);
	
		local Flags = Compkiller:GetConfig("KV");

		for i,v in next , decoded do
			if v and v.Flag then

				local Value = Flags[v.Flag];

				if Value then

					if v.Value.Type == "NormalElement" then
						Value.Functions:SetValue(v.Value.Value);

					elseif v.Value.Type == "ColorPicker" then

						local Color = Color3.new(v.Value.Color3.R,v.Value.Color3.G,v.Value.Color3.B);

						local Transparency = v.Value.Transparency;

						Value.Functions:SetValue(Color , Transparency);
					end;
				end;
			end
		end;
	end;
	
	function Args:GetCurrentConfig()
		return Compkiller:GetConfig("MK")
	end;

	function Args:ReadInfo(ConfigName: string)
		local _path = Compkiller:_Path(Args.Directory , ConfigName);

		if isfile(_path) then
			local info = readfile(_path);

			local decoded = HttpService:JSONDecode(info);

			return decoded.__INFORMATION;
		end;

		return false;
	end;

	function Args:GetConfigs()
		local names = {};

		for i,v in next , listfiles(Args.Directory) do
			local Name = string.sub(v , #Args.Directory + 2);

			table.insert(names , Name);
		end;

		return names;
	end;

	function Args:GetFullConfigs()
		local names = {};

		for i,v in next , listfiles(Args.Directory) do
			local Name = string.sub(v , #Args.Directory + 2);
			local Info = Args:ReadInfo(Name);

			table.insert(names , {
				Name = Name,
				Info = Info,
			});
		end;

		return names;
	end;

	function Args:DeleteConfig(ConfigName)
		local _path = Compkiller:_Path(Args.Directory,ConfigName);

		if isfile(_path) then
			delfile(_path);
		end;
	end;

	function Args:GetConfigCount()
		return #listfiles(Args.Directory);
	end;

	function Args:LoadConfig(ConfigName: string)
		local _path = Compkiller:_Path(Args.Directory,ConfigName);

		if isfile(_path) then
			local info = readfile(_path);

			local decoded = HttpService:JSONDecode(info);

			local Flags = Compkiller:GetConfig("KV");

			for i,v in next , decoded do
				if v and v.Flag then

					local Value = Flags[v.Flag];

					if Value then

						if v.Value.Type == "NormalElement" then
							task.spawn(function()
								Value.Functions:SetValue(v.Value.Value);
							end)
						elseif v.Value.Type == "ColorPicker" then

							local Color = Color3.new(v.Value.Color3.R,v.Value.Color3.G,v.Value.Color3.B);

							local Transparency = v.Value.Transparency;

							Value.Functions:SetValue(Color, Transparency);
						end;
					end;
				end
			end;
		end;
	end;

	return Args;
end;

function Compkiller:Loader(IconId,Duration)
	local CompKiller = Instance.new("ScreenGui")

	CompKiller.Name = "Loader"
	CompKiller.Parent = CoreGui
	CompKiller.Enabled = true
	CompKiller.ResetOnSpawn = false
	CompKiller.IgnoreGuiInset = true
	CompKiller.ZIndexBehavior = Enum.ZIndexBehavior.Global

	local Loader = Instance.new("Frame")
	local Icon = Instance.new("ImageLabel")
	local Vignette = Instance.new("ImageLabel")

	Loader.Name = "Loader"
	Loader.Parent = CompKiller
	Loader.AnchorPoint = Vector2.new(0.5, 0.5)
	Loader.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Loader.BackgroundTransparency = 1
	Loader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Loader.BorderSizePixel = 0
	Loader.Position = UDim2.new(0.5, 0, 0.5, 0)
	Loader.Size = UDim2.new(1, 0, 1, 0)

	Icon.Name = "Icon"
	Icon.Parent = Loader
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Size = UDim2.new(0, 750, 0, 750)
	Icon.ZIndex = 100
	Icon.Image = IconId or "rbxassetid://120245531583106"
	Icon.ImageTransparency = 1

	Vignette.Name = "Vignette"
	Vignette.Parent = Loader
	Vignette.BackgroundTransparency = 1.000
	Vignette.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Vignette.BorderSizePixel = 0
	Vignette.Size = UDim2.new(1, 0, 1, 0)
	Vignette.Image = "rbxassetid://18720640102"
	Vignette.ImageColor3 = Compkiller.Colors.Highlight
	Vignette.ImageTransparency = 1
	Vignette.AnchorPoint = Vector2.new(0.5,0.5)
	Vignette.Position = UDim2.fromScale(0.5,0.5)

	Compkiller:_Animation(Loader,TweenInfo.new(0.55,Enum.EasingStyle.Quint),{
		BackgroundTransparency = 0.5
	});

	local Event = Instance.new('BindableEvent');

	task.delay(0.5,function()
		Compkiller:_Animation(Icon,TweenInfo.new(0.75,Enum.EasingStyle.Quint),{
			ImageTransparency = 0.01,
			Size = UDim2.new(0, 200, 0, 200)
		});

		task.delay(0.25,function()
			Compkiller:_Animation(Vignette,TweenInfo.new(5),{
				ImageTransparency = 0.2
			});

			task.wait(Duration or 4.5)

			Compkiller:_Animation(Vignette,TweenInfo.new(3,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				Size = UDim2.new(2, 0, 2, 0)
			});

			Compkiller:_Animation(Icon,TweenInfo.new(0.75,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				ImageTransparency = 1,
			});

			Compkiller:_Animation(Loader,TweenInfo.new(1.5,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
				BackgroundTransparency = 1
			});

			task.delay(0.1,function()
				Compkiller:_Animation(Vignette,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.InOut),{
					ImageTransparency = 1
				});

				task.wait(0.2)

				task.delay(3,function()
					CompKiller:Destroy();
				end)
			end)

			task.delay(0.6,function()
				Event:Fire();
			end)
		end)
	end);

	return {
		yield = function()
			return Event.Event:Wait();
		end	
	};
end;

function Compkiller.newNotify()
	local Notification = Instance.new("ScreenGui")
	local NotifyContainer = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Notification.Name = "Notification"
	Notification.Parent = CoreGui
	Notification.ResetOnSpawn = false
	Notification.ZIndexBehavior = Enum.ZIndexBehavior.Global

	NotifyContainer.Name = "NotifyContainer"
	NotifyContainer.Parent = Notification
	NotifyContainer.AnchorPoint = Vector2.new(1, 0)
	NotifyContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NotifyContainer.BackgroundTransparency = 1.000
	NotifyContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NotifyContainer.BorderSizePixel = 0
	NotifyContainer.Position = UDim2.new(1, -10, 0, 1)
	NotifyContainer.Size = UDim2.new(0, 100, 0, 100)

	UIListLayout.Parent = NotifyContainer
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 3)
	
	return {
		new = function(Notify: Notify)
			Notify = Compkiller.__CONFIG(Notify, {
				Icon = Compkiller.Logo,
				Title = "Notification",
				Content = "Content",
				Duration = 5,
			});
			
			local BlockFrame = Instance.new("Frame")
			local NotifyFrame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local CompLogo = Instance.new("ImageLabel")
			local Header = Instance.new("TextLabel")
			local Body = Instance.new("TextLabel")
			local TimeLeftFrame = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TimeLeft = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")

			BlockFrame.Name = "BlockFrame"
			BlockFrame.Parent = NotifyContainer
			BlockFrame.AnchorPoint = Vector2.new(1, 0)
			BlockFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 29)
			BlockFrame.BackgroundTransparency = 1.000
			BlockFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BlockFrame.BorderSizePixel = 0
			BlockFrame.ClipsDescendants = false
			BlockFrame.Size = UDim2.new(0, 200, 0, 0)
			BlockFrame.LayoutOrder = -#NotifyContainer:GetChildren();

			NotifyFrame.Name = "NotifyFrame"
			NotifyFrame.Parent = BlockFrame
			NotifyFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 29)
			NotifyFrame.BackgroundTransparency = 0.100
			NotifyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NotifyFrame.BorderSizePixel = 0
			NotifyFrame.ClipsDescendants = false
			NotifyFrame.Size = UDim2.new(1, 0, 1, -5)
			NotifyFrame.ZIndex = 2
			NotifyFrame.Position = UDim2.new(1,200,0,0)

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = NotifyFrame

			CompLogo.Name = "CompLogo"
			CompLogo.Parent = NotifyFrame
			CompLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CompLogo.BackgroundTransparency = 1.000
			CompLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CompLogo.BorderSizePixel = 0
			CompLogo.Position = UDim2.new(0, 6, 0, 6)
			CompLogo.Size = UDim2.new(0, 25, 0, 25)
			CompLogo.ZIndex = 4
			CompLogo.Image = Compkiller:_GetIcon(Notify.Icon);

			Header.Name = "Header"
			Header.Parent = NotifyFrame
			Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Header.BackgroundTransparency = 1.000
			Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Header.BorderSizePixel = 0
			Header.Position = UDim2.new(0, 40, 0, 10)
			Header.Size = UDim2.new(1, -50, 0, 15)
			Header.ZIndex = 3
			Header.Font = Enum.Font.GothamBold
			Header.Text = Notify.Title
			Header.TextColor3 = Color3.fromRGB(255, 255, 255)
			Header.TextSize = 14.000
			Header.TextXAlignment = Enum.TextXAlignment.Left

			Body.Name = "Body"
			Body.Parent = NotifyFrame
			Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Body.BackgroundTransparency = 1.000
			Body.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Body.BorderSizePixel = 0
			Body.Position = UDim2.new(0, 10, 0, 33)
			Body.Size = UDim2.new(1, -15, 0, 30)
			Body.ZIndex = 3
			Body.Font = Enum.Font.GothamMedium
			Body.Text = Notify.Content
			Body.TextColor3 = Color3.fromRGB(255, 255, 255)
			Body.TextSize = 12.000
			Body.TextTransparency = 0.500
			Body.TextXAlignment = Enum.TextXAlignment.Left
			Body.TextYAlignment = Enum.TextYAlignment.Top

			TimeLeftFrame.Name = "TimeLeftFrame"
			TimeLeftFrame.Parent = NotifyFrame
			TimeLeftFrame.AnchorPoint = Vector2.new(0, 1)
			TimeLeftFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TimeLeftFrame.BackgroundTransparency = 1.000
			TimeLeftFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TimeLeftFrame.BorderSizePixel = 0
			TimeLeftFrame.Position = UDim2.new(0, 0, 1, 1)
			TimeLeftFrame.Size = UDim2.new(1, 0, 0, 5)
			TimeLeftFrame.ZIndex = 5

			UICorner_2.CornerRadius = UDim.new(0, 4)
			UICorner_2.Parent = TimeLeftFrame

			TimeLeft.Name = "TimeLeft"
			TimeLeft.Parent = TimeLeftFrame
			TimeLeft.BackgroundColor3 = Color3.fromRGB(0, 255, 110)
			TimeLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TimeLeft.BorderSizePixel = 0
			TimeLeft.Size = UDim2.new(0, 0, 1, 0)
			TimeLeft.ZIndex = 5

			UICorner_3.CornerRadius = UDim.new(0, 1)
			UICorner_3.Parent = TimeLeft
			
			local UpdateText = function()
				local TitleScale = TextService:GetTextSize(Header.Text,Header.TextSize,Header.Font,Vector2.new(math.huge,math.huge));
				local BodyScale = TextService:GetTextSize(Body.Text,Body.TextSize,Body.Font,Vector2.new(math.huge,math.huge));
				
				local MainX = (TitleScale.X >= BodyScale.X and TitleScale.X) or BodyScale.X;
				local MainY = TitleScale.Y + ((Body.Text:byte() and BodyScale.Y) or 1);
				
				BlockFrame.Size = UDim2.new(0, MainX + 45, 0, 0);
				
				Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
					Size = UDim2.new(0,MainX + 45,0,MainY + 35)
				});
			end;
			
			UpdateText();

			task.delay(0.25,function()
				Compkiller:_Animation(NotifyFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint),{
					Position = UDim2.new(0,0,0,0)
				});

				Compkiller:_Animation(TimeLeft,TweenInfo.new(Notify.Duration + 0.2,Enum.EasingStyle.Linear),{
					Size = UDim2.new(1, 0, 1, 0)
				});

				task.delay(Notify.Duration + 0.2,function()
					Compkiller:_Animation(NotifyFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quint),{
						Position = UDim2.new(1,200,0,0)
					});

					task.wait(0.3);

					Compkiller:_Animation(BlockFrame,TweenInfo.new(0.3),{
						Size = UDim2.new(1,0,0,0)
					});

					task.wait(0.35)
					BlockFrame:Destroy();

				end)
			end)
		end,
	};
end;

return Compkiller;
