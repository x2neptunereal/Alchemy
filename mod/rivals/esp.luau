export type ESPConfig = {
	Scale: number,
	Direction: number,
};

cloneref = cloneref or function(f) return f end;

local RunService: RunService = cloneref(game:GetService('RunService'));
local CORE_GUI: PlayerGui = game:FindFirstChild('CoreGui') or cloneref(game:GetService('Players').LocalPlayer.PlayerGui);
local Camera: Camera = workspace.CurrentCamera;

local MonacoESP = {
	ParentWalls = workspace.Camera,	
};

function MonacoESP:GetSize(Instance : BasePart | Model) : UDim2
	if Instance:IsA('BasePart') then
		return UDim2.new(Instance.Size.X + 1,100,Instance.Size.Y + 1,100);
	elseif Instance:IsA('Model') then
		local world = Instance:GetModelSize();

		return UDim2.new(world.X + 1,100,world.Y + 1,100);
	end;
end;

function MonacoESP.new(Config: ESPConfig)
	Config = Config or {};
	Config.Scale = Config.Scale or 0.025;
	Config.Direction = Config.Direction or 2;

	local Monacro = {
		Highligt = {
			Normal = {
				FillColor = Color3.fromRGB(0, 255, 149),
				OutlineColor = Color3.fromRGB(255, 255, 255),
				FillTransparency = 0.5,
				OutlineTransparency = 0,
			},
			Walls = {
				FillColor = Color3.fromRGB(255, 143, 121),
				OutlineColor = Color3.fromRGB(255, 255, 255),
				FillTransparency = 0.5,
				OutlineTransparency = 0,
			}
		},
	};

	Monacro.__cache = {};

	function Monacro:DrawHighlight(Model: Model)
		local Drawing = Monacro:IsDraw(Model);

		if Drawing and Drawing.Highlight then
			return;
		end;

		local _Highlight = {};

		_Highlight.__signal = {};
		_Highlight.__cache = {
			Original = {},
			Clone = {},
		};
		
		for i,v: BasePart in next , Model:GetDescendants() do
			if v:IsA('MeshPart') or v:IsA('UnionOperation') then
				v:SetAttribute("MONACROID",i);

				_Highlight.__cache.Original[i] = v;
			elseif v:IsA('Script') or v:IsA('LocalScript') then
				v:Destroy();
			end;
		end;
		
		Model.Archivable = true;

		local CloneModel = Model:Clone();

		CloneModel.Parent = MonacoESP.ParentWalls;
		CloneModel.Name = tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));

		if CloneModel:FindFirstChildWhichIsA('Humanoid') then
			local Humanoid = CloneModel:FindFirstChildWhichIsA('Humanoid');

			Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
			Humanoid.HealthDisplayDistance = 0;
			Humanoid.NameDisplayDistance = 0;
			Humanoid.BreakJointsOnDeath = false;
			Humanoid.EvaluateStateMachine = false;
			Humanoid.RequiresNeck = false;
		end;
		
		for i,v: BasePart in next , CloneModel:GetDescendants() do
			if v:IsA('MeshPart') or v:IsA('UnionOperation') then
				local ID = v:GetAttribute("MONACROID");
				if ID then
					
					_Highlight.__cache.Clone[ID] = v;

					v.CanCollide = false;
					v.Size -= Vector3.new(Config.Scale,Config.Scale,Config.Scale);
					v.Anchored = true;

					local Original = _Highlight.__cache.Original[ID];

					if Original then
						local Direction = Vector3.zero;
						
						table.insert(_Highlight.__signal , task.spawn(function()
							while true do task.wait()
								v.CFrame = Original.CFrame;
								v.Position += Direction;
								v.Transparency = 0;
								v.Anchored = true;

								Direction = (Original.Position - Camera.CFrame.Position).Unit * Config.Direction;
							end;
						end));
					end;
				end;
			end;
		end;

		local NormalHighlight = Instance.new('Highlight');
		local WallsHighlight = Instance.new('Highlight');

		local UpdateHighlight = function()
			NormalHighlight.DepthMode = Enum.HighlightDepthMode.Occluded;
			NormalHighlight.Enabled = true;
			NormalHighlight.FillColor = Monacro.Highligt.Normal.FillColor;
			NormalHighlight.FillTransparency = Monacro.Highligt.Normal.FillTransparency;
			NormalHighlight.OutlineColor = Monacro.Highligt.Normal.OutlineColor;
			NormalHighlight.OutlineTransparency = Monacro.Highligt.Normal.OutlineTransparency;
			NormalHighlight.Parent = CORE_GUI;
			NormalHighlight.Adornee = Model;

			WallsHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
			WallsHighlight.Enabled = true;
			WallsHighlight.FillColor = Monacro.Highligt.Walls.FillColor;
			WallsHighlight.FillTransparency = Monacro.Highligt.Walls.FillTransparency;
			WallsHighlight.OutlineColor = Monacro.Highligt.Walls.OutlineColor;
			WallsHighlight.OutlineTransparency = Monacro.Highligt.Walls.OutlineTransparency;
			WallsHighlight.Parent = CORE_GUI;
			WallsHighlight.Adornee = CloneModel;
		end;

		table.insert(_Highlight.__signal , RunService.Heartbeat:Connect(UpdateHighlight));

		function _Highlight:Destroy()
			Monacro.__cache[Model].Highlight = nil;

			for i,v in next , _Highlight.__signal do
				if typeof(v) == "thread" then
					task.cancel(v);
				else	
					v:Disconnect();
				end;
			end;

			NormalHighlight:Destroy();
			WallsHighlight:Destroy();

			table.clear(_Highlight.__cache.Clone);
			table.clear(_Highlight.__cache.Original);

			if not Monacro.__cache[Model].Highlight and not Monacro.__cache[Model].ESP then
				Monacro.__cache[Model] = nil;	
			end;

			CloneModel:Destroy();
		end;

		table.insert(_Highlight.__signal , Model:GetPropertyChangedSignal('Parent'):Connect(function()
			if not Model.Parent then
				_Highlight:Destroy();
			end;
		end));

		Monacro.__cache[Model] = Monacro.__cache[Model] or {};

		Monacro.__cache[Model].Highlight = _Highlight;

		return _Highlight;
	end;

	function Monacro:DrawUI(Model: Model)
		local Drawing = Monacro:IsDraw(Model);

		if Drawing and Drawing.ESP then
			return;
		end;

		local _ESP = {};
		local Scale = MonacoESP:GetSize(Model);

		_ESP.__signal = {};

		local BillboardGui = Instance.new("BillboardGui")
		local MainFrame = Instance.new("Frame")
		local BoxFrame = Instance.new("Frame")
		local TopLeftRight = Instance.new("Frame")
		local TopLeftDown = Instance.new("Frame")
		local TopRightLeft = Instance.new("Frame")
		local TopRightDown = Instance.new("Frame")
		local BottomRightUp = Instance.new("Frame")
		local BottomRightLeft = Instance.new("Frame")
		local BottomLeftRight = Instance.new("Frame")
		local BottomLeftUp = Instance.new("Frame")
		local ESPLabel = Instance.new("TextLabel")
		local HealthBar = Instance.new("Frame")
		local HealthValue = Instance.new("Frame")
		local OtherLabel = Instance.new("TextLabel")

		BillboardGui.Name = tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));
		BillboardGui.Parent = CORE_GUI;
		BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		BillboardGui.Active = true
		BillboardGui.Adornee = Model
		BillboardGui.AlwaysOnTop = true
		BillboardGui.LightInfluence = 1.000
		BillboardGui.Size = Scale

		MainFrame.Name = "MainFrame"
		MainFrame.Parent = BillboardGui
		MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MainFrame.BackgroundTransparency = 1.000
		MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainFrame.BorderSizePixel = 0
		MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		MainFrame.Size = UDim2.new(1, -95, 1, -95)

		BoxFrame.Name = "BoxFrame"
		BoxFrame.Parent = MainFrame
		BoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BoxFrame.BackgroundTransparency = 1.000
		BoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BoxFrame.BorderSizePixel = 0
		BoxFrame.Size = UDim2.new(1, 0, 1, 0)

		TopLeftRight.Name = "TopLeftRight"
		TopLeftRight.Parent = BoxFrame
		TopLeftRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopLeftRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopLeftRight.BorderSizePixel = 0
		TopLeftRight.Size = UDim2.new(0.349999994, 0, 0, 1)

		TopLeftDown.Name = "TopLeftDown"
		TopLeftDown.Parent = BoxFrame
		TopLeftDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopLeftDown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopLeftDown.BorderSizePixel = 0
		TopLeftDown.Size = UDim2.new(0, 1, 0.349999994, 0)

		TopRightLeft.Name = "TopRightLeft"
		TopRightLeft.Parent = BoxFrame
		TopRightLeft.AnchorPoint = Vector2.new(1, 0)
		TopRightLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopRightLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopRightLeft.BorderSizePixel = 0
		TopRightLeft.Position = UDim2.new(1, 0, 0, 0)
		TopRightLeft.Size = UDim2.new(0.349999994, 0, 0, 1)

		TopRightDown.Name = "TopRightDown"
		TopRightDown.Parent = BoxFrame
		TopRightDown.AnchorPoint = Vector2.new(1, 0)
		TopRightDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopRightDown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopRightDown.BorderSizePixel = 0
		TopRightDown.Position = UDim2.new(1, 0, 0, 0)
		TopRightDown.Size = UDim2.new(0, 1, 0.349999994, 0)

		BottomRightUp.Name = "BottomRightUp"
		BottomRightUp.Parent = BoxFrame
		BottomRightUp.AnchorPoint = Vector2.new(1, 1)
		BottomRightUp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomRightUp.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomRightUp.BorderSizePixel = 0
		BottomRightUp.Position = UDim2.new(1, 0, 1, 0)
		BottomRightUp.Size = UDim2.new(0, 1, 0.349999994, 0)

		BottomRightLeft.Name = "BottomRightLeft"
		BottomRightLeft.Parent = BoxFrame
		BottomRightLeft.AnchorPoint = Vector2.new(1, 1)
		BottomRightLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomRightLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomRightLeft.BorderSizePixel = 0
		BottomRightLeft.Position = UDim2.new(1, 0, 1, 0)
		BottomRightLeft.Size = UDim2.new(0.349999994, 0, 0, 1)

		BottomLeftRight.Name = "BottomLeftRight"
		BottomLeftRight.Parent = BoxFrame
		BottomLeftRight.AnchorPoint = Vector2.new(0, 1)
		BottomLeftRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomLeftRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomLeftRight.BorderSizePixel = 0
		BottomLeftRight.Position = UDim2.new(0, 0, 1, 0)
		BottomLeftRight.Size = UDim2.new(0.349999994, 0, 0, 1)

		BottomLeftUp.Name = "BottomLeftUp"
		BottomLeftUp.Parent = BoxFrame
		BottomLeftUp.AnchorPoint = Vector2.new(0, 1)
		BottomLeftUp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomLeftUp.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomLeftUp.BorderSizePixel = 0
		BottomLeftUp.Position = UDim2.new(0, 0, 1, 0)
		BottomLeftUp.Size = UDim2.new(0, 1, 0.349999994, 0)

		ESPLabel.Name = "ESPLabel"
		ESPLabel.Parent = MainFrame
		ESPLabel.AnchorPoint = Vector2.new(0.5, 0)
		ESPLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ESPLabel.BackgroundTransparency = 1.000
		ESPLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ESPLabel.BorderSizePixel = 0
		ESPLabel.Position = UDim2.new(0.5, 0, 0, -20)
		ESPLabel.Size = UDim2.new(1, 0, 0, 15)
		ESPLabel.Font = Enum.Font.GothamMedium
		ESPLabel.Text = "ESP"
		ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ESPLabel.TextScaled = true
		ESPLabel.TextSize = 14.000
		ESPLabel.TextStrokeTransparency = 0.750
		ESPLabel.TextWrapped = true
		ESPLabel.TextYAlignment = Enum.TextYAlignment.Bottom

		HealthBar.Name = "HealthBar"
		HealthBar.Parent = MainFrame
		HealthBar.AnchorPoint = Vector2.new(0, 0.5)
		HealthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
		HealthBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		HealthBar.BorderSizePixel = 0
		HealthBar.Position = UDim2.new(0, -7, 0.5, 0)
		HealthBar.Size = UDim2.new(0, 5, 1, 0)

		HealthValue.Name = "HealthValue"
		HealthValue.Parent = HealthBar
		HealthValue.AnchorPoint = Vector2.new(0.5, 1)
		HealthValue.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
		HealthValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		HealthValue.BorderSizePixel = 0
		HealthValue.Position = UDim2.new(0.5, 0, 1, 0)
		HealthValue.Size = UDim2.new(1, 0, 0.5, 0)

		OtherLabel.Name = "OtherLabel"
		OtherLabel.Parent = MainFrame
		OtherLabel.AnchorPoint = Vector2.new(0.5, 0)
		OtherLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		OtherLabel.BackgroundTransparency = 1.000
		OtherLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OtherLabel.BorderSizePixel = 0
		OtherLabel.Position = UDim2.new(0.5, 0, 1, 5)
		OtherLabel.Size = UDim2.new(1, 0, 0, 15)
		OtherLabel.Font = Enum.Font.GothamMedium
		OtherLabel.Text = "ENEMIE"
		OtherLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		OtherLabel.TextScaled = true
		OtherLabel.TextSize = 14.000
		OtherLabel.TextStrokeTransparency = 0.750
		OtherLabel.TextWrapped = true
		OtherLabel.TextYAlignment = Enum.TextYAlignment.Top

		function _ESP:SetBox(visible)
			if visible then
				BoxFrame.Visible = true;
			else
				BoxFrame.Visible = false;
			end;
		end;

		function _ESP:SetLabel(name)
			ESPLabel.Text = name;
		end;

		function _ESP:SetDescLabel(name)
			OtherLabel.Text = name;
		end;

		function _ESP:SetHealthVisible(visible)
			if visible then
				HealthBar.Visible = true;
			else
				HealthBar.Visible = false;
			end;
		end;

		function _ESP:SetHealth(num)
			HealthValue.Size = UDim2.new(1, 0, num, 0)
		end;

		function _ESP:Visible(visible)
			if visible then
				BillboardGui.Enabled = true;
			else
				BillboardGui.Enabled = false;
			end;
		end;

		function _ESP:SetBoxColor(color)
			TopLeftRight.BackgroundColor3 = color;
			TopLeftDown.BackgroundColor3 = color;
			TopRightLeft.BackgroundColor3 = color;
			TopRightDown.BackgroundColor3 = color;
			BottomRightUp.BackgroundColor3 = color;
			BottomRightLeft.BackgroundColor3 = color;
			BottomLeftRight.BackgroundColor3 = color;
			BottomLeftUp.BackgroundColor3 = color;
		end;

		Monacro.__cache[Model] = Monacro.__cache[Model] or {};

		Monacro.__cache[Model].ESP = _ESP;

		function _ESP:Destroy()
			Monacro.__cache[Model].ESP = nil;

			if not Monacro.__cache[Model].Highlight and not Monacro.__cache[Model].ESP then
				Monacro.__cache[Model] = nil;	
			end;

			for i,v in next , _ESP.__signal do
				if v then
					v:Disconnect();
				end;
			end;

			BillboardGui:Destroy();
		end;

		table.insert(_ESP.__signal , Model:GetPropertyChangedSignal('Parent'):Connect(function()
			if not Model.Parent then
				_ESP:Destroy();
			end;
		end));

		return _ESP;
	end;

	function Monacro:IsDraw(Model: Model)
		return Monacro.__cache[Model];
	end;

	function Monacro:ClearAll()
		for i,v in next,Monacro.__cache do
			if v then
				if v.Highlight then
					v.Highlight:Destroy();
				end;

				if v.ESP then
					v.ESP:Destroy();
				end;

				Monacro.__cache[i] = nil;
			end;
		end;
	end;

	function Monacro:GeneratePreviewBox(Zindex)
		local MainFrame = Instance.new("Frame")
		local BoxFrame = Instance.new("Frame")
		local TopLeftRight = Instance.new("Frame")
		local TopLeftDown = Instance.new("Frame")
		local TopRightLeft = Instance.new("Frame")
		local TopRightDown = Instance.new("Frame")
		local BottomRightUp = Instance.new("Frame")
		local BottomRightLeft = Instance.new("Frame")
		local BottomLeftRight = Instance.new("Frame")
		local BottomLeftUp = Instance.new("Frame")
		local ESPLabel = Instance.new("TextLabel")
		local HealthBar = Instance.new("Frame")
		local HealthValue = Instance.new("Frame")
		local OtherLabel = Instance.new("TextLabel")

		MainFrame.Name = "MainFrame"
		MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MainFrame.BackgroundTransparency = 1.000
		MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainFrame.BorderSizePixel = 0
		MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		MainFrame.Size = UDim2.new(1, -95, 1, -95)
		MainFrame.ZIndex = Zindex;

		BoxFrame.Name = "BoxFrame"
		BoxFrame.Parent = MainFrame
		BoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BoxFrame.BackgroundTransparency = 1.000
		BoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BoxFrame.BorderSizePixel = 0
		BoxFrame.Size = UDim2.new(1, 0, 1, 0)
		BoxFrame.ZIndex = Zindex + 1;

		TopLeftRight.Name = "TopLeftRight"
		TopLeftRight.Parent = BoxFrame
		TopLeftRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopLeftRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopLeftRight.BorderSizePixel = 0
		TopLeftRight.Size = UDim2.new(0.349999994, 0, 0, 1)
		TopLeftRight.ZIndex = Zindex + 1;

		TopLeftDown.Name = "TopLeftDown"
		TopLeftDown.Parent = BoxFrame
		TopLeftDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopLeftDown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopLeftDown.BorderSizePixel = 0
		TopLeftDown.Size = UDim2.new(0, 1, 0.349999994, 0)
		TopLeftDown.ZIndex = Zindex + 1;

		TopRightLeft.Name = "TopRightLeft"
		TopRightLeft.Parent = BoxFrame
		TopRightLeft.AnchorPoint = Vector2.new(1, 0)
		TopRightLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopRightLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopRightLeft.BorderSizePixel = 0
		TopRightLeft.Position = UDim2.new(1, 0, 0, 0)
		TopRightLeft.Size = UDim2.new(0.349999994, 0, 0, 1)
		TopRightLeft.ZIndex = Zindex + 1;

		TopRightDown.Name = "TopRightDown"
		TopRightDown.Parent = BoxFrame
		TopRightDown.AnchorPoint = Vector2.new(1, 0)
		TopRightDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopRightDown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TopRightDown.BorderSizePixel = 0
		TopRightDown.Position = UDim2.new(1, 0, 0, 0)
		TopRightDown.Size = UDim2.new(0, 1, 0.349999994, 0)
		TopRightDown.ZIndex = Zindex + 1;

		BottomRightUp.Name = "BottomRightUp"
		BottomRightUp.Parent = BoxFrame
		BottomRightUp.AnchorPoint = Vector2.new(1, 1)
		BottomRightUp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomRightUp.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomRightUp.BorderSizePixel = 0
		BottomRightUp.Position = UDim2.new(1, 0, 1, 0)
		BottomRightUp.Size = UDim2.new(0, 1, 0.349999994, 0)
		BottomRightUp.ZIndex = Zindex + 1;

		BottomRightLeft.Name = "BottomRightLeft"
		BottomRightLeft.Parent = BoxFrame
		BottomRightLeft.AnchorPoint = Vector2.new(1, 1)
		BottomRightLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomRightLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomRightLeft.BorderSizePixel = 0
		BottomRightLeft.Position = UDim2.new(1, 0, 1, 0)
		BottomRightLeft.Size = UDim2.new(0.349999994, 0, 0, 1)
		BottomRightLeft.ZIndex = Zindex + 1;

		BottomLeftRight.Name = "BottomLeftRight"
		BottomLeftRight.Parent = BoxFrame
		BottomLeftRight.AnchorPoint = Vector2.new(0, 1)
		BottomLeftRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomLeftRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomLeftRight.BorderSizePixel = 0
		BottomLeftRight.Position = UDim2.new(0, 0, 1, 0)
		BottomLeftRight.Size = UDim2.new(0.349999994, 0, 0, 1)
		BottomLeftRight.ZIndex = Zindex + 1;

		BottomLeftUp.Name = "BottomLeftUp"
		BottomLeftUp.Parent = BoxFrame
		BottomLeftUp.AnchorPoint = Vector2.new(0, 1)
		BottomLeftUp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BottomLeftUp.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BottomLeftUp.BorderSizePixel = 0
		BottomLeftUp.Position = UDim2.new(0, 0, 1, 0)
		BottomLeftUp.Size = UDim2.new(0, 1, 0.349999994, 0)
		BottomLeftUp.ZIndex = Zindex + 1;

		ESPLabel.Name = "ESPLabel"
		ESPLabel.Parent = MainFrame
		ESPLabel.AnchorPoint = Vector2.new(0.5, 0)
		ESPLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ESPLabel.BackgroundTransparency = 1.000
		ESPLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ESPLabel.BorderSizePixel = 0
		ESPLabel.Position = UDim2.new(0.5, 0, 0, -20)
		ESPLabel.Size = UDim2.new(1, 0, 0, 15)
		ESPLabel.Font = Enum.Font.GothamMedium
		ESPLabel.Text = "PLAYER"
		ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ESPLabel.TextScaled = true
		ESPLabel.TextSize = 14.000
		ESPLabel.TextStrokeTransparency = 0.750
		ESPLabel.TextWrapped = true
		ESPLabel.TextYAlignment = Enum.TextYAlignment.Bottom
		ESPLabel.ZIndex = Zindex + 1;

		HealthBar.Name = "HealthBar"
		HealthBar.Parent = MainFrame
		HealthBar.AnchorPoint = Vector2.new(0, 0.5)
		HealthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
		HealthBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		HealthBar.BorderSizePixel = 0
		HealthBar.Position = UDim2.new(0, -7, 0.5, 0)
		HealthBar.Size = UDim2.new(0, 5, 1, 0)
		HealthBar.ZIndex = Zindex + 1;

		HealthValue.Name = "HealthValue"
		HealthValue.Parent = HealthBar
		HealthValue.AnchorPoint = Vector2.new(0.5, 1)
		HealthValue.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
		HealthValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
		HealthValue.BorderSizePixel = 0
		HealthValue.Position = UDim2.new(0.5, 0, 1, 0)
		HealthValue.Size = UDim2.new(1, 0, 0.5, 0)
		HealthValue.ZIndex = Zindex + 1;

		OtherLabel.Name = "OtherLabel"
		OtherLabel.Parent = MainFrame
		OtherLabel.AnchorPoint = Vector2.new(0.5, 0)
		OtherLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		OtherLabel.BackgroundTransparency = 1.000
		OtherLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OtherLabel.BorderSizePixel = 0
		OtherLabel.Position = UDim2.new(0.5, 0, 1, 5)
		OtherLabel.Size = UDim2.new(1, 0, 0, 15)
		OtherLabel.Font = Enum.Font.GothamMedium
		OtherLabel.Text = "WEAPON"
		OtherLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		OtherLabel.TextScaled = true
		OtherLabel.TextSize = 14.000
		OtherLabel.TextStrokeTransparency = 0.750
		OtherLabel.TextWrapped = true
		OtherLabel.TextYAlignment = Enum.TextYAlignment.Top
		OtherLabel.ZIndex = Zindex + 1;

		local _Preview = {};

		function _Preview:SetText(Main,Second)
			ESPLabel.Text = Main;
			OtherLabel.Text = Second or "";
		end;

		function _Preview:SetHealthVisible(visible)
			if visible then
				HealthBar.Visible = true;
			else
				HealthBar.Visible = false;
			end;
		end;

		function _Preview:SetBoxVisible(visible)
			if visible then
				BoxFrame.Visible = true;
			else
				BoxFrame.Visible = false;
			end;
		end;

		function _Preview:SetColor(color)
			TopLeftRight.BackgroundColor3 = color;
			TopLeftDown.BackgroundColor3 = color;
			TopRightLeft.BackgroundColor3 = color;
			TopRightDown.BackgroundColor3 = color;
			BottomRightUp.BackgroundColor3 = color;
			BottomRightLeft.BackgroundColor3 = color;
			BottomLeftRight.BackgroundColor3 = color;
			BottomLeftUp.BackgroundColor3 = color;
		end;

		function _Preview:GetRoot()
			return MainFrame;
		end;

		function _Preview:SetParent(p)
			MainFrame.Parent = p;
		end;

		return _Preview;
	end;

	return Monacro;
end;

return MonacoESP;
