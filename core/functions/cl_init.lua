SS = SS or {}
SS.ServerCallbacks = SS.ServerCallbacks or {}
SS.CurrentRequestId = 0

SS.TriggerServerCallback = function(name, cb, ...)
	SS.ServerCallbacks[SS.CurrentRequestId] = cb

	TriggerServerEvent('SS:triggerServerCallback', name, SS.CurrentRequestId, ...)

	if SS.CurrentRequestId < 65535 then
		SS.CurrentRequestId = SS.CurrentRequestId + 1
	else
		SS.CurrentRequestId = 0
	end
end