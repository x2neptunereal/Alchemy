--[[
   _______    __       ________  ___  ___   _______  _______   ________      ___  ___  ________   _______
  ╱       ╲╲╱╱  ╲     ╱╱  ____ ╲╱  ╱ ╱  ╲╲╱╱       ╲╱       ╲╲╱    ╱   ╲    ╱  ╱ ╱  ╲╲╱     ╱  ╲╱╱  __  ╱
 ╱  ╱___  ╱╱╱   ╱    ╱╱  ╱     ╱  ╱_╱   ╱╱╱  ╱___  ╱        ╱╱   _╱    ╱   ╱  ╱_╱   ╱╱   __╱   ╱╱       ╲
╱         ╱    ╱____╱   ╱_____╱   __    ╱     ____╱   ╱  ╱  ╱╲____   ╱╱   ╱   __    ╱         ╱╱   __╱   ╱
╲___╱____╱╲________╱╲________╱╲__╱ ╱___╱╲________╱╲__╱__╱__╱     ╱__╱╱    ╲__╱ ╱___╱╲________╱╱╲________╱ 

This was made by Alchemy Team ( discord.gg/alchemyhub )
Modification of the script, including attempting to bypass
or crack the script for any reason is not allowed.

Copyright © 2023-2026 Alchemy Team. All Rights Reserved.

]]--

local _, subbed = pcall(function() return game:HttpGet('https://github.com/x2neptunereal/Alchemy') end);
local commit = subbed:find('currentOid');commit = commit and subbed:sub(commit + 13, commit + 52) or nil;
commit = commit and #commit == 40 and commit or 'main';return loadstring(game:HttpGet(`https://raw.githubusercontent.com/x2neptunereal/Alchemy/{commit}/ui/primordial/src.lua`))()
