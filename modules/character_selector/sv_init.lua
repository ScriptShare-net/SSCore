if SS.Config.CharacterSelector then
	SS.Alert("Character Selector - Enabled")
	
	SS.CharacterSelector = {}

	RegisterNetEvent("SS:Server:ClientLoaded", function(src)
		SS.Alert("Client Loaded: " .. src)
	end)

end