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
        Identifiers.Tokens[i] = GetPlayerToken(source, i)
    end

    exports.oxmysql:execute("SELECT PermID FROM Users WHERE Identifier = @identifier", {
        ["@identifier"] = Identifiers.Identifier
    }, function(result)
        if next(result) then
            Identifiers.PermID = result
        end
		cb(Identifiers)
    end)
end