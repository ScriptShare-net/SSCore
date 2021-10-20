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

local function findDuplicateIdentifiers(identifiers1, identifiers2)
	local encodeIdentifiers = json.encode(identifiers2)
	for _, id in pairs(identifiers1) do
		if string.match(encodeIdentifiers, id) then
			return true
		end
	end
	return false
end

local function mergeIdentifiers(identifiers1, identifiers2)
	local identifiers = {}
	for type, idtable in pairs(identifiers1) do
		identifiers[type] = identifiers[type] or {}
		for _, id in pairs(idtable) do
			if not string.match(json.encode(identifiers2[type]), id) then
				identifiers[type][#identifiers[type] + 1] = id
			end
		end
	end
	return identifiers
end

local function isIdentifiersBanned(identifiers)
	local banList = {}
	for identifier, player in pairs(SS.Bans) do
		for type, idtable in pairs(identifiers) do
			if findDuplicateIdentifiers(idtable, player) then
				banList[identifier] = player
			end
		end
	end
	return (#banList >= 1), banList
end

local function isBanned(identifier, permid)
	local banned = {}
	local identifiers = {}
	exports.oxmysql:execute("SELECT * FROM identifiers WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(result)
		for k,v in pairs(result) do
			identifiers[k] = json.decode(v)
		end
	end)
	local identifiersBanned, banList = isIdentifiersBanned(identifiers)
	if #banList > 1 then
		for bannedIdentifier, bannedIdentifiers in pairs(banList) do
			exports.oxmysql:execute("UPDATE bans SET identifiers = @identifiers, time = @time, reason = @reason, bannedBy = @bannedBy WHERE identifier = @identifier", {
				["@identifier"] = bannedIdentifier,
				["@identifiers"] = json.encode(mergeIdentifiers(bannedIdentifiers, identifiers)),
				["@time"] = 0,
				["@reason"] = "Attempting to ban evade",
				["@bannedBy"] = "Ban System"
			})
			SS.Bans[bannedIdentifier] = {
				identifier = bannedIdentifier,
				identifiers = bannedIdentifiers,
				time = 0,
				reason = "Attempting to ban evade",
				bannedBy = "Ban System"
			}
		end
	end
	local unbanTime
	local banLength
	if SS.Bans[identifier].time == 0 then
		unbanTime = "Never"
		banLength = "Forever"
	else
		unbanTime = os.date('%H:%M:%S %d-%m-%y', SS.Bans[identifier].time + (SS.TimeZone * 60 * 60))
		banLength = SS.Bans[identifier].time - os.time()
	end
	local banCard = {
		["type"] = "AdaptiveCard",
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.3",
		["body"] = {
			{
				["type"] = "Image",
				["url"] = SS.Queue.Banner
			},
			{
				["type"] = "TextBlock",
				["text"] = "You have been banned",
				["wrap"] = true,
				["weight"] = "Bolder"
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "90px",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = "Reason",
								["wrap"] = true,
								["weight"] = "Bolder"
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "stretch",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = SS.Bans[identifier].reason,
								["wrap"] = true
							}
						}
					}
				}
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "90px",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = "Unban Time",
								["wrap"] = true,
								["weight"] = "Bolder"
							}
						},
						["horizontalAlignment"] = "Center"
					},
					{
						["type"] = "Column",
						["width"] = "stretch",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = unbanTime,
								["wrap"] = true
							}
						}
					}
				}
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "90px",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = "Length",
								["wrap"] = true,
								["weight"] = "Bolder"
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "stretch",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = banLength,
								["wrap"] = true
							}
						}
					}
				}
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "90px",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = "Banned By",
								["wrap"] = true,
								["weight"] = "Bolder"
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "stretch",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = SS.Bans[identifier].bannedBy,
								["wrap"] = true
							}
						}
					}
				}
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "90px",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = "Account ID",
								["wrap"] = true,
								["weight"] = "Bolder"
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "stretch",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = permid,
								["wrap"] = true
							}
						}
					}
				}
			},
			{
				["type"] = "ActionSet",
				["actions"] = {
					{
						["type"] = "Action.OpenUrl",
						["title"] = "Ban Appeal",
						["url"] = SS.Queue.Appeal
					}
				}
			}
		}
	}

	return identifiersBanned, banCard
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
            DropPlayer(src, t["connectionError"])
        else
            local updateError = updateIdentifiers(identifiers)

			if updateError then
				DropPlayer(src, t["connectionError"])
			end
			
			local banned, banCard = isBanned(identifiers.identifier, identifiers.permid)
			
			if banned then
				deferrals.presentCard(banCard, function(data, rawData) end)
				Wait(6000)
				setReason("Banned")
			end
        end
    end
end)

