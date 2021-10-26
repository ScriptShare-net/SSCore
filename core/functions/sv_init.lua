SS = SS or {}
SS.ServerCallbacks = SS.ServerCallbacks or {}

RegisterServerEvent('SS:triggerServerCallback')
AddEventHandler('SS:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	SS.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('SS:serverCallback', playerId, requestId, ...)
	end, ...)
end)

SS.RegisterServerCallback = function(name, cb)
	SS.ServerCallbacks[name] = cb
end

SS.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if SS.ServerCallbacks[name] then
		SS.ServerCallbacks[name](source, cb, ...)
	else
		print(('[RSG] [^3WARNING^7] Server callback "%s" does not exist. Make sure that the server sided file really is loading, an error in that file might cause it to not load.'):format(name))
	end
end