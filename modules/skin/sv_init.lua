local SSCore = exports["SSCore"]
if SSCore:GetConfigValue("Skin") then
	RegisterNetEvent("SS:Server:SaveSkin", function(skin)
		local src = source
		if skin then
			SSCore:SetCharacterMetaData(src, "Skin", skin)
			local character = SSCore:GetCharacterFromSource(src)
		end
	end)
end