local getTimeOfTheDay = function(uni : string)
    local seconds = tick() % 86400
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%d".. uni .."%02d".. uni .."%02d", hours, minutes, secs)
end

local getLocalTime = function()
    return tostring(math.floor(tick()))
end

local getDate = function()
    return os.date('%A, %B %d %Y')
end

local debugFunction = function(func : any, name : string)
    local func_name = name or "nil"

    if isfolder and makefolder and isfile and writefile and appendfile then
        local filename = "alchemy_debugs/" .. getDate().." (".. getTimeOfTheDay("-") ..").txt"

        if not isfolder('alchemy_debugs') then
            makefolder('alchemy_debugs')
        end

        local x,p = pcall(func)
        if p then
            if isfile(filename) then
                appendfile(filename, "\n[" .. getLocalTime() .. ":".. func_name .."] ".. p)
            else
                writefile(filename,"Starts at : "..getDate().." / ".. getTimeOfTheDay(":") .. "\nThis file was create by Alchemy Debug System, send this file for report bugs.\n")
                appendfile(filename, "\n[" .. getLocalTime() .. ":".. func_name .."] ".. p)

                print("[ ALCHEMY DEBUG ] Create debug file \"".. filename .."\"")
            end

            print("[ ALCHEMY DEBUG : ".. func_name .." ] " .. p)
        end;
    else
        local x,p = pcall(func)
        if p then
            print("[ ALCHEMY DEBUG : ".. func_name .." ] " .. p)
        end
    end
end

return debugFunction
