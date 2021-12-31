local next = next
local slotsFilled = 0
local Queue = {}
local deferralsList = {}
local srcs = {}

local function createUser(identifiers, cb)
	MySQL.query("INSERT INTO Users (Identifier, Name) VALUES (@identifier, @name)", {
		["@identifier"] = identifiers.Identifier,
		["@name"] = GetPlayerName(identifiers.Source)
	}, function(result)
		MySQL.query("INSERT INTO Identifiers (PermID, Identifier, GTAs, Steams, Lives, Xboxs, FiveMs, IPs, Discords, GTA2s, Tokens) VALUES (@permid, @identifier, @gtas, @steams, @lives, @xboxs, @fivems, @ips, @discords, @gta2s, @tokens)", {
			["@permid"] = result.insertId,
			["@identifier"] = identifiers.Identifier,
			["@gtas"] = json.encode({identifiers.GTA}),
			["@steams"] = json.encode({identifiers.Steam}),
			["@xboxs"] = json.encode({identifiers.Xbox}),
			["@ips"] = json.encode({identifiers.IP}),
			["@lives"] = json.encode({identifiers.Live}),
			["@fivems"] = json.encode({identifiers.FiveM}),
			["@discords"] = json.encode({identifiers.Discord}),
			["@gta2s"] = json.encode({identifiers.GTA2}),
			["@tokens"] = json.encode(identifiers.Tokens),
		}, function(rows)
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
		if type ~= "Identifier" and identifiers[string.sub(type, 1, -2)] then
			if not string.match(json.encode(idtable), identifiers[string.sub(type, 1, -2)]) then
				table.insert(identifierstable[type], identifiers[string.sub(type, 1, -2)])
			end
		end
	end
	return identifierstable
end

local function updateIdentifiers(identifiers, cb)
	MySQL.query("SELECT * FROM Identifiers WHERE Identifier = @identifier", {
		["@identifier"] = identifiers.Identifier
	}, function(result)
		if result[1] then
			local idtable = addIdentifiers(result[1], identifiers)
			MySQL.query("UPDATE Identifiers SET Discords = @discords, Steams = @steams, GTAs = @gtas, Tokens = @tokens, Lives = @lives, Xboxs = @xboxs, IPs = @ips, FiveMs = @fivems, GTA2s = @gta2s WHERE Identifier = @identifier", {
				["@identifier"] = identifiers.Identifier,
				["@discords"] = idtable.Discords,
				["@steams"] = idtable.Steams,
				["@gtas"] = idtable.GTAs,
				["@tokens"] = idtable.Tokens,
				["@lives"] = idtable.Lives,
				["@xboxs"] = idtable.Xboxs,
				["@ips"] = idtable.IPs,
				["@fivems"] = idtable.FiveMs,
				["@gta2s"] = idtable.GTA2s,
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
	for identifier, player in pairs(SS.Bans.List) do
		for type, idtable in pairs(identifiers) do
			if findDuplicateIdentifiers(idtable, player) then
				banList[identifier] = player
			end
		end
	end
	return (#banList >= 1), banList
end

local function isBanned(identifier, cb)
	local banned = {}
	local identifiers = {}
	local bancard
	MySQL.query("SELECT * FROM Identifiers WHERE Identifier = @identifier", {
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
					MySQL.query("UPDATE Bans SET Identifiers = @identifiers, Time = @time, Reason = @reason, Banner = @bannedBy WHERE Identifier = @identifier", {
						["@identifier"] = bannedIdentifier,
						["@identifiers"] = json.encode(addIdentifiers(bannedIdentifiers, identifiers)),
						["@time"] = 0,
						["@reason"] = "Attempting to ban evade",
						["@bannedBy"] = "Ban System"
					})
					SS.Bans.List[bannedIdentifier] = {
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
			if SS.Bans.List[identifier].time == 0 then
				unbanTime = "Never"
				banLength = "Forever"
			else
				unbanTime = os.date('%H:%M:%S %d-%m-%y', SS.Bans.List[identifier].time + (SS.TimeZone * 60 * 60))
				banLength = SS.Bans.List[identifier].time - os.time()
			end
			cb(identifiersBanned, SS.Connection.Cards.Ban(SS.Bans.List[identifier].reason, unbanTime, banLength, SS.Bans.List[identifier].bannedBy, identifiers.PermID))
			return
		end
	end)
	cb(false)
end

local function getRank(identifier, cb)
	local highestRank
	MySQL.query("SELECT Groups FROM Users WHERE Identifier = @identifier", {
		["@identifier"] = identifier
	}, function(groups)
		for _, name in pairs(groups) do
			for name2, groupdata in pairs(SS.Groups.List) do
				if name == name2 then
					if highestRank then
						if SS.Groups.List[highestRank] then
							if SS.Groups.List[highestRank] > groupdata.Priority then
								highestRank = name2
							end
						end
					else
						highestRank = name2
					end
				end
			end
		end
		if not highestRank and not SS.Config.Connection.Whitelist then
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
	local rank
	if not SS.Groups.List[queue] then
		rank = 10000
	else
		rank = SS.Groups.List[queue].Priority
	end
	for i = pos + 1, #Queue[rank], 1 do
		Queue[rank][i - 1] = Queue[rank][i]
	end
	Queue[rank][#Queue[rank]] = nil
	if not #Queue[rank] then
		Queue[rank] = nil
	end
	deferralsList[identifier] = nil
end

local function addToQueue(identifier, rank, deferrals)
	local queue
	if not SS.Groups.List[rank] then
		queue = 10000
	else
		queue = SS.Groups.List[rank].Priority
	end
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
	SS.Users.Create(identifier, srcs[identifier])
end

local function updateQueue(identifier)
	local currentQueue, lengthQueue, _, _ = positionInQueue(identifier)
	deferralsList[identifier].presentCard(SS.Connection.Cards.Queue(currentQueue, lengthQueue), function(data, rawData) end)
end

local function startConnection(identifiers, deferrals)
	updateIdentifiers(identifiers, function(updateError)
		if updateError then
			deferrals.done("connectionError")
			return
		end
		deferrals.update("Checking Ban Status.")
		isBanned(identifiers.Identifier, function(banned, banCard)
			if banned then
				deferrals.presentCard(banCard, function(data, rawData) end)
				Wait(6000)
				deferrals.done("banned")
				return
			end

			deferrals.update("Not Banned. Checking Rank.")
			getRank(identifiers.Identifier, function(highestRank)
				if not highestRank then
					deferrals.presentCard(SS.Connection.Cards.Whitelist, function(data, rawData) end)
					Wait(6000)
					deferrals.done("whitelist")
					return
				end

				if SS.Groups.List[highestRank] == 0 then
					deferrals.update("Connecting.")
					connectPlayer(identifiers.Identifier, deferrals, true)
					return
				end
				
				deferrals.update("Adding To Queue.")
				addToQueue(identifiers.Identifier, highestRank, deferrals)
			end)
		end)
	end)
end

AddEventHandler('playerConnecting', function(name, setReason, deferrals)
	deferrals.defer()

    local src = source

	deferrals.update("Checking Identifiers.")
    SS.GetPlayerIdentifiers(src, function(identifiers)
		srcs[identifiers.Identifier] = src
		if identifiers.PermID then
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
			if slotsFilled < SS.Config.Connection.Slots then
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

if SS.Config.Connection.Commands then
	RegisterCommand("Skip_Player", function(r, args, s)
		if args[1] then
			connectPlayer(args[1], deferralsList[args[1]], false)
		end
	end)

	RegisterCommand("Remove_Player", function(r, args, s)
		if args[1] then
			deferralsList[args[1]].done("removePlayer")
			removeFromQueue(args[1])
		end
	end)
end