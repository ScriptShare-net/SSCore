SS.Player = {}
-- Events
RegisterNetEvent('SS:Client:PlayerLoaded', function() -- Player loaded event
    ShutdownLoadingScreenNui()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, false)
    SS.Player.Loaded = true
end)

RegisterNetEvent('SS:Client:PlayerLeft', function() -- Player unload event
    SS.Player.Loaded = false
end)