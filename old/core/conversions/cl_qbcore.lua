-- QBCore Conversions
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() -- QBCore Player Loaded Event
    TriggerEvent('SS:Client:PlayerLoaded')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function() -- QBCore Job Update event
    TriggerEvent('SS:Client:onJobChange')
end)