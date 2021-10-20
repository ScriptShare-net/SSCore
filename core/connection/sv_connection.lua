local whitelistCard = {
    ["type"] = "AdaptiveCard",
    ["body"] = {
        {
            ["type"] = "TextBlock",
            ["size"] = "Medium",
            ["weight"] = "Bolder",
            ["text"] = "Welcome to " .. SS.ServerName
        },
        {
            ["type"] = "TextBlock",
            ["text"] = "Thanks for joining. Sorry to be a bother but our server is currently discord whitelist. Basically all you need to do is join the discord and you can play. We have made it super simple. All you need to do is click the button below and join.",
            ["wrap"] = true
        }
    },
    ["actions"] = {
        {
            ["type"] = "Action.OpenUrl",
            ["title"] = "Join Discord",
            ["url"] = SS.Queue.Discord
        }
    },
    ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
    ["version"] = "1.3"
}

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
        identifiers.tokens[i] = GetPlayerToken(source, i)
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

local function createUser(identifiers)
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

    exports.oxmysql:execute("INSERT INTO users (identifier) VALUES (@identifier)", {
        ["@identifier"] = identifiers[SS.Identifier]
    }, function(result)
        userError = not (result >= 1)
    end)

    return idError, userError
end

local function updateIdentifiers(identifiers)
	local updateError = false
	exports.oxmysql:execute("SELECT * FROM identifiers WHERE identifier = @identifier", {
		["@identifier"] = identifiers[SS.Identifier]
	}, function(result)
		if result then
			local idtable = result
			for k,v in pairs(idtable) do
				idtable[k] = json.decode(v)
				if identifiers[string.sub(k, 1, -2)] then
					local skip = false
					for k2,v2 in pairs(v) do
						if v2 == identifiers[string.sub(k, 1, -2)] then
							skip = true
						end
					end
					if not skip then
						idtable[k][#idtable[k] + 1] = identifiers[string.sub(k, 1, -2)]
					end
				end
				idtable[k] = json.encode(idtable[k])
			end
		end
	end)
	exports.oxmysql:execute("UPDATE identifiers SET discords = @discords, steams = @steams, gta5s = @gta5s, tokens = @tokens, lives = @lives, xboxs = @xboxs, ips = @ips, fivems = @fivems, gta2s = @gta2s WHERE identifier = @identifier", {
		["@identifier"] = identifiers[SS.Identifier],
		["@discords"] = idtable.discords,
		["@steams"] = idtable.steams,
		["@gta5s"] = idtable.gta5s,
		["@tokens"] = idtable.tokens,
		["@lives"] = idtable.lives,
		["@xboxs"] = idtable.xboxs,
		["@ips"] = idtable.ips,
		["@fivems"] = idtable.fivems,
		["@gta2s"] = idtable.gta2s
	}, function(rows)
		updateError = not (rows >= 1)
	end)
	return updateError
end

local function findDuplicateIdentifier(identifier, identifiers)
	local idtbl = json.encode(identifiers)
	return string.match(idtbl, identifier)
end

local function mergeIdentifiers(identifiers1, identifiers2)
	local identifiers = {}
	for type, idtable in pairs(identifiers1) do
		for _, id in pairs(idtable) do
			if not findDuplicateIdentifier(id, identifiers2[type]) then
				identifiers[type] = identifiers[type] or {}
				identifiers[type][#identifiers[type] + 1] = id
			end
		end
	end
	return identifiers
end

local function isIdentifiersBanned(identifiers)
	for identifier, player in pairs(SS.Bans) do
		for type, idtable in pairs(identifiers) do
			for _, id in pairs(idtable) do
				return findDuplicateIdentifier(id, player), 
			end
		end
	end
end

local function isBanned(identifier)
	local banned = {}
	local identifiers = {}
	exports.oxmysql:execute("SELECT * FROM identifiers WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(result)
		for k,v in pairs(result) do
			identifiers[k] = json.decode(v)
		end
	end)
	for _, player in pairs(SS.Bans) do -- Cycle through all bans
		for type, ids in pairs(player.identifiers) do -- Go through each type of identifier
			for _, id in pairs(ids) do -- Go through each id in the type
				for _, id2 in pairs(identifiers[type]) do -- Go through each of my id in the type
					if id == id2 then -- Check if one of the matches
						banned[player.identifier] = mergeIdentifiers(player.identifiers, identifiers)
						break
					end
				end
			end
		end
	end
	if #banned >= 1 then
		local bannedids = {}
		if #banned > 1 then
			for iden, idtable in pairs(banned) do -- Go through all the banned accounts linked
				for type, ids in pairs(idtable) do -- Go through each type of identifier
					if not bannedids[type] then bannedids[type] = {} end
					for _, id in pairs(ids) do -- Go through each id in the type
						local skip = false
						for _, id2 in pairs(bannedids[type]) do
							if id == id2 then
								skip = true
							end
						end
						bannedids[type][#bannedids[type] + 1] = id
					end
				end
			end
		end
		for iden, idtable in pairs(banned) do
			exports.oxmysql:execute("UPDATE bans SET identifiers = @identifiers, time = @time, reason = @reason, bannedBy = @bannedBy WHERE identifier = @identifier", {
				["@identifier"] = iden,
				["@identifiers"] = json.encode(idtable),
				["@time"] = 0,
				["@reason"] = "Ban Evasion",
				["@bannedBy"] = "Ban System"
			}, function()
			
			end)
		end
	end
	return (#banned >= 1)
end

AddEventHandler('playerConnecting', function(name, setReason, deferrals)
	deferrals.defer()

    local src = source
    local identifiers = plyId(src)
    
    if identifiers.permid then 
        startConnection()
    else
        local idError, userError = createUser(identifiers)

        if idError or userError then 
            DropPlayer(src, t['connectionError'])
        else
            updateIdentifiers(identifiers)
        end
    end
end)

