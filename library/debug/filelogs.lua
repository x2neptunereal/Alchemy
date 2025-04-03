local debug_number = tostring(math.floor(os.clock()) * math.random(1000,9999))

local debugFunction = function(func : any, name : string)
    local func_name = name or "nil"

    if isfolder and makefolder and isfile and writefile and appendfile then
        local filename = "alchemy_debugs/" .. os.date('%A, %B %d %Y').." (".. debug_number ..").txt"

        if not isfolder('alchemy_debugs') then
            makefolder('alchemy_debugs')
        end

        local x,p = pcall(func)
        if p then
            if isfile(filename) then
                appendfile(filename, "\n[" .. tostring(math.floor(tick())) .. ":".. func_name .."] ".. p)
            else
                writefile(filename,"Starts at : "..os.date('%A, %B %d %Y').." / code : ".. debug_number .. "\nThis file was create by Alchemy Debug System, send this file for report bugs.\n")
                appendfile(filename, "\n[" .. tostring(math.floor(tick())) .. ":".. func_name .."] ".. p)

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
