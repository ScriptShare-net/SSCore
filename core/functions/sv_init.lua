SS = SS or {}
SS.ServerCallbacks = SS.ServerCallbacks or {}

RegisterServerEvent("SS:Server:Callback", function(name, requestId, ...)
	local src = source

	SS.TriggerServerCallback(name, requestId, src, function(...)
		TriggerClientEvent("SS:Client:Callback", src, requestId, ...)
	end, ...)
end)

SS.RegisterServerCallback = function(name, cb)
	SS.ServerCallbacks[name] = cb
end

SS.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if SS.ServerCallbacks[name] then
		SS.ServerCallbacks[name](source, cb, ...)
	end
end