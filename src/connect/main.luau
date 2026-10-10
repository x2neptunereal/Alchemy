getgenv().synchronization = synchronization or {
    port = 3000,
    base_url = "localhost",
    refresh_time = 10
}

local getService: any = setmetatable({}, {
    __index = function(selff: {}, serviceName: any): any
        local service = cloneref(game:GetService(serviceName))
        rawset(selff, serviceName, service)
        return service
    end
})

local http: HttpService = getService.HttpService
local rep: ReplicatedStorage = getService.ReplicatedStorage
local plr: any = getService.Players.LocalPlayer
local ws: any = WebSocket.connect("ws://" .. synchronization.base_url .. ":" .. tostring(synchronization.port) .. "/connect/" .. tostring(plr.UserId))

ws:Send(http:JSONEncode({
    types = "link",
	data = {
		username = plr.Name,
		userid = plr.UserId,
		displayname = plr.DisplayName,
		time = os.time(),
		games = game.GameId,
	}
}))

do
	ws:Send("Connected!")
	ws.OnMessage:Connect(function(msg)
		print("Debug: ", msg)
	end)
end

if game.GameId == 994732206 then -- BLOX FRUITS
    local getWeapon = function(types: string): string
        local wea: Instance = plr.Character:FindFirstChildOfClass("Tool")
        if wea and wea.ToolTip == types then return wea.Name end 
        for i, v in pairs(plr.Backpack:GetChildren()) do
            if v.ClassName == "Tool" and v.ToolTip == types then
                return v.Name
            end
        end
        return ""
    end

    local itemCache: any = nil
    local itemCacheTime: number = 0
    local collected: {} = {}
    local getItemInventory = function(): {}
        local now: number = tick()
        if itemCache and now - itemCacheTime < 0.2 then return itemCache end
        if not collected.itemRep then
            local ok, r = pcall(function() return require(rep:WaitForChild("ItemReplicationService", 20)) end)
            if not ok then return {} end
            collected.itemRep = r
        end
        if not collected.itemC then
            local ok, c = pcall(function() return require(rep:WaitForChild("ItemConfig", 20)) end)
            if not ok then return {} end
            collected.itemC = c
        end
        if not collected.combatU then
            local ok, c = pcall(function() return require(rep.Modules:WaitForChild("CombatUtil", 20)) end)
            if not ok then return {} end
            collected.combatU = c
        end
        local userCache: Instance = collected.itemRep._UserCache[plr.UserId]
        if not userCache then return {} end
        local Q: {} = userCache:GetItems("Quantity") or {}
        local M: {} = userCache:GetItems("Mastery") or {}
        local mas: {} = {}
        for _, v in M do mas[v.ItemId] = v.Value end
        local itemList: {} = {}
        for _, v in Q do
            local id: any = v.ItemId
            local ty: string = "?"
            local dn: string = ""
            pcall(function()
                local c: {} = collected.itemC.match(id):unwrap()
                if c and c.Index then ty = c.Index.IdType; dn = c.Index.DebugLabel end
            end)
            local entry: {} = { Id = id, Name = dn:gsub(" %[.-%]", ""), RawName = dn, Type = ty, Count = v.Value, Mastery = mas[id] }
            local ok, wd = pcall(collected.combatU.GetWeaponData, collected.combatU, entry.Name)
            if ok and wd then entry.WeaponType = tostring(wd.WeaponType) end
            table.insert(itemList, entry)
        end
        itemCache, itemCacheTime = itemList, now
        return itemList
    end

    local imageUtil = require(rep.Modules.Asset.ImageUtil)
    local getItemImage = function(itemId): {}
        local ok, data = pcall(imageUtil.getImageFromItemId, itemId)
        if not ok or not data or not data.Icon then
            return {image = nil, offset = nil, size = nil}
        end

        local icon = data.Icon
        return {image = icon.Image, offset = icon.ImageRectOffset, size = icon.ImageRectSize}
    end

    local updating = function(): nil
        local fruitsData: {} = {}
        local swordsData: {} = {}
        local meleeData: {} = {}
        local accessoryData: {} = {}
        local materialData: {} = {}
        for i, v in pairs(getItemInventory()) do
            local imageData: {} = getItemImage(v.Id or 1162)
            print(imageData.image)
            local imageId: number = (imageData and imageData.image and tonumber(imageData.image:match("%d+"))) or 732391129
            local imageOffset: {} = (imageData and imageData.offset and imageData.offset.x and imageData.offset.y and {imageData.offset.x, imageData.offset.y}) or nil
            local imageSize: {} = (imageData and imageData.size and imageData.size.x and imageData.size.y and {imageData.size.x, imageData.size.y}) or nil
            if v.Type == "PhysicalMoveset" then
                table.insert(fruitsData, {name = v.Name:match("^(.*)%-"), count = v.Count or 1, icon = imageId, imageOffset = imageOffset, imageSize = imageSize})
            elseif v.Type == "Moveset" and v.WeaponType == "Sword" then
                table.insert(swordsData, {name = v.Name, mastery = v.Mastery or 1, icon = imageId, imageOffset = imageOffset, imageSize = imageSize})
            elseif v.Type == "Moveset" and v.WeaponType == "Melee" then
                table.insert(meleeData, {name = v.Name, mastery = v.Mastery or 1, icon = imageId, imageOffset = imageOffset, imageSize = imageSize})
            elseif v.Type == "Material" then
                table.insert(materialData, {name = v.Name, count = v.Count or 1, icon = imageId, imageOffset = imageOffset, imageSize = imageSize})
            elseif v.Type == "Accessory" then
                table.insert(accessoryData, {name = v.Name, count = v.Count or 1, icon = imageId, imageOffset = imageOffset, imageSize = imageSize})
            end
        end

        ws:Send(http:JSONEncode({
            types = "stats",
            stats = {
                { label = "Level", value = plr.Data.Level.Value },
                { label = "Money", value = plr.Data.Beli.Value },
                { label = "Fragment", value = plr.Data.Fragments.Value },
                { label = "Bounty/Honor", value = plr.leaderstats["Bounty/Honor"].Value },
                { label = "Race", value = plr.Data.Race.Value },
                { label = "Fruit", value = plr.Data.DevilFruit.Value:match("^(.*)%-") },
                { label = "Melee", value = getWeapon("Melee") },
                { label = "Sword", value = getWeapon("Sword") },
            },
            items = {
                {
                    name = "Melee",
                    types = "weapon",
                    data = meleeData
                },
                {
                    name = "Swords",
                    types = "weapon",
                    data = swordsData
                },
                {
                    name = "Fruits",
                    types = "inventory",
                    data = fruitsData
                },
                {
                    name = "Materials",
                    types = "inventory",
                    data = materialData
                },
                {
                    name = "Accessories",
                    types = "inventory",
                    data = accessoryData
                },
            }
        }))
    end

    repeat task.wait(synchronization.refresh_time); pcall(updating) until false
else
    ws:Send(http:JSONEncode({
        types = "stats",
        stats = {
            { label = "Test", value = math.random(1, 12) },
            { label = "Number", value = 9999 },
            { label = "Number (M)", value = 12000000 },
            { label = "String", value = "this is string" },
        },
        items = {
            {
                name = "Testing",
                types = "inventory",
                data = {
                    { name = "Test 1", count = 1, icon = 732391129},
                    { name = "Test 2", count = 2, icon = 732391129},
                    { name = "Test 3", count = 3, icon = 732391129},
                }
            },
        }
    }))
end
