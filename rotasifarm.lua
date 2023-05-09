RotationBot = {} -- DON'T EDIT!

    RotationBot["FOBIROJABI"] = {
        WorldList = {"SFZCU", "YPAMF", "IUDFR", "FWAWV", "NWCJZ", "TZGCC", "GOJVG", "WFYZC", "EKRRY"}, -- Farm list
        WorldID = "LEH1", -- ID door farm
        Drop_other_world = true, -- true/false
        WorldPack = "JARSPP10", -- World drop pack & seed
        WorldPackID = "LEH1", -- ID door world drop
        BlockID = 4584, -- Item ID
        HitBlock = 3, -- Hardness block
        PackName = "world_lock", -- Debug pack
        PackID = {242}, -- Item ID pack
        BenchPack = 242, -- Put 1 Item ID from PackID
        PackPrice = 2000, -- Pack price
        BenchPrice = 2000, -- Minimum gems for bot buy pack
        BenchDropPack = 16, -- Benchmark drop pack
        BenchDropSeed = 20, -- Benchmark drop seed

        Webhookdonelog = "https://discord.com/api/webhooks/1104439582755409991/chGlxMDodQ-WDaxLqS5GL_EYHKkbDyXXEuCFWPbzFB-vJ-eH4Ou8XqbTSvPbxdmG2pUj", -- Webhook done
        Webhookdisconnect = "https://discord.com/api/webhooks/1104439660102557857/vO_ibbIrGgPxyKLgJzOrf4yGpsOm8s5dyzqBbzIgvUXROWLpxV4RTYbMg-2YTbWe-sS9" -- Webhook disconnect
    }
    RotationBot["VASEXAXUFA"] = {
        WorldList = {"VLTQO", "UBLVM", "LTQFL", "WFPDD", "XAPBY", "GNKGN", "UXLTP", "DWWUX", "NMRNR"}, -- Farm list
        WorldID = "LEH1", -- ID door farm
        Drop_other_world = true, -- true/false
        WorldPack = "JARSPP10", -- World drop pack & seed
        WorldPackID = "LEH1", -- ID door world drop
        BlockID = 4584, -- Item ID
        HitBlock = 3, -- Hardness block
        PackName = "world_lock", -- Debug pack
        PackID = {242}, -- Item ID pack
        BenchPack = 242, -- Put 1 Item ID from PackID
        PackPrice = 2000, -- Pack price
        BenchPrice = 2000, -- Minimum gems for bot buy pack
        BenchDropPack = 16, -- Benchmark drop pack
        BenchDropSeed = 20, -- Benchmark drop seed

        Webhookdonelog = "https://discord.com/api/webhooks/1104439582755409991/chGlxMDodQ-WDaxLqS5GL_EYHKkbDyXXEuCFWPbzFB-vJ-eH4Ou8XqbTSvPbxdmG2pUj", -- Webhook done
        Webhookdisconnect = "https://discord.com/api/webhooks/1104439660102557857/vO_ibbIrGgPxyKLgJzOrf4yGpsOm8s5dyzqBbzIgvUXROWLpxV4RTYbMg-2YTbWe-sS9" -- Webhook disconnect
    }

    delayharvest = 150
    delayplant = 100
    delayplace = 120
    delaypunch = 180

    delete_history = {
        "Sellgreenblock",
        "Sellgreenblocks",
        "Sellgrowairballoon",
        "Sellgrowairballoons",
        "Sellheartcrystal",
        "Sellheartcrystals",
        "Sellbluecrystal",
        "Sellbluecrystals"
    }

    delayharvest = 150
    delayplant = 100
    delayplace = 120
    delaypunch = 180

    delete_history = {
        "Sellgreenblock",
        "Sellgreenblocks",
        "Sellgrowairballoon",
        "Sellgrowairballoons",
        "Sellheartcrystal",
        "Sellheartcrystals",
        "Sellbluecrystal",
        "Sellbluecrystals"
    }

    
    -- END EDIT HERE! --


    function BotCanRun()
        for _, bot in pairs(GetSelectedBots()) do
            if bot:GetFromMemory("sudah menjalankan skript") == nil then -- dia akan cek apa string itu ada di memory bot atau tidak
              MessageBox("Rotation", "Rotation script running at bot "..bot.name)
              return bot
            end
        end
        MessageBox("Rotation", "Please select bot, or bot already running the script")
        return nil
    end
        
    bot = BotCanRun()
    bot:SaveToMemory("sudah menjalankan skript", "sudah")

    WorldList = RotationBot[bot.name:upper()].WorldList
    WorldID = RotationBot[bot.name:upper()].WorldID
    Drop_other_world = RotationBot[bot.name:upper()].Drop_other_world
    WorldPack = RotationBot[bot.name:upper()].WorldPack
    WorldPackID = RotationBot[bot.name:upper()].WorldPackID
    BlockID = RotationBot[bot.name:upper()].BlockID
    HitBlock = RotationBot[bot.name:upper()].HitBlock
    PackName = RotationBot[bot.name:upper()].PackName
    PackID = RotationBot[bot.name:upper()].PackID
    BenchPack = RotationBot[bot.name:upper()].BenchPack
    PackPrice = RotationBot[bot.name:upper()].PackPrice
    BenchPrice = RotationBot[bot.name:upper()].BenchPrice
    BenchDropPack = RotationBot[bot.name:upper()].BenchDropPack
    BenchDropSeed = RotationBot[bot.name:upper()].BenchDropSeed
    Webhookdonelog = RotationBot[bot.name:upper()].Webhookdonelog
    Webhookdisconnect = RotationBot[bot.name:upper()].Webhookdisconnect

    whitelist = {98, 18, 32, 6336, 9640, BlockID, BlockID + 1}

    function punch(x,y)
        bot:Punch(math.floor(bot.pos.x / 32) + x,math.floor(bot.pos.y / 32) + y)
    end

    function place(id, x,y)
        bot:Place(id, math.floor(bot.pos.x / 32) + x,math.floor(bot.pos.y / 32) + y)
    end

    function finditem(itmid)
        if bot:FindItem(itmid) ~= nil then
            return bot:FindItem(itmid).amount
        end
        return 0
    end

    function harvest()
        bot:CollectSet(true, 3, 100)
        rejoin()
        trash()
        rst = 0
	    drp = 0
        for _, tile in pairs(bot:GetTiles()) do
            if tile.ready == true and tile.fg == BlockID + 1 then
                bot:FindPath(tile.pos.x,tile.pos.y)
                Sleep(delayharvest)
                punch(0,0)
                if finditem(BlockID) >= 150 then
                    break
                end
            end
            if bot.state ~= 5 then
                reconnect()
            end
        end
        if finditem(BlockID) == 0 then
            drp = 1
            lastdrop()
        end
    end

    function plant()
        rejoin()
        for _, tile in pairs(bot:GetTiles()) do
            if tile.fg == 0 and bot:GetTile(tile.pos.x,tile.pos.y + 1).fg ~= 0 and bot:GetTile(tile.pos.x,tile.pos.y + 1).fg ~= BlockID + 1 then
                bot:FindPath(tile.pos.x,tile.pos.y)
                Sleep(delayplant)
                place(BlockID + 1, 0, 0)
                if finditem(BlockID + 1) == 0 then
                    break
                end
            end
            if bot.state ~= 5 then
                reconnect()
            end
        end
        if finditem(BenchPack) > 0 or bot.gems >= BenchPrice then
            if Drop_other_world == false then
                drop()
            elseif Drop_other_world== true then
                dropotherworld()
            end
        end
    end

    function pnb()
        rejoin()
        local tileY = math.floor(bot.pos.y / 32)
        bot:FindPath(1, tileY)
        Sleep(1500)
        while finditem(BlockID) > 0 do
            if bot.state == 5 then
                place(BlockID, -1, -1)
                Sleep(delayplace)
                place(BlockID, -1, 0)
                Sleep(delayplace)
                for i = 1,HitBlock do
                    if bot:GetTile(math.floor(bot.pos.x / 32) - 1, math.floor(bot.pos.y / 32) - 1).fg ~= 0 or bot:GetTile(math.floor(bot.pos.x / 32) - 1, math.floor(bot.pos.y / 32) - 1).bg ~= 0 then
                        punch(-1 , -1)
                        Sleep(delaypunch)
                    end
                    if bot:GetTile(math.floor(bot.pos.x / 32 - 1), math.floor(bot.pos.y / 32)).fg ~= 0 or bot:GetTile(math.floor(bot.pos.x / 32 - 1), math.floor(bot.pos.y / 32)).bg ~= 0 then
                        punch(-1, 0)
                        Sleep(delaypunch)
                    end
                end
            else
                reconnect()
            end
        end
        while bot:GetTile(math.floor(bot.pos.x / 32) - 1, math.floor(bot.pos.y / 32) - 1).fg ~= 0 or bot:GetTile(math.floor(bot.pos.x / 32) - 1, math.floor(bot.pos.y / 32) - 1).bg ~= 0 do
            punch(-1 , -1)
            Sleep(delaypunch)
        end
        while bot:GetTile(math.floor(bot.pos.x / 32 - 1), math.floor(bot.pos.y / 32)).fg ~= 0 or bot:GetTile(math.floor(bot.pos.x / 32 - 1), math.floor(bot.pos.y / 32)).bg ~= 0 do
            punch(-1,0)
            Sleep(delaypunch)
        end
        if finditem(BenchPack) > 0 then
            if Drop_other_world == false then
                drop()
            elseif Drop_other_world== true then
                dropotherworld()
            end
        end
    end

    function drop()
        if finditem(BlockID + 1) >= 150 or bot.gems >= BenchPrice or finditem(BenchPack) > 0 or drp == 1 then
            bot:CollectSet(false, 3, 100)
            Sleep(2000)
            bot:FindPath(97,1)
            Sleep(2000)
            if bot.gems >= ppackPrice or finditem(ppackID) > 0 then
                Sleep(1000)
                buypack()
            end
            if finditem(BlockID + 1) >= 150 or drp == 1 then
                bot:Drop(BlockID + 1)
                Sleep(1000)
            end
        end
        harvest()
    end
    
    function lastdrop()
        plant()
        gscan1()
        donelog("**<<Bot Information>>** \n:earth_asia: : "..bot.world.."\n:robot: : "..bot.name.." ( "..bot.level.." )\n:seedling: "..tostring(totplant).." \n:alarm_clock: : "..waktu().."\n")
        if Drop_other_world == false then
            drop()
        elseif Drop_other_world == true then
            dropotherworld()
        end
        drp = 0
        nextworld()
    end

    function rejoin()
        while bot:GetTile(math.floor(bot.pos.x / 32),math.floor(bot.pos.y / 32)).fg == 6 or bot.world ~= localworld do
            bot:SendPacket(3, "action|join_request\nname|"..localworld.."\ninvitedWorld|0")
            Sleep(5000)
            bot:SendPacket(3, "action|join_request\nname|"..localworld.."|"..WorldID.."\ninvitedWorld|0")
            Sleep(2000)
        end
        rst = 1
    end

    function reconnect()
        if bot.state ~= 5 then
            disconnect(bot.name.." Disconnect tolol, anjing amat")
            Sleep(1000)
            while bot.state ~= 5 do
                Sleep(10000)
                bot:Connect(true)
                if bot.state == 5 then
                    disconnect(bot.name.." Connected, dh aman anjing kaga ke ban")
                    Sleep(10000)
                    rejoin()
                    harvest()
                    break
                end
            end
        end
    end

    function buypack()
        if bot.gems ~= nil then
            if drp ~= 1 then
                bagipack = BenchPrice / PackPrice
            elseif drp == 1 then
                bagipack = bot.gems / PackPrice
            end
            for i = 1,math.floor(bagipack) do
                bot:SendPacket(2, "action|buy\nitem|"..PackName)
                Sleep(2000)
            end
        end
        droppack()
    end
    
    function droppack()
        bot:Move(LEFT)
        Sleep(1000)
        local ppackCount = finditem(BenchPack)
        while ppackCount > 0 do
            bot:Drop(BenchPack)
            Sleep(1000)
            ppackCount = finditem(BenchPack)
        end
        harvest()
    end

    function dropotherworld()
        if drp == 1 or finditem(BlockID + 1) >= 150 or bot.gems >= BenchPrice or finditem(BenchPack) > 0 then
            bot:CollectSet(false, 3, 100)
            bot:SendPacket(3, "action|join_request\nname|".. WorldPack .."\ninvitedWorld|0")
            Sleep(5000)
            bot:SendPacket(3, "action|join_request\nname|".. WorldPack .."|".. WorldPackID .."\ninvitedWorld|0")
            Sleep(2000)
            if finditem(BlockID + 1) >= 150 or drp == 1 then
                for _, tile in pairs(bot:GetTiles()) do
                    if tile.fg == BenchDropSeed or tile.bg == BenchDropSeed then
                        bot:FindPath(tile.pos.x, tile.pos.y)
                        Sleep(3000)
                        bot:Drop(BlockID + 1)
                        while finditem(BlockID + 1) > 0 do
                            Sleep(1000)
                            bot:Move(RIGHT)
                            Sleep(2000)
                            bot:Drop(BlockID + 1)
                        end
                    end
                end
            end
        end
        if bot.gems and (bot.gems >= BenchPrice or finditem(BenchPack) > 0) or drp == 1 then
            for _, tile in pairs(bot:GetTiles()) do
                if tile.fg == BenchDropPack or tile.bg == BenchDropPack then
                    bot:FindPath(tile.pos.x, tile.pos.y)
                    Sleep(1000)
                    if bot.gems ~= nil then
                        if drp ~= 1 then
                            bagipack = BenchPrice / PackPrice
                        elseif drp == 1 then
                            bagipack = bot.gems / PackPrice
                        end
                        for i = 1,math.floor(bagipack) do
                            bot:SendPacket(2, "action|buy\nitem|"..PackName)
                            Sleep(2000)
                        end
                    end
                    droppck2()
                end
            end
        end
        if drp ~= 1 then
            harvest()
        end
    end
    
    function droppck2()
        for i, id in ipairs(PackID) do
            local count = finditem(id)
            if count > 0 then
                bot:Drop(id)
                Sleep(1000)
            end
        end
    
        bot:Move(RIGHT)
        Sleep(1000)
    
        for i, id in ipairs(PackID) do
            local count = finditem(id)
            if count > 0 then
                bot:Drop(id)
                Sleep(1000)
            end
        end
    end

    function whitelists(white, number)
        for _, nomor in pairs(white) do
            if nomor == number then
                return true
            end
        end
        return false
    end
    
    function trash()
        for _, inv in pairs(bot:GetItems()) do
            if not whitelists(whitelist, inv.id) then
                bot:SendPacket(2, "action|trash\n|itemID|" .. inv.id)
                bot:SendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|" .. inv.id .. "|\ncount|" .. inv.amount)
                Sleep(500)
            end
        end
    end

    function nextworld()
        for i = 1,#WorldList do
            if localworld == string.upper(WorldList[i]) then
                if i == #WorldList then
                    localworld = string.upper(WorldList[1])
                    else
                    localworld = string.upper(WorldList[i+1])
                end
                break
            end
        end
        deletehistory()
        bot:SendPacket(3, "action|join_request\nname|".. localworld .."\ninvitedWorld|0")
        Sleep(5000)
        bot:SendPacket(3, "action|join_request\nname|".. localworld .."|"..WorldID.."\ninvitedWorld|0")
        Sleep(2000)
        bot:SendPacket(2, "action|getDRAnimations")
        Sleep(1000)
    end
    
    function deletehistory()
        for _, list in pairs(delete_history) do
            if bot.state ~= 5 then
                reconnect()
            end
            bot:SendPacket(3, "action|join_request\nname|".. list .."\ninvitedWorld|0")
            Sleep(5000)
            bot:SendPacket(2, "action|getDRAnimations")
        end
        rejoin()
    end
    
    function donelog(teks)
        local script = [[
        $webHookUrl = "]]..Webhookdonelog..[["
        [System.Collections.ArrayList]$embedArray = @()
        $color = ']] .. math.random(1111111,9999999) .. [['
        $cpu = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average).Average
        $ram = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
        $description = ']]..teks.."\n"..":hourglass: : "..botuptimes().."\n"..[['
        
        $embedObject = [PSCustomObject]@{
            color = $color
            description = "$description **Cpu : $cpu% || Ram : $ram Mb**"
            timestamp = Get-Date -Format o
        }
        $embedArray.Add($embedObject)
        $payload = [PSCustomObject]@{
            embeds = $embedArray
        }
        
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 5) -Method Post -ContentType 'application/json' ]]
        
        local pipe = io.popen("powershell -command -", "w")
          pipe:write(script)
          pipe:close()
    end
    
    function disconnect(teks)
        local script = [[
        $webHookUrl = "]]..Webhookdisconnect..[["
        [System.Collections.ArrayList]$embedArray = @()
        $color = ']] .. math.random(1111111,9999999) .. [['
        $description = ']].. teks..[['
        
        $embedObject = [PSCustomObject]@{
            color = $color
            description = $description
        }
        $embedArray.Add($embedObject)
        $payload = [PSCustomObject]@{
            embeds = $embedArray
        }
        
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 5) -Method Post -ContentType 'application/json' ]]
        
        local pipe = io.popen("powershell -command -", "w")
          pipe:write(script)
          pipe:close()
    end
    
    function gscan1()
        totplant = 0
        for _, tile in pairs(bot:GetTiles()) do
            if tile.fg == BlockID + 1 then
                totplant = totplant + 1
            end
        end
        return totplant
    end
    
    function waktu()
        time = os.time() - t
        jam = math.floor(time/3600)
        menit = math.floor(time%3600/60) 
        detik = time%3600%60
        str = jam.."h "..menit.."m "..detik.."s"
        t = os.time()
        return str
    end
          
    function botuptimes()
        times = os.time() - s
        jams = math.floor(times/3600)
        menits = math.floor(times%3600/60)
        detiks = times%3600%60
        uptime = jams.."h "..menits.."m "..detiks.."s"
        return uptime
    end
    
    t = os.time()
    s = os.time()
    localworld = bot.world
    bot:Say("Script by `9Ryankooch`0#`21243")
    while true do
        if bot.state == 5 then
            while bot.world ~= string.upper(localworld) do
                Sleep(1000)
            end
            harvest()
            if rst ~= 1 then
                if Drop_other_world == false then
                    drop()
                elseif Drop_other_world == true then
                    dropotherworld()
                end
                pnb()
                plant()
            end
        else
            reconnect()
        end
    end
