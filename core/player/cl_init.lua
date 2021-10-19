-- Events
RegisterNetEvent('SS:Client:PlayerLoaded', function() -- Player loaded event
    ShutdownLoadingScreenNui()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, false)
    LocalPlayer.state:set('fullyLoaded', true, false)
end)

RegisterNetEvent('SS:Client:PlayerLeft', function() -- Player unload event
    LocalPlayer.state:set('fullyLoaded', false, false)
end)

-- Functions
function SS.Player.GetCoords(entity)
    local coords = GetEntityCoords(entity)
    local heading = GetEntityHeading(entity)
    local vec = vector4(coords, heading)
    
    return vec
end