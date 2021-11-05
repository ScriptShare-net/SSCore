SS = SS or {}
SS.ServerCallbacks = SS.ServerCallbacks or {}

local function nextFree(tbl)
	local num = 0
	json.encode(tbl)
	for k,v in pairs(tbl) do
		print(num, k)
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
	print(requestId)
end

RegisterNetEvent("SS:Client:Callback", function(requestId, ...)
	print(requestId)
	SS.ServerCallbacks[requestId](...)
	SS.ServerCallbacks[requestId] = nil
end)
