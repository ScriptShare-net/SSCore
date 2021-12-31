SS.Alert = function(string)
	print("[^2SSCore^0] " .. string)
end

SS.ServerCallbacks = {}

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

SS.TriggerServerCallback = function(name, cb, ...)
	local requestId = nextFree(SS.ServerCallbacks)
	SS.ServerCallbacks[requestId] = cb
	TriggerServerEvent("SS:Server:Callback", name, requestId, ...)
end

RegisterNetEvent("SS:Client:Callback", function(requestId, ...)
	SS.ServerCallbacks[requestId](...)
	SS.ServerCallbacks[requestId] = nil
end)

RegisterNetEvent("SS:Client:PlayerLoaded", function(playerdata)
	SS.player = playerdata
end)