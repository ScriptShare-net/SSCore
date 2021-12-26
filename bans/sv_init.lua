SS.Bans.List = {}

SS.Bans.GetList = function()
    return SS.Bans.List
end

SS.Bans.BanPlayer = function(source, time, reason, banner)
    local identifiers = SS.GetPlayerIdentifiers(source)
    exports.oxmysql:execute("UPDATE Bans SET Identifiers = @identifiers, Time = @time, Reason = @reason, Banner = @bannedBy WHERE Identifier = @identifier", {
        ["@identifier"] = identifiers.Identifier,
        ["@identifiers"] = json.encode(identifiers),--needs to ban all identifiers
        ["@time"] = time,
        ["@reason"] = reason,
        ["@bannedBy"] = banner
    })
    SS.Bans.List[identifiers.Identifier] = {
        identifier = identifiers.Identifier,
        identifiers = identifiers,
        time = time,
        reason = reason,
        bannedBy = banner
    }
end

Citizen.CreateThread(function()
    exports.oxmysql:execute("SELECT * FROM Bans", {}, function(bantable)
        if bantable then
            for k,v in pairs(bantable) do
                bantable[k].Identifiers = json.decode(bantable[k].Identifiers)
                SS.Bans.List[bantable[k].Identifier] = bantable[k]
            end
        end
    end)
end)