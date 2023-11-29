ESX = exports['s_extended']:getSharedObject()

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    deferrals.defer()
    deferrals.update('Checking S_Ban-Protech Ban...')
    Wait(1000)
    deferrals.update('Checking identifiers...')
    Wait(1000)
    deferrals.update('Checking= '..identifiers[1])

    local identifiers = GetPlayerIdentifiers(source)
    local steamid = identifiers[1]
    local license = identifiers[2]

    PerformHttpRequest(Config.ApiGet, function (err,text,header)
        if text == '[]' then
            deferrals.done()
        else
            local data = json.decode(text)
            for i = 1, #data do
                if data[i].hex_id == steamid then
                    deferrals.done('คุณถูกแบนจากเซิฟเวอร์'..data[i].servername..' เนื่องจาก '..data[i].reason)
                end
                if data[i].discord_id == license then
                    deferrals.done('คุณถูกแบนจากเซิฟเวอร์'..data[i].servername..' เนื่องจาก '..data[i].reason)
                end
            end
            deferrals.done()
        end
    end,'POST',json.encode({}),{['Content-Type'] = 'application/json'})
end)


RegisterCommand('s_globalban',function(source,args,raw)

    local xplayer = GetPlayerIdentifiers(tonumber(args[1]))
    local reason = args[2]
    local discord = xplayer[3]

    if reason == nil then
        print('Please Enter Reason')
        return
    end

    local data = {
        hex_id = xplayer[1],
        discord_id = discord,
        reason = reason,
        servername = GetConvar('sv_projectName', 'unkown')
    }

    PerformHttpRequest(Config.ApiBan, function (err,text,header)
        if (err == 200) then
            TriggerClientEvent('chat:addMessage',-1,{args={'^1Ban-Protech Ban', '^7Ban Success'}})
        else
            TriggerClientEvent('chat:addMessage',-1,{args={'^1Ban-Protech Ban', '^7Ban Fail'}})
        end

    end,'PUT',json.encode({data}),{['Content-Type'] = 'application/json'})
end)
RegisterCommand('s_globalunban',function(source,args,raw)

    local hex_id = args[1]

    if hex_id == nil then
        print('Please Enter Hex ID')
        return
    end

    PerformHttpRequest(Config.ApiUnBan, function (err,text,header)
        
        if err == 200 then
            -- print('Unban Success')
            TriggerClientEvent('chat:addMessage',-1,{args={'^1Ban-Protech Ban', '^7Unban Success'}})
        else
            -- print('Unban Fail')
            TriggerClientEvent('chat:addMessage',-1,{args={'^1Ban-Protech Ban', '^7Unban Fail'}})
        end
        
    end,'DELETE',json.encode({hex_id = hex_id}),{['Content-Type'] = 'application/json'})
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    PerformHttpRequest(Config.ApiGet, function (err,text,header)
        local time = os.date("%H:%M:%S", os.time())
        print('^5['..time..']^7'..'^3 [ Xnxx Ban ]^7 Getting Data From Xnxx Ban Server...')
        print('[ ^1+^7DooCode Fucking ] ^4##################################################^7')
        print('[ ^1+^7DooCode Fucking ] ^4##################^7 '..'['..time..']'..' ^4##################^7')
        print('[ ^1+^7DooCode Fucking ] ^4###############^7 [ Xnxx Ban ] ^4################^7')
        print('[ ^1+^7DooCode Fucking ] ^4###############^7 Banlist'..' ^4'..tonumber(#json.decode(text))..' ^7Player ^4###############^7')
        print('[ ^1+^7DooCode Fucking ] ^4#############^7 Script By. Xnxx ^4###############^7')
        print('[ ^1+^7DooCode Fucking ] ^4##################################################^7')

    end,'POST',json.encode({}),{['Content-Type'] = 'application/json'})

end)