SS.Player.Buckets = {} -- Table for Player Buckets
SS.Entity.Buckets = {} -- Table for Entity buckets

AddEventHandler('playerDropped', function()
    local src = source
    if not src then return end 
    SS.Player.Buckets[t.Identifier] = nil
end

function SS.setPlayerBucket(player, bucket)
    if not player or not source then return end
    local t = SS.GetPlayerIdentifiers(player)
    local identifier = t.Identifier
    SetPlayerRoutingBucket(player, bucket)
    SS.Player.Buckets[identifier] = {id = player, bucket = bucket}
    return true
end

function SS.setEntityBucket(entity, bucket)
    if not entity or not bucket then return end
    SetEntityRoutingBucket(entity, bucket)
    SS.Entity.Buckets[entity] = {id = entity, bucket = bucket}
    return true
end

function SS.getPlayersInBucket(bucket)
    if not bucket or not SS.Player.Buckets then return false end 
    local returnValue = {}

    for k, v in pairs(SS.Player.Buckets) do 
        if k['bucket'] == bucket then 
            returnValue[#returnValue + 1] = k['id']
        end
    end
    return returnValue
end

function SS.getEntitiesInBucket(bucket) 
    if not bucket or not SS.Entity.Buckets then return false end 
    local returnValue = {}

    for k, v in pairs(SS.Entity.Buckets) do 
        if k['bucket'] == bucket then 
            returnValue[#returnValue + 1] = k['id']
        end
    end
    return returnValue
end

function SS.playerInBucket(player, bucket)
    if not player or not bucket then return false end
    local currentBucket = GetPlayerRoutingBucket(player)

    if currentBucket == bucket then 
        return true 
    else
        return false 
    end
end