local SSCore = exports["SSCore"] -- Shorting the export so we dont have to type it out everytime and instead we can just use SSCore:ExportFunctionName()
local Characters = {} -- Creating our local Characters table to store all our users character data

exports("CreateCharacter", function(identifiers, source, characterID) -- Our CreateCharacter export that allows a character selector system create the character when needed
    Characters[source] = nil -- Clearing the character data for that source to make sure if they have switched character we dont accidently get the old data
    local self = {} -- Creating a temporary local variable to store out players data in so we can give it to the Characters table at the end

    self.PermID = identifiers.PermID -- This is the Permenant ID of a player. This starts at 1 and goes up the more people join. Can be found in the database as the primary key
    self.Source = source -- Saving the players source so we can work out who the other identifiers belong to in game
    self.Identifier = identifiers.Identifier -- This is the identifier that we use to determine what data is saved where. By default this is discord which means creating a new discord will make a new set of characters.
    self.Identifiers = identifiers -- This is all the other identifiers which we use to check identity and bans
    self.CharID = characterID -- This is the character slot of the selected character
	self.FirstName = "" -- Empty First Name variable so we can edit it later
	self.LastName = "" -- Empty Last Name variable so we can edit it later
    self.MetaData = {} -- The core data table for our players. This saves any addon data that other peoples scripts need
	self.MetaData.name = self.FirstName .. " " .. self.LastName -- Defining a blank variable so we can edit it later
	self.rank = "user" -- The characters permission level: user, admin, owner
	self.job = "Unemployed" -- Defining a blank variable so we can edit it later
	self.grade = 0 -- Job grade is 0 by default

	-- Rank Functions -- 
	self.SetRank = function(rank)
		if not rank then return end 
		self.rank = rank
	end

	self.GetRank = function()
		return self.rank
	end
	-- Job Functions -- 
	self.SetJob = function(job)
		if not job then return end 
		self.job = job
	end

	self.GetJob = function(job)
		if not job then return end 
		return self.job
	end

	-- Grade Functions -- 
	self.SetGrade = function(grade)
		if not grade then return end 
		self.grade = grade
	end

	self.GetGrade = function()
		return self.grade
	end 

    -- Name Functions -- 
    self.GetName = function() -- This function is used so people can get our characters full name
        return self.MetaData.name -- Sending the function our full name variable
    end
	
    self.GetFirstName = function() -- This function is used so people can get the characters first name only
        return self.FirstName -- Sending the function our first name variable
    end
	
    self.SetFirstName = function(firstname) -- This function is used to change the characters first name
        self.FirstName = firstname -- Updating our first name variable
        self.MetaData.name = self.FirstName .. " " .. self.LastName -- updating our full name variable as well
    end
	
    self.GetLastName = function() -- This function is used so people can get the characters last name only
        return self.LastName -- Sending the function our last name variable
    end
	
    self.SetLastName = function(lastname) -- This function is used to change the characters last name
        self.LastName = lastname -- Updating the characters first name
        self.MetaData.name = self.FirstName .. " " .. self.LastName -- Updating the characters full name
    end	
	
    -- Perm ID Functions --
    self.GetPermID = function() -- This function is used so people can get the characters perm id
        return self.PermID -- Sending the function our permid variable
    end

    -- MetaData --
    self.GetMetaData = function(tblname) -- This function is used so people can get the metadata tables for example xp, hunger etc.
        if tblname then -- Check if the script wants just one sub metadata table
            return self.MetaData[tblname] -- Sending the function our sub metadata table
        else
            return self.MetaData -- Sending the player our full metadata table if no sub table was specified
        end
    end

    self.SetMetaData = function(tblname, tblvalue) -- This function is used to update or create a sub metadata table
        self.MetaData[tblname] = tblvalue -- Updating our metadata table with a sub table and setting its value
    end
	
	MySQL.query("SELECT * FROM Characters WHERE Identifier = @identifier AND CharacterSlot = @charslot", { -- MySQL query to get all the characters from the data base that have the same identifier and character slot
		["@identifier"] = self.Identifier, -- Identifier of the character we want to get
		["@charslot"] = self.CharID, -- Character slot of the character we want to get
	}, function(result) -- Set result as our result
		if result[1] then -- Check if result is not empty
			self.FirstName = result[1].FirstName -- Update our characters first name with the one saved from the database
			self.LastName = result[1].LastName -- Update our characters last name with the one saved from the database
			self.MetaData = json.decode(result[1].MetaData) -- Update our characters metadata table with the decoded one saved from the database
			self.MetaData.name = self.FirstName .. " " .. self.LastName -- Update our characters full name based on the new first and last name
		end
		Characters[source] = self -- Now that our characters loaded its data we can now set our character in the characters table with source as our identifier
		SSCore:Alert("Created Character: "..source) -- Print in console that our character has been created
		TriggerEvent("SS:Server:CharacterCreated", source) -- Send a network event on the server to other scripts letting them know the character has been set
	end)
end)

exports("GetCharacters", function() -- Our get characters export that gives us the table full of characters
	return Characters -- Sending the characters table to the function
end)

exports("GetPlayers", function()
	local sources = {} -- Creating a temporary table to store player sources in

	for k, v in pairs(Characters) do 
		sources[#sources + 1] = k
	end

	return sources
end)

exports("GetCharacterFromSource", function(source) -- Our get character from source export that allows people to define which character they want to get the table of
	return Characters[source] -- Sending the character to the fuction
end)

exports("SetCharacterMetaData", function(source, tblname, metadata) -- Our set character metadata export that allows people to update the sub metadata tables of a character. Used for hunger etc
	Characters[source].MetaData[tblname] = metadata -- Update the characters sub metadata table
end)

RegisterNetEvent("SS:Server:PlayerDisconnect", function(src) -- Network event checking for when a player has disconnected
	if Characters[src] then -- Check if the player has a character saved
		MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier AND CharacterSlot = @charslot", { -- MySQL query to update the metadata of the charcter with the same identifier and character slot
			["@identifier"] = Characters[src].Identifier, -- The identifier of the character from the source of the disconnected player
			["@charslot"] = Characters[src].CharID, -- The character id of the character from the source of the disconnected player
			["@metadata"] = json.encode(Characters[src].MetaData) -- The encoded metadata table of the character from the source of the disconnected player
		}, function(rows) -- Set our result as rows
			Characters[src] = nil -- Remove the character of the user from the characters table
			print("Player Left Updated Character: ", src) -- Debugging
		end)
	end
end)

RegisterNetEvent("onResourceStop", function(resourceName) -- Network event checking for when a resource is stopped. This is used to save all the player data on restart
	if GetCurrentResourceName() == resourceName then -- Check if our resource has the same name as the stopped resource
		TriggerEvent("SS:Server:Stop") -- Send a network event letting all the scripts know the resource is stopped
		print("Update Characters") -- Debugging
		for k,v in pairs(Characters) do -- Iterating through each character in the character table
			MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier AND CharacterSlot = @charslot", { -- MySQL query to update the characters metadata with the same identifier and character slot
				["@identifier"] = v.Identifier, -- Identifier of the iterated character
				["@charslot"] = v.CharID, -- Character id of the iterated character
				["@metadata"] = json.encode(v.MetaData) -- Encoded metadata table of the iterated character
			}, function()
				Characters[k] = nil -- Once updated remove the character from the table
			end)
		end
	end
end)

CreateThread(function() -- Create a function to run parallel with the current code. This code should be changed to run based on when a player joins so it doesnt slow the server down updating all the characters at once
	while true do -- Loop forever
		Wait(600000) -- Pause for 10 minutes
		print("Update Characters") -- Debugging
		for k,v in pairs(Characters) do -- Iterate through our character table
			MySQL.query("UPDATE Characters SET MetaData = @metadata WHERE Identifier = @identifier AND CharacterSlot = @charslot", { -- MySQL query to update the characters metadata with the same identifier and character slot
				["@identifier"] = v.Identifier, -- Identifier of the iterated character
				["@charslot"] = v.CharID, -- Character id of the iterated character
				["@metadata"] = json.encode(v.MetaData) -- Encoded metadata table of the iterated character
			}, function(rows)
			end)
		end
	end
end)