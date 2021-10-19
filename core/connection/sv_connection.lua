local function plyId(source)
    local identifiers = {
        ["source"] = source,
        ["gta"] = "nil",
        ["steam"] = "nil",
        ["discord"] = "nil",
        ["live"] = "nil",
        ["xbox"] = "nil",
        ["fivem"] = "nil",
        ["ip"] = "nil",
        ["gta2"] = "nil",
        ["tokens"] = {},
    }

    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            identifiers.steam = string.sub(v, 7)
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            identifiers.gta = string.sub(v, 9)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifiers.discord = string.sub(v, 9)
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            identifiers.live = string.sub(v, 6)
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            identifiers.ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            identifiers.xbox = string.sub(v, 5)
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            identifiers.fivem = string.sub(v, 7)
        elseif string.sub(v, 1, string.len("license2:")) == "license2:" then
            identifiers.gta2 = string.sub(v, 10)
        else
            print("FOUND NEW IDENTIFIER: "..tostring(v))
        end
    end

    for i = 0, GetNumPlayerTokens(source) do
        identifers.tokens[i] = GetPlayerToken(source, i)
    end

    exports.oxmysql:execute("SELECT permid FROM users WHERE discord = @discord", {
        ["@discord"] = identifiers.discord
    }, function(result)
        if result then
            identifiers.permid = result
        end
    end)

    return identifiers
end

function createUser(identifiers)
    local idError = false
    local userError = false

    exports.oxmysql:execute("INSERT INTO identifiers (identifier, licences, steams, lives, xbls, fivems, ips, discords, licences2, tokens) VALUES (@identifier, @licences, @steams, @lives, @xbls, @fivems, @ips, @discords, @licences2, @tokens)", {
		["@licences"] = identifiers.licences,
		["@identifier"] = identifiers[SS.Identifier],
		["@steams"] = identifiers.steams,
		["@xbls"] = identifiers.xbls,
		["@ips"] = identifiers.ips,
		["@lives"] = identifiers.lives,
		["@fivems"] = identifiers.fivems,
		["@discords"] = identifiers.discords,
		["@licences2"] = identifiers.licences2,
		["@tokens"] = identifiers.tokens,
	}, function(rows)
		idError = not (rows >= 1)
	end)

    exports.oxmysql:execute("INSERT INTO users (identifier) VALUES (@identifer)", {
        ["@identifier"] = identifiers[SS.Identifier]
    }, function(result)
        userError = not (result >= 1)
    end)

    return idError, userError
end

AddEventHandler('playerConnecting', function()
    local src = source
    local identifiers = plyId(src)
    
    if identifiers.permid then 
        startConnection()
    else
        local idError, userError = createUser(identifiers)

        if idError or userError then 
            DropPlayer(src, t['connectionError'])
        else 
            
        end

    end

end)

