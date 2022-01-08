local SSCore = exports["SSCore"]
local Bans = {}

exports("GetBans", function()
    return Bans
end)

exports("IsIdentifierBanned", function(identifier)
    return #Bans[identifier] > 0
end)

exports("GetBanFromIdentifier", function(identifier)
    return Bans[identifier]
end)

exports("BanPlayer", function(source, time, reason, banner)
    local user = SSCore:GetUserFromSource(source)
    MySQL.query("UPDATE Bans SET Identifiers = @identifiers, Time = @time, Reason = @reason, Banner = @bannedBy WHERE Identifier = @identifier", {
        ["@identifier"] = user.Identifier,
        ["@identifiers"] = json.encode(user.AllIdentifiers),--needs to ban every identifier linked and not just current identifiers
        ["@time"] = time,
        ["@reason"] = reason,
        ["@bannedBy"] = banner
    })
    Bans[user.Identifier] = {
        identifier = user.Identifierr,
        identifiers = user.AllIdentifiers,
        time = time,
        reason = reason,
        bannedBy = banner
    }
end

CreateThread(function()
    MySQL.query("SELECT * FROM Bans", {}, function(bantable)
        if bantable then
            for k,v in pairs(bantable) do
                bantable[k].Identifiers = json.decode(bantable[k].Identifiers)
                Bans[bantable[k].Identifier] = bantable[k]
            end
        end
    end)
end)