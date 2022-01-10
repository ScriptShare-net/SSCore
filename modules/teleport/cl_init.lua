local SSCore = exports["SSCore"]

exports("teleportPlayer", function(player, targetCoords)
    if not player or not targetCoords then return end

    if type(targetCoords) == 'table' then 
        SetEntityCoords(player, targetCoords, 0, 0, 1)
    else
        SetEntityCoords(player, targetCoords.x, targetCoords.y, targetCoords.z, 0, 0, 1)
    end
end)
