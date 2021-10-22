RegisterNetEvent("ss:Server:SaveSkin", function(skin)
	local src = source
	if skin then
		exports.oxmysql:execute("UPDATE characters SET skin = @skin WHERE identifier = @identifier", {
			["@identifier"] = SS.Player.GetPlayerFromSource(src).identifer,
			["@skin"] = json.encode(skin),
		})
	end
end)