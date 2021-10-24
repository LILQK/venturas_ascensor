ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('venturas:cambiodinero')
AddEventHandler('venturas:cambiodinero', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    while xPlayer == nil do
        xPlayer = ESX.GetPlayerFromId(source)
    end 


    
    local black  = xPlayer.getAccount("black_money").money

    if black > 0 then 
        xPlayer.removeAccountMoney("blackmoney", black)
        xPlayer.addMoney(black)
    else
    end

end)