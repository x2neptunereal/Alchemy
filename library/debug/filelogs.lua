local debug_number = tostring(math.floor(os.clock()))

local debugFunction = function(name : string, func : any)
    local filename = "alchemy_debugs/" .. os.date('%A, %B %d %Y').." (".. debug_number ..").txt"
    if not isfolder('alchemy_debugs') then
        makefolder('alchemy_debugs')
    end

    local x,p = pcall(func)
    if p then
        if isfile(filename) then
            appendfile(filename, "\n[" .. tostring(math.floor(tick())) .. ":" .. name .. "] ".. p)
        else
            writefile(filename,"Starts at : "..os.date('%A, %B %d %Y').." / code : ".. debug_number .. "\nThis file was create by Alchemy Debug System, send this file for report bugs.\n")
            appendfile(filename, "\n[" .. tostring(math.floor(tick())) .. ":" .. name .. "] ".. p)

            print("[ ALCHEMY DEBUG ] Create debug file \"".. filename .."\"")
        end

        print("[ ALCHEMY DEBUG : ".. name .." ] " .. p)
    end;
end

return debugFunction
