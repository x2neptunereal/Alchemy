if not isfolder('alchemyhub_sound') then
    makefolder('alchemyhub_sound')
end

local playMusic : (name : string, link : string) -> nil = function(name : string, link : string)
    if not isfile("alchemyhub_sound/".. name ..".mp3") then
        writefile("alchemyhub_sound/".. name ..".mp3", game:HttpGet(link))
    end

    local soundName : string = name..".mp3"
    
    local SoundSFX : Instance = Instance.new("Sound")
    SoundSFX.Parent = workspace
    SoundSFX.SoundId = getcustomasset("alchemyhub_sound/" .. soundName)

    SoundSFX:Play()
end

return playMusic
