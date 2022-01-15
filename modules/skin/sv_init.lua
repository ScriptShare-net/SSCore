local SSCore = exports["SSCore"]
if SSCore:GetConfigValue("Skin") then
	RegisterNetEvent("SS:Server:SaveSkin", function(skin)
		local src = source
		if skin then
			SSCore:setCharacterMetaData(src, "Skin", skin)
			local xPlayer = SSCore:GetCharacterFromSource(src)
			print(xPlayer.MetaData.Skin.model)
		end
	end)
end