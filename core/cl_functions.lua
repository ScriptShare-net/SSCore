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