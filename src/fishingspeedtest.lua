local getRod = function()
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

local isBusy = function()
	--local RodClientScript = getRod()
	--local bobber = RodClientScript:FindFirstChild("bobber")
	if not(game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("shakeui")) and not(game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("reel")) then
		return false
	end
	return true
end

local isCount = false
local tickCount = nil

local inCount = true
local catchCount = 0
local catchData = {}

local threadCount = 0

local setting = ({...})[1]

print("[ Auto Fishing Speed Test ]")
print(setting.hub .. " Hub / Rod : "..getRod().Name.." / Ping : "..game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString())
print("( Test By x2Neptune )")

task.spawn(function()
    while task.wait() do
        if inCount then
            if #catchData >= setting.average then
                inCount = false
                table.foreach(catchData, function(i, v)
                    threadCount = threadCount + v
                end)
                print("Average Catch is " .. tostring(threadCount / setting.average) .. "s")
            else
                local bobber = getRod():FindFirstChild("bobber")
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
                        print("["..catchCount.."] Catch in " .. tostring(catchIn) .. "s")
                        table.insert(catchData, catchIn)
                    end
                end
            end
        end
    end
end)
