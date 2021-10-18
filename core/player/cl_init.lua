function SS.Player.GetCoords(entity)
    local coords = GetEntityCoords(entity)
    local heading = GetEntityHeading(entity)
    local vec = vector4(coords, heading)
    
    return vec
end