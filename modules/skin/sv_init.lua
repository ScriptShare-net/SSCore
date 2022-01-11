local SSCore = exports["SSCore"]
if SSCore:GetConfigValue("Skin") then
	RegisterNetEvent("SS:Server:SaveSkin", function(skin)
		local src = source
		if skin then
			local xPlayer = SSCore:GetCharacterFromSource(src)
			xPlayer.MetaData.Skin = skin
		end
	end)
end