SS.Characters.List = {}

RegisterNetEvent("SS:Server:PlayerDisconnect", function(src)
	if SS.Characters.List[src] then
		MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier", {
			["@identifier"] = SS.Characters.List[src].Identifier,
			["@metadata"] = json.encode(SS.Characters.List[src].MetaData)
		}, function(rows)
			SS.Characters.List[src] = nil
		end)
	end
end)

RegisterNetEvent("onResourceStop", function()
	TriggerEvent("SS:Server:Stop")
	for k,v in pairs(SS.Characters.List) do
		MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier", {
			["@identifier"] = v.Identifier,
			["@metadata"] = json.encode(v.MetaData)
		}, function(rows)
			SS.Characters.List[k] = nil
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(600000)
		for k,v in pairs(SS.Characters.List) do
			MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier", {
				["@identifier"] = v.Identifier,
				["@metadata"] = json.encode(v.MetaData)
			}, function(rows)
			end)
		end
	end
end)