SS.Bans = {}

Citizen.CreateThread(function()
	while true do
		exports.oxmysql:execute("SELECT * FROM bans", {}, function(bantable)
			if bantable then
				for k,v in pairs(bantable) do
					bantable[k].identifiers = json.decode(bantable[k].identifiers)
					SS.Bans[bantable[k].identifier] = bantable[k]
				end
			end
		end)
		Wait(300000)
	end
end)