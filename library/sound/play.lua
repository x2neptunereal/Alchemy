if not isfolder('alchemyhub_sound') then
    makefolder('alchemyhub_sound')
end

local playMusic : func = function(name : string, link : string)
    writefile("alchemyhub_sound/".. name ..".mp3", game:HttpGet(link))

    local soundName : string = name..".mp3"
    
    local SoundSFX : userdata = Instance.new("Sound")
    SoundSFX.Parent = workspace
    SoundSFX.SoundId = getcustomasset("alchemyhub_sound/"..soundName)

    SoundSFX:Play()
end

return playMusic
