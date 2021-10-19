-- ESX Conversions
RegisterNetEvent('esx:playerLoaded', function()
    TriggerEvent('SS:Client:PlayerLoaded')
end)

RegisterNetEvent('esx:playerLogout', function(xPlayer, isNew)
    TriggerEvent('SS:Client:PlayerLeft')
end)