local SSCore = exports["SSCore"]

exports("createLog", function(type, message)
	TriggerServerEvent("SS:Server:createLog", type, message)
end)