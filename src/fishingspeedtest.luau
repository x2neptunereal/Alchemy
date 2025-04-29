local getRod : () -> Instance = function()
    local playerName = game.Players.LocalPlayer.Name
	local rod = nil
	
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.ClassName == "Tool" and v.ToolTip == "fisch" then
			rod = v
		end
	end
	for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v.ClassName == "Tool" and v.ToolTip == "fisch" then
			rod = v
		end
	end
	return rod
end

local isBusy : () -> Instance = function()
	return game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("shakeui") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("reel")
end

local isCount : boolean = false
local tickCount : any = nil

local inCount : boolen = true
local catchCount : number = 0
local catchData : {} = {}

local threadCount : number = 0

local config : {} = ({...})[1]
local setting : {} = setmetatable(config, {
    __index = function(table : {}, data : any)
        warn(string.format("Config %s not found!", tostring(data)))

        if data == "average" then
            return 10
        else
            return "N/A"
        end
    end
})

print(string.format(
    "[ Auto Fishing Speed Test : %s Hub ]\n- Rod : %s\n- Ping : %s\n- Average : %d\n( Test By x2Neptune )",
    setting.hub, getRod().Name, game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), setting.average
))

task.spawn(function()
    while task.wait() do
        if inCount then
            if #catchData >= setting.average then
                inCount = false
                table.foreach(catchData, function(i : index, v : value)
                    threadCount = threadCount + v
                end)
                print(string.format("Average Catch is %ds", threadCount / setting.average))
            else
                local bobber : Instance = getRod():FindFirstChild("bobber")
                if bobber and isBusy() then
                    if not isCount then
                        isCount = true
                        tickCount = tick()
                    end
                elseif not(bobber) and not(isBusy()) then
                    if isCount then
                        local catchIn = tick() - tickCount

                        isCount = false
                        catchCount = catchCount + 1
                        print(string.format("[%d] Catch in %ds", catchCount, catchIn))
                        table.insert(catchData, catchIn)
                    end
                end
            end
        end
    end
end)
