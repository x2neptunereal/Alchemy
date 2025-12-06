local g : number = game.GameId
local r : (s : string) -> nil = function(s : string)
(load or loadstring)(game:HttpGet(s))(); end
if g == 5750914919 then r('https://api.luarmor.net/files/v3/loaders/8aa6d25ead5f7dcd27b18c846cdbddaa.lua'); return 'fisch'
elseif g == 7671049560 then r('https://api.luarmor.net/files/v3/loaders/ad3ba52a58adff8dc627f2687e5b92e0.lua'); return 'the forge'
else return nil end
