if SS.Config.Skin then
	SS.Skin = {}

	RegisterNetEvent("SS:Server:SaveSkin", function(skin)
		local src = source
		if skin then
			local xPlayer = SS.GetCharacterFromSource(src)
			xPlayer.MetaData.Skin = skin
		end
	end)
end