local SSCore = exports["SSCore"] -- Creating a variable for our export so we can make the code look nicer. Also easier to write.
local Bans = {} -- Our local ban table that stores all the bans

exports("GetBans", function() -- Get bans export that sends the requester the bans table
    return Bans -- Sending bans table to function
end)

exports("AddBan", function(identifier, identifiers, time, reason, by) -- Add ban export that bans people manually. Used for connection script to ban ban evaders
	if not Bans[identifier] then -- Check if the ban doesn't exist already
		MySQL.query("INSERT INTO Bans (Identifier, Identifiers, Time, Reason, Banner) VALUES(@identifier, @identifiers, @time, @reason, @bannedBy", { -- MySQL query to add the ban to the database
			["@identifier"] = identifier, -- identifier of the banned player
			["@identifiers"] = json.encode(identifiers), -- encoded table of all the players identifiers
			["@time"] = time, -- how long to ban for in ms. 0 being for ever
			["@reason"] = reason, -- the reason that the player was banned
			["@bannedBy"] = by -- who the player was banned by
		}, function(rows) -- in insert sql it returns how many rows have been altered
			if rows > 0 then -- check if at least 1 row has been altered which means our ban was added
				Bans[identifier] = { -- setting the players identifier as the index
					identifier = identifier, -- putting the players identifier in the table
					identifiers = identifiers, -- putting all the players identifiers in the table
					time = time, -- putting how long the ban is for
					reason = reason, -- putting why the ban happened
					bannedBy = by, -- putting who banned the player
				}
			else -- If no rows where changed
				SSCore:Alert("Error banning player identifier: " .. identifier) -- Alert the console that there was an error banning the player in sql
		end)
	end
end)

exports("IsIdentifiersBanned", function(identifiers) -- Is identifiers banned export that checks if any of the players identifiers are matching with a banned identifier
	local banList = {} -- creating our temporary ban list
	for identifier, player in pairs(Bans) do -- iterating through each of our bans
		for type, idtable in pairs(identifiers) do -- iterating through each identifier type
			if type ~= "identifier" and type ~= "permid" then -- check if the identifier and permid isnt the type because they are not tables
				if SSCore:FindDuplicateIdentifiers(idtable, player) then -- check to see if it can find any duplicate identifiers of both tables
					banList[identifier] = player -- update our temp ban list with the banned matching player
				end
			end
		end
	end
	return (#banList >= 1), banList -- send the requester if one of the identifiers is banned. also sends them the ban list of where it matched
end)

exports("IsIdentifierBanned", function(identifier) -- Is identifier banned export that checks if the identifier is banned. Not as good as IsIdentifiersBanned because it doesn't check tokens and other identifiers so people can bypass this system
    local banList = {} -- creating our temporary ban list
	for iden, player in pairs(Bans) do -- iterating through each of our bans
		if type ~= "identifier" and type ~= "permid" then -- check if the identifier and permid isnt the type because they are not tables
			if string.match(json.encode(player), identifier) > 0 then -- check to see if it can find our identifier in the table
				banList[iden] = player -- update our temp ban list with the banned matching player
			end
		end
	end
	return (#banList >= 1), banList -- send the requester if one of the identifiers is banned. also sends them the ban list of where it matched
end)

exports("GetBanFromIdentifier", function(identifier) -- Get ban from identifier export that gets the ban data for that identifier
    return Bans[identifier] -- send the requester the ban data
end)

exports("BanPlayer", function(source, time, reason, banner) -- Ban player export that is used to ban a player from their source
    local user = SSCore:GetUserFromSource(source) -- Get the user data from the source
	MySQL.query("INSERT INTO Bans (Identifier, Identifiers, Time, Reason, Banner) VALUES(@identifier, @identifiers, @time, @reason, @bannedBy", { -- mysql query to add the ban to the database
        ["@identifier"] = user.Identifier, -- the user identifier to ban
        ["@identifiers"] = json.encode(user.AllIdentifiers), -- the list of all the identifiers of the user to ban
        ["@time"] = time, -- how long to ban for in ms
        ["@reason"] = reason, -- reason for ban
        ["@bannedBy"] = banner -- who banned the user
    }, function(rows) -- in insert sql it returns how many rows have been altered
		if rows > 0 then -- check if any rows where changed
			Bans[user.Identifier] = { -- setting the users identifier as the index
				identifier = user.Identifier, -- putting the identifier into the table
				identifiers = user.AllIdentifiers, -- putting the identifiers into the table
				time = time, -- putting the time into the table
				reason = reason, -- putting the reason into the table
				bannedBy = banner -- putting the banner into the table
			}
		else -- If no rows where changed
			SSCore:Alert("Error banning player source: " .. source) -- Alert the console that there was an issue updating the sql
		end
	end)
end)

exports("UnBanPlayer", function(identifier) -- unban player export that unbans the player from their identifier
	local isBanned, banTable = SSCore:IsIdentifierBanned(identifier) -- get if the identifier is banned and the tables if so
	if isBanned then -- if the identifier is banned
		for k,v in pairs(banTable) do -- iterate through our ban table
			Bans[k] = nil -- remove from the local ban table
			MySQL.query("DELETE FROM Bans WHERE Identifier = @identifier", { -- mysql query to delete the ban from the database
				["@identifier"] = k, -- the identifier of the ban to delete
			})
		end
	end
end)

CreateThread(function() -- function to run parallel
    MySQL.query("SELECT * FROM Bans", {}, function(bantable) -- mysql query that gets all the bans saved in the database
        if bantable then -- if there is any bans
            for k,v in pairs(bantable) do -- iterate through the bans
                bantable[k].Identifiers = json.decode(bantable[k].Identifiers) -- decode the identifiers
                Bans[bantable[k].Identifier] = bantable[k] -- add the ban to our local ban table
            end
        end
    end)
end)