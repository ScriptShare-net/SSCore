function SS.Player.GetCoords(entity)
    local coords = GetEntityCoords(entity)
    local heading = GetEntityHeading(entity)
    local vec = vector4(coords, heading)
    
    return vec
end

function SS.Player.RemoveProp()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end