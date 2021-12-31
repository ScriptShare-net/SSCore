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