AddEventHandler('SSCore:onPlayerDeath', function(data)
    if data == nil then return end
end)

CreateThread(function()
    local dead = false 

    while true do 
        Wait(0)
        local sleep = false 
        local player = PlayerPedId()

        if IsPedFatallyInjured(player) and not dead then 
            local dead = true 
            local sleep = false
            local killedBy = GetPedCauseOfDeath(player)
            playerKilled(killedBy)
        else 
            local dead = false 
            local sleep = true 
        end

        if sleep then 
            Wait(1000)
        end
    end 
end)

function playerKilled(killedBy) 
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)

    local table = {coords = plyCoords, killedBy = killedBy}
    TriggerEvent('SSCore:onPlayerDeath', table)
end