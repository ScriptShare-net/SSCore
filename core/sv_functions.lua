SS.GetPlayerIdentifiers = function(source, cb)
    local Identifiers = {
        ["Source"] = source,
        ["GTA"] = "nil",
        ["Steam"] = "nil",
        ["Discord"] = "nil",
        ["Live"] = "nil",
        ["Xbox"] = "nil",
        ["FiveM"] = "nil",
        ["IP"] = "nil",
        ["GTA2"] = "nil",
        ["Tokens"] = {},
    }

    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            Identifiers.Steam = string.sub(v, 7)
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            Identifiers.GTA = string.sub(v, 9)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            Identifiers.Discord = string.sub(v, 9)
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            Identifiers.Live = string.sub(v, 6)
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            Identifiers.IP = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            Identifiers.Xbox = string.sub(v, 5)
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            Identifiers.Fivem = string.sub(v, 7)
        elseif string.sub(v, 1, string.len("license2:")) == "license2:" then
            Identifiers.GTA2 = string.sub(v, 10)
        else
            print("FOUND NEW IDENTIFIER: "..tostring(v))
        end
    end
    
    Identifiers.Identifier = Identifiers[SS.Config.DefaultIdentifier]

    for i = 0, GetNumPlayerTokens(source) do
		table.insert(Identifiers.Tokens, GetPlayerToken(source, i))
    end

    MySQL.query("SELECT PermID FROM Users WHERE Identifier = @identifier", {
        ["@identifier"] = Identifiers.Identifier
    }, function(result)
        if next(result) then
            Identifiers.PermID = result[1].PermID
        end
		cb(Identifiers)
    end)
end

SS.Alert = function(string)
	if SS.Config.Alert then
		print("[^2SSCore^0] " .. string)
	end
end

SS.GetCharacterFromSource = function(source)
	return SS.Characters.List[source]
end

SS.GetPermIDFromIdentifier = function(identifier)
	for k, v in pairs(SS.Users.List) do
		if v.Identifier == identifier then
			return v.Identifiers.PermID
		end
	end
end

SS.ServerCallbacks = {}

RegisterServerEvent("SS:Server:Callback", function(name, requestId, ...)
	local src = source

	SS.TriggerServerCallback(name, requestId, src, function(...)
		TriggerClientEvent("SS:Client:Callback", src, requestId, ...)
	end, ...)
end)

SS.RegisterServerCallback = function(name, cb)
	SS.ServerCallbacks[name] = cb
end

SS.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if SS.ServerCallbacks[name] then
		SS.ServerCallbacks[name](source, cb, ...)
	end
end

if SS.Config.ConsolePrint then
	RegisterNetEvent("SS:Console:Print", function(string)
		print(string)
	end)
end