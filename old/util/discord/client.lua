RegisterNetEvent(GetCurrentResourceName()..':kill', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent(GetCurrentResourceName()..':teleport', function(x, y, z, withVehicle)
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
    if (withVehicle) then
        SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z)
    else
        SetEntityCoords(PlayerPedId(), x, y, z);
    end
end)