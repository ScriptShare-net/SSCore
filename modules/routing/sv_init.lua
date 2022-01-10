SS = {}
SS.Buckets = {}
SS.Buckets.Player = {} -- Table for Player Buckets
SS.Buckets.Entity = {} -- Table for Entity buckets

AddEventHandler('playerDropped', function()
    local src = source
    if not src then return end
    local t = SS.GetPlayerIdentifiers(src)
    local identifier = t.Identifier
    SS.Player.Buckets[t.Identifier] = nil
end)

exports("setPlayerBucket", function(player, bucket)
    if not player or not source then return end
    local t = exports['SSCore']:GetPlayerIdentifiers(player)
    local identifier = t.Identifier
    SetPlayerRoutingBucket(player, bucket)
    SS.Buckets.Player[identifier] = {id = player, bucket = bucket}
    return true
end)

exports("setEntityBucket", function(entity, bucket)
    if not entity or not bucket then return end
    SetEntityRoutingBucket(entity, bucket)
    SS.Buckets.Entity[entity] = {id = entity, bucket = bucket}
    return true
end)

exports("getPlayersInBucket", function(bucket)
    if not bucket or not SS.Buckets.Player then return false end 
    local returnValue = {}

    for k, v in pairs(SS.Buckets.Player) do 
        if k['bucket'] == bucket then 
            returnValue[#returnValue + 1] = k['id']
        end
    end
    return returnValue
end)

exports("getEntitiesInBucket", function(bucket)
    if not bucket or not SS.Buckets.Entity then return false end 
    local returnValue = {}

    for k, v in pairs(SS.Buckets.Entity) do 
        if k['bucket'] == bucket then 
            returnValue[#returnValue + 1] = k['id']
        end
    end
    return returnValue
end)

exports("isPlayerInBucket", function(player, bucket)
    if not player or not bucket then return false end
    local currentBucket = GetPlayerRoutingBucket(player)

    if currentBucket == bucket then 
        return true 
    else
        return false 
    end
end)