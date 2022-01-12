local SSCore = exports["SSCore"]
local Buckets = {}
Buckets.Players = {} -- Table for Player Buckets
Buckets.Entitys = {} -- Table for Entity buckets

AddEventHandler('playerDropped', function()
    local src = source
    if not src then return end
    local t
	SSCore:GetUserIdentifiers(src, function(identifiers)
		t = identifiers
		local identifier = t.Identifier
		Buckets.Players[t.Identifier] = nil
	end)
end)

exports("setPlayerBucket", function(player, bucket)
    if not player or not source then return end
    local t
	SSCore:GetUserIdentifiers(src, function(identifiers)
		t = identifiers
		local identifier = t.Identifier
		SetPlayerRoutingBucket(player, bucket)
		Buckets.Players[identifier] = {id = player, bucket = bucket}
		return true
	end)
end)

exports("setEntityBucket", function(entity, bucket)
    if not entity or not bucket then return end
    SetEntityRoutingBucket(entity, bucket)
    Buckets.Entitys[entity] = {id = entity, bucket = bucket}
    return true
end)

exports("getPlayersInBucket", function(bucket)
    if not bucket or not Buckets.Players then return false end 
    local returnValue = {}

    for k, v in pairs(Buckets.Players) do 
        if k['bucket'] == bucket then 
            returnValue[#returnValue + 1] = k['id']
        end
    end
    return returnValue
end)

exports("getEntitiesInBucket", function(bucket)
    if not bucket or not Buckets.Entitys then return false end 
    local returnValue = {}

    for k, v in pairs(Buckets.Entitys) do 
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