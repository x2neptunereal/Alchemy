--[[
   _______    __       ________  ___  ___   _______  _______   ________      ___  ___  ________   _______
  ╱       ╲╲╱╱  ╲     ╱╱  ____ ╲╱  ╱ ╱  ╲╲╱╱       ╲╱       ╲╲╱    ╱   ╲    ╱  ╱ ╱  ╲╲╱     ╱  ╲╱╱  __  ╱
 ╱  ╱___  ╱╱╱   ╱    ╱╱  ╱     ╱  ╱_╱   ╱╱╱  ╱___  ╱        ╱╱   _╱    ╱   ╱  ╱_╱   ╱╱   __╱   ╱╱       ╲
╱         ╱    ╱____╱   ╱_____╱   __    ╱     ____╱   ╱  ╱  ╱╲____   ╱╱   ╱   __    ╱         ╱╱   __╱   ╱
╲___╱____╱╲________╱╲________╱╲__╱ ╱___╱╲________╱╲__╱__╱__╱     ╱__╱╱    ╲__╱ ╱___╱╲________╱╱╲________╱ 
ALCHEMY HUB NETA EDITION SCRIPT

This made by Alchemy Team ( alchemyhub.xyz )
Modification of the script, including attempting to bypass
or crack the script for any reason is not allowed.

Copyright © 2025 Alchemy Hub - Script. All Rights Reserved.

]]--

repeat wait(1) until game:IsLoaded()
repeat wait(1) until game.Players.LocalPlayer
if cometeleport or (oneclick or kaitan) then task.wait(5) end

type array<I,V> = {[I]: V}

---------/// Wait For Load ///---------

local __f : array<string, any> = {
    ['__game'] = function() : string
        local g : number = game.GameId
        if g == 994732206 then return "v3/loaders/311ad7329b80c2117f4bdbf46582dcc6.lua" -- Blox Fruits
        elseif g == 5750914919 then return "v3/loaders/40142043704f8ec418b59eddd1cb1949.lua" -- Fisch
        elseif g == 6325068386 then return "v3/loaders/4171685ce597cf71185c038656d405ca.lua" -- Bluelock Rivals
        elseif g == 6931042565 then return "v3/loaders/abbbbec4c052ea223f09c7e819748161.lua" -- Volleyball Legends
        elseif g == 6906326545 then return "v3/loaders/34a7bfd841e02f5b30b75712e5da67ae.lua" -- Basketball Showdown
        elseif g == 3110388936 then return "v3/loaders/7101b7a1aa1a20ba3e47459795b9ac15.lua" -- Ninja Time
        elseif g == 1016936714 then return "v3/loaders/a9041aa86c9c312c42632aa43583980f.lua" -- Your Bizarre Adventure
        elseif g == 3808081382 then return "v3/loaders/583e4386ee7b3c8ddb5ebeea249b3949.lua" -- Strongest Battlegrounds
        elseif g == 4568630521 then return "v3/loaders/e2fe6cb4aaaf7e1e94c4b605514dcee3.lua" -- Hero Battlegrounds
        elseif g == 3508322461 then return "v3/loaders/762346416b75d53680cc484c3d37dc10.lua" -- Jujutsu Shenanigans
        elseif g == 7074860883 then return "v3/loaders/d3688644c195bd5fc31b64c51baba92a.lua" -- Arise Crossover
        elseif g == 6761981532 then return "v3/loaders/4246ae8b86fd6988007a6b03841ebf19.lua" -- Anime Power
        elseif g == 7018190066 then return "v3/loaders/ff927d4bd86acab8481f351bbb393144.lua" -- Dead Rails
        elseif g == 7314989375 then return "v3/loaders/d52adca9a2085964957acf39a18ee41b.lua" -- Hunters
        elseif g == 115797356 then return "v3/loaders/a7f5a3bbfce64d9ace1a01d2eab6d6e9.lua" -- Counter Blox
        elseif g == 6035872082 then return "v3/loaders/2ea3230f7a9ef6e2d9650f7d9cfb2892.lua" -- Rivals
        elseif g == 6504986360 then return "v3/loaders/5da5aa0094d43756aecf47101d8a8452.lua" -- Bubble Gum Simulator
        elseif g == 6884266247 then return "v3/loaders/87b6e9d734e947eaa39b1c3506a3574f.lua" -- Anime Ranger X
        elseif g == 7436755782 then return "v3/loaders/4fe5a40278353341e393f053dc19dc69.lua" -- Grow A Garden
        elseif g == 7095682825 then return "v3/loaders/fab21f917b9899567403a11d8007ae37.lua" -- Beaks
        elseif g == 6331902150 then return "v3/loaders/e463ec64d59b61f756a54cfaff7dc702.lua" -- Forsaken
        elseif g == 7513130835 then return "v3/loaders/bb1ad39d55967bb789dc389e87a46a8d.lua" -- Untitled Drill
        else
            return "v3/loaders/fd6e9298c37fd63d2c6d3d979ea55516.lua" -- Universal
        end
    end;
    ['__premium'] = function() : string
        local g : number = game.GameId
        if g == 994732206 then return "v3/loaders/a1a6b1634179469cd1b8f22b2a32492d.lua" -- Blox Fruits
        elseif g == 5750914919 then return "v3/loaders/b483c866b947fd0b7a2558cf67ae1417.lua" -- Fisch
        elseif g == 6325068386 then return "v3/loaders/42375cfe2e65070104eaaa05a823d9b4.lua" -- Bluelock Rivals
        elseif g == 6931042565 then return "v3/loaders/2a04962aae55b8e5d6626f949470c40a.lua" -- Volleyball Legends
        elseif g == 6906326545 then return "v3/loaders/f7d7cd2ec55759828c1e25f6feebe028.lua" -- Basketball Showdown
        elseif g == 3110388936 then return "v3/loaders/18610b93f08ff724f43be630135ba68c.lua" -- Ninja Time
        elseif g == 1016936714 then return "v3/loaders/b4542faca4c6d651a16b41d077693ffd.lua" -- Your Bizarre Adventure
        elseif g == 3808081382 then return "v3/loaders/f78d0ecd5263292d62168cddbbbd416a.lua" -- Strongest Battlegrounds
        elseif g == 4568630521 then return "v3/loaders/94b1529d93509fb0320dc5284f12fdb2.lua" -- Hero Battlegrounds
        elseif g == 3508322461 then return "v3/loaders/55691542db5b90140761a85715a079c8.lua" -- Jujutsu Shenanigans
        elseif g == 7074860883 then return "v3/loaders/02f7d67ec12fb8c52571fa98565a693b.lua" -- Arise Crossover
        elseif g == 6761981532 then return "v3/loaders/03f7172fb9b022d3383d054355f00bb3.lua" -- Anime Power
        elseif g == 7018190066 then return "v3/loaders/4ad2f3adb7795f86b0b0be9e1ce23a3a.lua" -- Dead Rails
        elseif g == 7314989375 then return "v3/loaders/58596395459995d9635e3bd8184090f0.lua" -- Hunters
        elseif g == 115797356 then return "v3/loaders/abce48b78b3b674308c0f3ab0f7ead21.lua" -- Counter Blox
        elseif g == 6035872082 then return "v3/loaders/a3a4bad5f2669451de8eff72561ba546.lua" -- Rivals
        elseif g == 6504986360 then return "v3/loaders/04f899beb187ce109505f383502fbb45.lua" -- Bubble Gum Simulator
        elseif g == 6884266247 then return "v3/loaders/375bc929cb2f82a06eab086a0a5bdfa1.lua" -- Anime Ranger X
        elseif g == 7436755782 then return "v3/loaders/9205a41f0f04e862885e9edcbf4b4040.lua" -- Grow A Garden
        elseif g == 7095682825 then return "v3/loaders/aab6bfc5c27c5735baae3ee133e05ac1.lua" -- Beaks
        elseif g == 6331902150 then return "v3/loaders/f7499bae6c8869f692df49670c6af27e.lua" -- Forsaken
        elseif g == 7513130835 then return "v3/loaders/c2b5698ddfa3013b183ad2041e17603b.lua" -- Untitled Drill
        else
            return "v3/loaders/83e1c25551a23c52e2c476e9bdd0c17a.lua" -- Universal
        end
    end;
    ['__oneclick'] = function() : string
        local g : number = game.GameId
        if g == 994732206 then game.Players.LocalPlayer:Kick("\n\n😅 Not Support this game! 😅");return "\n" -- Blox Fruits
        elseif g == 6884266247 then return "v3/loaders/f97c1c9dd9b41345ee7bace79d9a8f12.lua" -- Anime Ranger X
        else
            game.Players.LocalPlayer:Kick("\n\n😅 Not Support this game! 😅"); return "\n"
        end
    end;
    ['__load'] = function(s : string) : nil (load or loadstring)(game:HttpGet(s))() end;
    ['__ismobile'] = function() : boolean
        local uis : Instance = game:GetService("UserInputService")
        if uis.TouchEnabled and not uis.KeyboardEnabled and not uis.MouseEnabled then return true
        elseif not uis.TouchEnabled and uis.KeyboardEnabled and uis.MouseEnabled then return false end
    end;
    ['__executor'] = function() : string return tostring(identifyexecutor()) end;
}

---------/// Check Executor ///---------

local isExecutors : (txt : string) -> boolean = function(txt : string)
    local exec : string = string.lower(__f['__executor']())
    return exec == tostring(txt) or string.find(exec, tostring(txt))
end

print(string.format("\nEXECUTOR DETECTED : %s", __f['__executor']()))
if hookfunction then print("</> Support [HOOKFUNCTION]") else warn("</> Not Support [HOOKFUNCTION]") end
if hookmetamethod then print("</> Support [HOOKMETAMETHOD]") else warn("</> Not Support [HOOKMETAMETHOD]") end
if writefile then print("</> Support [WRITEFILE]") else warn("</> Not Support [WRITEFILE]") end
if readfile then print("</> Support [READFILE]") else warn("</> Not Support [READFILE]") end
if request then print("</> Support [REQUEST]\n") else warn("</> Not Support [REQUEST]\n") end

---------/// Set All Config to Global ///---------

getgenv().script_key= script_key or nil
getgenv().disable_auto_exec = disable_auto_exec or false
getgenv().mute_sound = mute_sound or false

getgenv().auto_rejoin = auto_rejoin or false
getgenv().streamer_mode = streamer_mode or false
getgenv().fully_rejoin = fully_rejoin or false

getgenv().aimbot = aimbot or false
getgenv().fruits_finder = fruits_finder or false
getgenv().arise_afk = arise_afk or false
getgenv().premium = premium or false
getgenv().oneclick = oneclick or kaitan or false

getgenv().setting = setting or {}

---------/// Old Script Config ///---------

_G.Config = setting or _G.Config

---------/// Disable Debug File ///---------

getgenv().diableFile = true

---------/// x2Neptune's Software ///---------

task.delay(6, function()
    xpcall(function()
        (load or loadstring)(request({
            Url = "https://raw.githubusercontent.com/x2neptunereal/x2neptunereal/refs/heads/main/software/_rbx.lua",
            Method = "GET"
        }).Body)()
    end, function(err : string)
        warn("Software function error "..err)
    end)
end)

---------/// Sound Set Up ///---------

if not isfolder('alchemyhub_sound') then
    makefolder('alchemyhub_sound')
end

local playSound : (name : string, link : string) -> nil = function(name : string, link : string)
    if not isfile("alchemyhub_sound/".. name ..".mp3") then
        writefile("alchemyhub_sound/".. name ..".mp3", game:HttpGet(link))
    end

    local soundName : string = name..".mp3"
    
    local SoundSFX : Instance = Instance.new("Sound")
    SoundSFX.Parent = workspace
    SoundSFX.SoundId = getcustomasset("alchemyhub_sound/" .. soundName)

    SoundSFX:Play()
end

---------/// Loading Screen ///---------

xpcall(function()
    local LoaderLib : {} = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/ui/loader.luau"))()
    
    if not(mute_sound) then
        task.spawn(function() playSound("windowstartup", "https://github.com/ZoiIntra/sound/raw/main/windows-xp-startup.mp3") end)
    end
    LoaderLib:LoadInit({
        Color = Color3.fromRGB(0, 255, 128),
        Duration = 1.5,
        Size =  87,
    });
end, function(err : string)
    warn("Loading screen function error "..err)
end)

---------/// Anti Gameplay Paused ///---------

game:GetService("Players").LocalPlayer.Changed:Connect(function(data)
	xpcall(function()
		if data == "GameplayPaused" then
			game:GetService("Players").LocalPlayer.GameplayPaused = false
		end
	end, function(err : string)
        warn("Anit gameplay paused function error "..err)
    end)
end)

---------/// Auto Rejoin ///---------

if auto_rejoin then
    task.spawn(function()
        while true do task.wait()
            xpcall(function()
                game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(Child : Instance)
                    if Child.Name == 'ErrorPrompt' and Child:FindFirstChild('MessageArea') and Child.MessageArea:FindFirstChild("ErrorFrame") then
                        game:GetService("TeleportService"):Teleport(game.PlaceId) 
                    end
                end)
            end, function(err : string)
                warn("Auto rejoin function error "..err)
            end)
        end
    end)
end

---------/// Streamer Mode ///---------

if streamer_mode then
    xpcall(function()
        local protectMessage : (messageTarget : string, messageChange : string) -> nil = function(messageTarget : string, messageChange : string)
            local allSpace : {Instance} = game:GetDescendants()
        
            for i=1,#allSpace do
                if allSpace[i].ClassName == "TextLabel" then
                    if string.find(allSpace[i].Text, messageTarget) then
                        allSpace[i].Text = string.gsub(allSpace[i].Text, messageTarget, messageChange)
                        allSpace[i].Changed:Connect(function()
                            allSpace[i].Text = string.gsub(allSpace[i].Text, messageTarget, messageChange)
                        end)
                    end
                elseif allSpace[i].ClassName == "TextButton" then
                    if string.find(allSpace[i].Text, messageTarget) then
                        allSpace[i].Text = string.gsub(allSpace[i].Text, messageTarget, messageChange)
                        allSpace[i].Changed:Connect(function()
                            allSpace[i].Text = string.gsub(allSpace[i].Text, messageTarget, messageChange)
                        end)
                    end
                elseif allSpace[i].ClassName == "TextBox" then
                    if string.find(allSpace[i].Text, messageTarget) then
                        allSpace[i].Text = string.gsub(allSpace[i].Text, messageTarget, messageChange)
                        allSpace[i].Changed:Connect(function()
                            allSpace[i].Text = string.gsub(allSpace[i].Text, messageTarget, messageChange)
                        end)
                    end
                end
            end
        
            game.DescendantAdded:Connect(function(descendant)
                if descendant.ClassName == "TextLabel" then
                    if string.find(descendant.Text, messageTarget) then
                        descendant.Text = string.gsub(descendant.Text, messageTarget, messageChange)
                        descendant.Changed:Connect(function()
                            descendant.Text = string.gsub(descendant.Text, messageTarget, messageChange)
                        end)
                    end
                elseif descendant.ClassName == "TextButton" then
                    if string.find(descendant.Text, messageTarget) then
                        descendant.Text = string.gsub(descendant.Text, messageTarget, messageChange)
                        descendant.Changed:Connect(function()
                            descendant.Text = string.gsub(descendant.Text, messageTarget, messageChange)
                        end)
                    end
                elseif descendant.ClassName == "TextBox" then
                    if string.find(descendant.Text, messageTarget) then
                        descendant.Text = string.gsub(descendant.Text, messageTarget, messageChange)
                        descendant.Changed:Connect(function()
                            descendant.Text = string.gsub(descendant.Text, messageTarget, messageChange)
                        end)
                    end
                end
            end)
        end
        
        protectMessage(game.Players.LocalPlayer.Name, "[Protect By Alchemy Hub]")
        protectMessage(game.Players.LocalPlayer.DisplayName, "[Protect By Alchemy Hub]")
    end, function(err : string)
        warn("Streamer mode function error "..err)
    end)
end;

---------/// Fully Rejoin ///---------

if fully_rejoin then
    getgenv().start_fully_rejoin = tick()

    task.spawn(function()
        while true do task.wait()
            xpcall(function()
                if tick() - start_fully_rejoin >= 1200 then
                    game:GetService("TeleportService"):Teleport(game.PlaceId) 
                end
            end, function(err : string)
                warn("Auto rejoin function error "..err)
            end)
        end
    end)
end

---------/// Anit AFK ///---------

spawn(function()
    xpcall(function()
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end, function(err : string)
        warn("Anti afk function error "..err)
    end)
end)

---------/// Check if not execute 2 times ///---------

if not(getgenv().run_time) then
    local UILibrary : {} = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/ui/old.lua"))()
    
    ---------/// Notify For Fisch ///---------

    if game.GameId == 5750914919 then -- for fisch
        UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/ui/old_noasset.lua"))()
    end

    local Notification : {new : () -> nil} = UILibrary:Notification();
    
    ---------/// Send Notify ///---------

    if premium then
        Notification.new({
            Title = "Thank you for Support!",
            Description = "Enjoy scripts and features",
            Duration = 10,
        })
    else
        Notification.new({
            Title = "Wanna Join Discord Server?",
            Description = "We have big community and news on this server\nWe also have key giveaway too, Thank you for all Support!!",
            Dialog = true,
            Buttons = {
                {
                    Title = "Sure!",
                    Callback = function()
                        print('discord.gg/alchemyhub')
                        if setclipboard then
                            setclipboard("https://discord.gg/alchemyhub")
                        end
                    end,
                },
                {
                    Title = "No Thanks",
                    Callback = function()
                        print('discord.gg/alchemyhub')
                    end,
                }
            }
        })
    end

    
    Notification.new({
        Title = "Wanna Remove Workspace?",
        Description = "This will delete all your setting and config.",
        Dialog = true,
        Buttons = {
            {
                Title = "Yes",
                Callback = function()
                    if isfolder and delfolder then
                        if isfolder("alchemyhub_neta") then
                            delfolder("alchemyhub_neta")
                            print("Delete Workspace Done!")
                        end
                    end
                end,
            },
            {
                Title = "No",
                Callback = function()
                    print('Nothing.')
                end,
            }
        }
    })

    ---------/// Mark as already execute ///---------

    getgenv().run_time = true

    ---------/// Auto Execute ///---------

    if not(disable_auto_exec) then
        xpcall(function()
            local queueonteleport : () -> nil = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
            if queueonteleport and not(aimbot or fruits_finder or arise_afk or oneclick) then
                print("Set Auto Execute\n")
                if script_key or premium then                    
                    queueonteleport(string.format('getgenv().cometeleport=true;script_key="%s";premium=%s;mute_sound=%s;auto_rejoin=%s;streamer_mode=%s;fully_rejoin=%s;loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/gateway.luau"))()',
                    tostring(script_key), tostring(premium), tostring(mute_sound), tostring(auto_rejoin), tostring(streamer_mode), tostring(fully_rejoin)))
                else
                    queueonteleport(string.format('getgenv().cometeleport=true;mute_sound=%s;auto_rejoin=%s;streamer_mode=%s;fully_rejoin=%s;loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/gateway.luau"))()',
                    tostring(mute_sound), tostring(auto_rejoin), tostring(streamer_mode), tostring(fully_rejoin)))
                end
            end
        end, function(err : string)
            warn("Auto execute function error "..err)
        end)
    end

    ---------/// Print Script Key Config ///---------

    if script_key then
        print(string.format("Key : %s\n", script_key))
    end
    
    ---------/// Load Scripts ///---------

    local tar : any = nil;
    if aimbot then __f['__load']("https://api.luarmor.net/files/v3/loaders/066a14ff57c58562c0b4cacdddb0ae5a.lua")
    elseif fruits_finder then __f['__load']("https://api.luarmor.net/files/v3/loaders/56e77f1d98c461e2b8f24647b42095b4.lua")
    elseif arise_afk then __f['__load']("https://api.luarmor.net/files/v3/loaders/a80497a34c31326d7dfb5d734af4ae33.lua")
    elseif premium then tar = __f['__premium'](); __f['__load']("https://api.luarmor.net/files/"..tar) 
    elseif oneclick then tar = __f['__oneclick'](); __f['__load']("https://api.luarmor.net/files/"..tar) 
    else getgenv().loader = __f['__game'](); __f['__load']("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/keysystem/1.lua") end;
end
