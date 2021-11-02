local next = next
local slotsFilled = 0
local Queue = {}
local deferralsList = {}

StopResource("hardcap")
StopResource("mapmanager")
StopResource("spawnmanager")
StopResource("sessionmanager")
StopResource("basic-gamemode")

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

local function plyId(source, cb)
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

    exports.oxmysql:execute("SELECT permid FROM users WHERE identifier = @identifier", {
        ["@identifier"] = identifiers[SS.Identifier]
    }, function(result)
        if next(result) then
            identifiers.permid = result
        end
		cb(identifiers)
    end)
end

local function createUser(identifiers, cb)
    exports.oxmysql:execute("INSERT INTO identifiers (identifier, gtas, steams, lives, xboxs, fivems, ips, discords, gta2s, tokens) VALUES (@identifier, @gtas, @steams, @lives, @xboxs, @fivems, @ips, @discords, @gta2s, @tokens)", {
		["@identifier"] = identifiers[SS.Identifier],
		["@gtas"] = json.encode({identifiers.gta}),
		["@steams"] = json.encode({identifiers.steam}),
		["@xboxs"] = json.encode({identifiers.xbox}),
		["@ips"] = json.encode({identifiers.ip}),
		["@lives"] = json.encode({identifiers.live}),
		["@fivems"] = json.encode({identifiers.fivem}),
		["@discords"] = json.encode({identifiers.discord}),
		["@gta2s"] = json.encode({identifiers.gta2}),
		["@tokens"] = json.encode({identifiers.tokens}),
	}, function(rows)
		exports.oxmysql:execute("INSERT INTO users (identifier) VALUES (@identifier)", {
			["@identifier"] = identifiers[SS.Identifier]
		}, function(result)
			cb(not (rows.affectedRows >= 1), not (result.affectedRows >= 1))
		end)
	end)
end

local function findDuplicateIdentifiers(identifiers1, identifiers2)
	local encodeIdentifiers = json.encode(identifiers2)
	for _, id in pairs(identifiers1) do
		if id ~= "nil" then
			if string.match(encodeIdentifiers, id) then
				return true
			end
		end
	end
	return false
end

local function addIdentifiers(idtable, identifiers)
	local identifierstable = idtable
	for type, idtbl in pairs(idtable) do
		if type ~= "identifier" and type ~= "tokens" and identifiers[string.sub(type, 1, -2)] then
			if not string.match(json.encode(idtable), identifiers[string.sub(type, 1, -2)]) then
				identifierstable[type][#identifierstable[type] + 1] = identifiers[string.sub(type, 1, -2)]
			end
		elseif type == "tokens" then
			identifierstable.tokens = json.decode(identifierstable.tokens) or {}
			for k, v in pairs(identifiers.tokens) do
				if not string.match(json.encode(idtable.tokens), v) then
					identifierstable.tokens[k] = identifierstable.tokens[k] or {}
					identifierstable.tokens[k][#identifierstable.tokens[k] + 1] = v
				end
			end
		end
	end
	return identifierstable
end

local function updateIdentifiers(identifiers, cb)
	exports.oxmysql:execute("SELECT * FROM identifiers WHERE identifier = @identifier", {
		["@identifier"] = identifiers[SS.Identifier]
	}, function(result)
		if result[1] then
			local idtable = addIdentifiers(result[1], identifiers)
			exports.oxmysql:execute("UPDATE identifiers SET discords = @discords, steams = @steams, gtas = @gtas, tokens = @tokens, lives = @lives, xboxs = @xboxs, ips = @ips, fivems = @fivems, gta2s = @gta2s WHERE identifier = @identifier", {
				["@identifier"] = identifiers[SS.Identifier],
				["@discords"] = idtable.discords,
				["@steams"] = idtable.steams,
				["@gtas"] = idtable.gtas,
				["@tokens"] = json.encode(idtable.tokens),
				["@lives"] = idtable.lives,
				["@xboxs"] = idtable.xboxs,
				["@ips"] = idtable.ips,
				["@fivems"] = idtable.fivems,
				["@gta2s"] = idtable.gta2s,
			}, function(rows)
				cb(not (rows.affectedRows >= 1))
			end)
		else
			cb(false)
		end
	end)
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

local function isBanned(identifier, permid, cb)
	local banned = {}
	local identifiers = {}
	exports.oxmysql:execute("SELECT * FROM identifiers WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(result)
		if not result then return false end
		for k,v in pairs(result) do
			identifiers[k] = v
		end

		local identifiersBanned, banList = isIdentifiersBanned(identifiers)
		if identifiersBanned then
			if #banList > 1 then
				for bannedIdentifier, bannedIdentifiers in pairs(banList) do
					exports.oxmysql:execute("UPDATE bans SET identifiers = @identifiers, time = @time, reason = @reason, bannedBy = @bannedBy WHERE identifier = @identifier", {
						["@identifier"] = bannedIdentifier,
						["@identifiers"] = json.encode(addIdentifiers(bannedIdentifiers, identifiers)),
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
		end
	end)
	cb(identifiersBanned, banCard)
end

local function getRank(identifier, cb)
	local highestRank
	exports.oxmysql:execute("SELECT groups FROM users WHERE identifier = @identifier", {
		["@identifier"] = identifier
	}, function(groups)
		for _, name in pairs(groups) do
			for name2, prio in pairs(SS.Queue.Ranks) do
				if name == name2 then
					if highestRank then
						if SS.Queue.Ranks[highestRank] then
							if SS.Queue.Ranks[highestRank] > prio then
								highestRank = name2
							end
						end
					else
						highestRank = name2
					end
				end
			end
		end
		if not highestRank and not SS.Queue.Whitelist then
			highestRank = "none"
		end
		cb(highestRank)
	end)
end

local function inQueue(identifier)
	return string.match(json.encode(Queue), identifier)
end

local function positionInQueue(identifier)
	local position = 0
	local length = 0
	for prio, queue in pairs(Queue) do
		length = length + #queue
		if string.match(json.encode(queue), identifier) then
			for pos, playertbl in pairs(queue) do
				position = position + 1
				for id, rank in pairs(playertbl) do
					if id == identifier then
						return position, length, rank, pos
					end
				end
			end
		else
			position = position + #queue
		end
	end
end

local function getFirstInQueue()
	for prio, queue in pairs(Queue) do
		for pos, playertbl in pairs(queue) do
			for id, rank in pairs(playertbl) do
				return id
			end
		end
	end
end

local function removeFromQueue(identifier)
	local _, _, queue, pos = positionInQueue(identifier)
	local rank = SS.Queue.Ranks[queue] or 10000
	for i = pos + 1, #Queue[rank], 1 do
		Queue[rank][i - 1] = Queue[rank][i]
	end
	Queue[rank][#Queue[rank]] = nil
	if not #Queue[rank] then
		Queue[rank] = nil
	end
	deferralsList[identifier] = nil
end

local function addToQueue(identifier, rank, deferrals, src)
	local queue = SS.Queue.Ranks[rank] or 10000
	Queue[queue] = Queue[queue] or {}
	local position = #Queue[queue] + 1
	Queue[queue][position] = Queue[queue][position] or {}
	Queue[queue][position][identifier] = rank
	deferralsList[identifier] = deferrals
end

local function connectPlayer(identifier, deferrals, noSlot)
	deferrals.done()
	if not noSlot then
		slotsFilled = slotsFilled + 1
	end

	if inQueue(identifier) then
		removeFromQueue(identifier)
	end
end

local function updateQueue(identifier)
	local currentQueue, lengthQueue, _, _ = positionInQueue(identifier)
	local queueCard = {
		["type"] = "AdaptiveCard",
		["body"] = {
			{
				["type"] = "Image",
				["url"] = SS.Queue.Banner
			},
			{
				["type"] = "TextBlock",
				["size"] = "Medium",
				["weight"] = "Bolder",
				["text"] = "Supremacy FiveM",
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "TextBlock",
				["text"] = "Welcome to Supremacy FiveM.",
				["wrap"] = true,
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "TextBlock",
				["text"] = "Thank you for choosing our server.",
				["wrap"] = true,
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "TextBlock",
								["text"] = "Current Queue:",
								["wrap"] = true,
								["horizontalAlignment"] = "Center"
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "ColumnSet",
								["columns"] = {
									{
										["type"] = "Column",
										["width"] = "auto",
										["items"] = {
											{
												["type"] = "TextBlock",
												["text"] = tostring(currentQueue),
												["wrap"] = true,
												["horizontalAlignment"] = "Center"
											}
										}
									},
									{
										["type"] = "Column",
										["width"] = "auto",
										["items"] = {
											{
												["type"] = "TextBlock",
												["text"] = "/",
												["wrap"] = true,
												["horizontalAlignment"] = "Center",
												["separator"] = true,
												["height"] = "stretch"
											}
										}
									},
									{
										["type"] = "Column",
										["width"] = "auto",
										["items"] = {
											{
												["type"] = "TextBlock",
												["text"] = tostring(lengthQueue),
												["wrap"] = true,
												["horizontalAlignment"] = "Center",
												["height"] = "stretch"
											}
										}
									}
								}
							}
						}
					}
				},
				["horizontalAlignment"] = "Center"
			},
			{
				["type"] = "ColumnSet",
				["columns"] = {
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "ActionSet",
								["actions"] = {
									{
										["type"] = "Action.OpenUrl",
										["title"] = "Forum",
										["url"] = SS.Queue.Forum
									}
								}
							}
						}
					},
					{
						["type"] = "Column",
						["width"] = "auto",
						["items"] = {
							{
								["type"] = "ActionSet",
								["actions"] = {
									{
										["type"] = "Action.OpenUrl",
										["title"] = "Discord",
										["url"] = SS.Queue.Discord
									}
								}
							}
						}
					}
				},
				["horizontalAlignment"] = "Center"
			}
		},
		["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
		["version"] = "1.3"
	}
	deferralsList[identifier].presentCard(queueCard, function(data, rawData) end)
end

local function startConnection(identifiers, deferrals)
	updateIdentifiers(identifiers, function(updateError)
		if updateError then
			deferrals.done("connectionError")
			return
		end
		deferrals.update("Checking Ban Status.")
		isBanned(identifiers[SS.Identifier], identifiers.permid, function(banned, banCard)
			if banned then
				deferrals.presentCard(banCard, function(data, rawData) end)
				Wait(6000)
				deferrals.done("banned")
				return
			end

			deferrals.update("Not Banned. Checking Rank.")
			getRank(identifiers[SS.Identifier], function(highestRank)
				if not highestRank then
					deferrals.presentCard(whitelistCard, function(data, rawData) end)
					Wait(6000)
					deferrals.done("whitelist")
					return
				end

				if SS.Queue.Ranks[highestRank] == 0 then
					deferrals.update("Connecting.")
					connectPlayer(identifiers[SS.Identifier], deferrals, true)
					return
				end
				
				deferrals.update("Adding To Queue.")
				addToQueue(identifiers[SS.Identifier], highestRank, deferrals, identifiers.source)
			end)
		end)
	end)
end

AddEventHandler('playerConnecting', function(name, setReason, deferrals)
	deferrals.defer()

    local src = source

	deferrals.update("Checking Identifiers.")
    plyId(src, function(identifiers)
		if identifiers.permid then
			deferrals.update("Found Identifiers. Starting Connection.")
			startConnection(identifiers, deferrals)
		else
			deferrals.update("No Identifiers Found. Creating User.")
			createUser(identifiers, function(idError, userError)
				if idError or userError then 
					deferrals.done("connect error")
					return
				end

				deferrals.update("User Created. Starting Connection.")
				startConnection(identifiers, deferrals)
			end)
		end
	end)
end)

AddEventHandler('playerDropped', function()
	local src = source
	slotsFilled = slotsFilled - 1
	TriggerEvent("SS:Server:PlayerDisconnect", src)
end)

CreateThread(function()
	while true do
		Wait(500)
		if getFirstInQueue() then
			if slotsFilled < SS.Queue.Slots then
				connectPlayer(getFirstInQueue(), deferralsList[getFirstInQueue()], false)
			else
				Wait(2000)
			end
			for identifier, deferrals in pairs(deferralsList) do
				updateQueue(identifier)
			end
		else
			Wait(10000)
		end
	end
end)

if SS.Queue.SkipPlayer then
	RegisterCommand("Skip_Player", function(r, args, s)
		if args[1] then
			connectPlayer(args[1], deferralsList[args[1]], false)
		end
	end)
end

if SS.Queue.RemovePlayer then
	RegisterCommand("Remove_Player", function(r, args, s)
		if args[1] then
			deferralsList[args[1]].done("removePlayer")
			removeFromQueue(args[1])
		end
	end)
end