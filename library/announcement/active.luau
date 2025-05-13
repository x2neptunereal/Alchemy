local disable : boolean = true

if (isfile and writefile and isfolder and makefolder) and not(disable) then
    if not isfolder("alchemyhub_log") then
        makefolder("alchemyhub_log")
    end

    local filename : string = "FUTJ1663Q0NZLP938VRZ1YYVU4H8ZZ"
    local realfile : string = string.format("alchemyhub_log/%s.txt", filename)

    if isfile(realfile) then
        return {success = false, message = "Already have [".. filename .."] log."}
    end
    writefile(realfile, string.format("Log was create when %d.", tostring(tick())))

    local UILibrary : {} = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/ui/old.lua"))()
    if game.GameId == 5750914919 then UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2neptunereal/Alchemy/main/ui/old_noasset.lua"))() end

    local Notification : {new : () -> nil} = UILibrary:Notification();

    Notification.new({
        Title = "Announcement!",
        Description = "Hello World",
        Duration = 10,
    })
    return {success = true, message = "Done!"}
end
return {success = false, message = "Script got disable or executor not support."}
