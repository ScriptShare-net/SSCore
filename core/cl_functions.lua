local SSCore = exports["SSCore"]

exports("Alert", function(string)
	print("[^2SSCore^0] " .. string)
end)

local ServerCallbacks = {}

local function nextFree(tbl)
	local num = 1
	for k,v in pairs(tbl) do
		if num ~= k then
			return num
		end
		num = num + 1
	end
	return num
end

exports("TriggerServerCallback", function(name, cb, ...)
	local requestId = nextFree(ServerCallbacks)
	ServerCallbacks[requestId] = cb
	TriggerServerEvent("SS:Server:Callback", name, requestId, ...)
end)

RegisterNetEvent("SS:Client:Callback", function(requestId, ...)
	ServerCallbacks[requestId](...)
	ServerCallbacks[requestId] = nil
end)

RegisterNetEvent("SS:Client:CharacterLoaded", function(characterdata)
	SSCore:SetCharacterData(characterdata)
end)

exports("teleportPlayer", function(player, targetCoords)
    if not player or not targetCoords then return end

    if type(targetCoords) == 'table' then 
        SetEntityCoords(player, targetCoords, 0, 0, 1)
    else
        SetEntityCoords(player, targetCoords.x, targetCoords.y, targetCoords.z, 0, 0, 1)
    end
end)

--[[ local NetEvents = {}
local TriggerNetEvents = {}

exports("registerNetEvent", function(name, cb)
	NetEvents[name] = cb
	TriggerNetEvents[name] = {}
end)

exports("triggerNetEvent", function(name, ...)
	NetEvents[name](...)
end)

exports("triggerServerNetEvent", function(name, ...)
	TriggerServerEvent("SS:Server:NetEvent", name)
end) ]]